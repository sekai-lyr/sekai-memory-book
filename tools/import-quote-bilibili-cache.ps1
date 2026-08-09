param(
    [string]$CacheRoot = "E:\Blibli",
    [string]$FfmpegPath = "C:\Program Files\Tencent\QQBrowser\21.0.8365.400\ffmpeg\ffmpeg.exe",
    [string]$Database = "sekai_friend",
    [long]$UserId = 3,
    [string]$MysqlUser = "root",
    [string]$MysqlPassword = "123456",
    [switch]$Overwrite,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $CacheRoot)) {
    throw "Cache root not found: $CacheRoot"
}
if (-not (Test-Path -LiteralPath $FfmpegPath)) {
    throw "ffmpeg not found: $FfmpegPath"
}

$uploadRoot = Join-Path (Get-Location) "uploads\quote-videos"
$tempRoot = Join-Path (Get-Location) "target\quote-bilibili-cache-clean"
New-Item -ItemType Directory -Path $uploadRoot -Force | Out-Null
New-Item -ItemType Directory -Path $tempRoot -Force | Out-Null

function Copy-CleanM4s($source, $destination) {
    $inputStream = [System.IO.File]::OpenRead($source)
    try {
        $prefix = New-Object byte[] 9
        $read = $inputStream.Read($prefix, 0, 9)
        $hasBilibiliPrefix = $read -eq 9
        if ($hasBilibiliPrefix) {
            foreach ($value in $prefix) {
                if ($value -ne 0x30) {
                    $hasBilibiliPrefix = $false
                    break
                }
            }
        }
        if ($hasBilibiliPrefix) {
            $inputStream.Seek(9, [System.IO.SeekOrigin]::Begin) | Out-Null
        } else {
            $inputStream.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null
        }
        $outputStream = [System.IO.File]::Create($destination)
        try {
            $inputStream.CopyTo($outputStream)
        } finally {
            $outputStream.Dispose()
        }
    } finally {
        $inputStream.Dispose()
    }
}

function SqlLiteral([string]$value) {
    return "'" + ($value -replace "'", "''") + "'"
}

function Extract-VideoKey([string]$url) {
    if ([string]::IsNullOrWhiteSpace($url)) {
        return $null
    }
    if ($url -match "(?i)\b(BV[0-9A-Za-z]{10})\b") {
        return [pscustomobject]@{ Kind = "bvid"; Value = $Matches[1] }
    }
    if ($url -match "(?i)(?:/video/av|\bav)(\d{5,})") {
        return [pscustomobject]@{ Kind = "aid"; Value = $Matches[1] }
    }
    return $null
}

function Fetch-VideoDetail($key) {
    if ($key.Kind -eq "bvid") {
        $url = "https://api.bilibili.com/x/web-interface/view?bvid=$([uri]::EscapeDataString($key.Value))"
    } else {
        $url = "https://api.bilibili.com/x/web-interface/view?aid=$([uri]::EscapeDataString($key.Value))"
    }
    $headers = @{
        "User-Agent" = "Mozilla/5.0 SekaiMemory/1.0"
        "Referer" = "https://www.bilibili.com/"
    }
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try {
            $response = Invoke-RestMethod -Uri $url -Headers $headers -TimeoutSec 20
            if ($response.code -eq 0 -and $response.data) {
                return $response.data
            }
        } catch {
            Start-Sleep -Milliseconds (300 * $attempt)
        }
    }
    return $null
}

function Select-Page($detail, [string]$sourceUrl) {
    $pages = @($detail.pages)
    if ($pages.Count -eq 0) {
        return $null
    }
    $pageNumber = 1
    if ($sourceUrl -match "[?&]p=(\d+)") {
        $pageNumber = [int]$Matches[1]
    }
    $selected = $pages | Where-Object { $_.page -eq $pageNumber } | Select-Object -First 1
    if ($selected) {
        return $selected
    }
    return $pages | Select-Object -First 1
}

function Find-CachePair([string]$cid) {
    $dir = Join-Path $CacheRoot $cid
    if (-not (Test-Path -LiteralPath $dir)) {
        return $null
    }
    $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.m4s" -ErrorAction SilentlyContinue
    $video = $files |
        Where-Object { $_.Name -match "-1-(30080|100050|100051|100052|100053|100054|100060|100061|100062|100063|100064|30077|30078|30079)\.m4s$" } |
        Sort-Object Length -Descending |
        Select-Object -First 1
    $audio = $files |
        Where-Object { $_.Name -match "-1-30280\.m4s$" } |
        Sort-Object Length -Descending |
        Select-Object -First 1
    if ($video -and $audio) {
        return [pscustomobject]@{ Video = $video.FullName; Audio = $audio.FullName }
    }
    return $null
}

$env:MYSQL_PWD = $MysqlPassword
$query = "SELECT q.id,COALESCE(a.title,''),COALESCE(q.character_name,''),q.video_url FROM sekai_memory_book_quote q LEFT JOIN sekai_memory_book_anime a ON q.anime_id=a.id WHERE q.user_id=$UserId AND q.video_url IS NOT NULL AND q.video_url <> '' AND q.video_url NOT LIKE '/uploads/%' ORDER BY q.id"
$rows = mysql "--default-character-set=utf8mb4" "-u$MysqlUser" -N -B -D $Database -e $query

$quoteRows = New-Object System.Collections.Generic.List[object]
foreach ($line in $rows) {
    $parts = $line -split "`t", 4
    if ($parts.Count -lt 4) {
        continue
    }
    $key = Extract-VideoKey $parts[3]
    if ($key) {
        $quoteRows.Add([pscustomobject]@{
            Id = [long]$parts[0]
            AnimeTitle = $parts[1]
            CharacterName = $parts[2]
            SourceUrl = $parts[3]
            Key = $key
        }) | Out-Null
    }
}

$detailByKey = @{}
$items = New-Object System.Collections.Generic.List[object]
foreach ($quote in $quoteRows) {
    $uniqueKey = "$($quote.Key.Kind):$($quote.Key.Value.ToUpperInvariant())"
    if (-not $detailByKey.ContainsKey($uniqueKey)) {
        $detailByKey[$uniqueKey] = Fetch-VideoDetail $quote.Key
        Start-Sleep -Milliseconds 120
    }
    $detail = $detailByKey[$uniqueKey]
    if (-not $detail) {
        $items.Add([pscustomobject]@{ Id=$quote.Id; AnimeTitle=$quote.AnimeTitle; CharacterName=$quote.CharacterName; Status="detail-missing"; Cid=""; Output=""; SourceUrl=$quote.SourceUrl }) | Out-Null
        continue
    }
    $page = Select-Page $detail $quote.SourceUrl
    if (-not $page -or -not $page.cid) {
        $items.Add([pscustomobject]@{ Id=$quote.Id; AnimeTitle=$quote.AnimeTitle; CharacterName=$quote.CharacterName; Status="cid-missing"; Cid=""; Output=""; SourceUrl=$quote.SourceUrl }) | Out-Null
        continue
    }
    $cid = [string]$page.cid
    $pair = Find-CachePair $cid
    if (-not $pair) {
        $items.Add([pscustomobject]@{ Id=$quote.Id; AnimeTitle=$quote.AnimeTitle; CharacterName=$quote.CharacterName; Status="cache-missing"; Cid=$cid; Output=""; SourceUrl=$quote.SourceUrl }) | Out-Null
        continue
    }
    $outputName = "bilibili-quote-cid-$cid.mp4"
    $outputPath = Join-Path $uploadRoot $outputName
    $items.Add([pscustomobject]@{
        Id = $quote.Id
        AnimeTitle = $quote.AnimeTitle
        CharacterName = $quote.CharacterName
        Status = "ready"
        Cid = $cid
        Video = $pair.Video
        Audio = $pair.Audio
        OutputName = $outputName
        OutputPath = $outputPath
        LocalUrl = "/uploads/quote-videos/$outputName"
        SourceUrl = $quote.SourceUrl
    }) | Out-Null
}

$ready = @($items | Where-Object { $_.Status -eq "ready" })
$missing = @($items | Where-Object { $_.Status -ne "ready" })
$readyPath = Join-Path (Get-Location) "target\quote-bilibili-cache-ready.tsv"
$missingPath = Join-Path (Get-Location) "target\quote-bilibili-cache-missing.tsv"
$ready | Select-Object Id, AnimeTitle, CharacterName, Cid, LocalUrl, SourceUrl |
    Export-Csv -Path $readyPath -Delimiter "`t" -Encoding UTF8 -NoTypeInformation
$missing | Select-Object Id, AnimeTitle, CharacterName, Status, Cid, SourceUrl |
    Export-Csv -Path $missingPath -Delimiter "`t" -Encoding UTF8 -NoTypeInformation
Write-Host "QUOTE_ROWS=$($quoteRows.Count)"
Write-Host "READY_CACHE_MATCHES=$($ready.Count)"
Write-Host "MISSING=$($missing.Count)"
Write-Host "READY_MANIFEST=$readyPath"
Write-Host "MISSING_MANIFEST=$missingPath"
if ($missing.Count -gt 0) {
    $missing | Select-Object Id, AnimeTitle, CharacterName, Status, Cid, SourceUrl | Format-Table -AutoSize
}
if ($DryRun) {
    $ready | Select-Object Id, AnimeTitle, CharacterName, Cid, LocalUrl, SourceUrl | Format-Table -AutoSize
    return
}

$successByCid = @{}
$failures = New-Object System.Collections.Generic.List[object]
$readyByCid = $ready | Group-Object Cid
$index = 0
foreach ($group in $readyByCid) {
    $index++
    $item = $group.Group | Select-Object -First 1
    Write-Host ("[{0}/{1}] merge cid={2}" -f $index, $readyByCid.Count, $item.Cid)
    if ((Test-Path -LiteralPath $item.OutputPath) -and -not $Overwrite) {
        $successByCid[$item.Cid] = $item.LocalUrl
        continue
    }
    $cleanVideo = Join-Path $tempRoot "$($item.Cid)-video.m4s"
    $cleanAudio = Join-Path $tempRoot "$($item.Cid)-audio.m4s"
    try {
        Copy-CleanM4s $item.Video $cleanVideo
        Copy-CleanM4s $item.Audio $cleanAudio
        & $FfmpegPath -hide_banner -loglevel error -y -i $cleanVideo -i $cleanAudio -c copy -movflags +faststart $item.OutputPath
        if ($LASTEXITCODE -eq 0 -and (Test-Path -LiteralPath $item.OutputPath) -and ((Get-Item -LiteralPath $item.OutputPath).Length -gt 0)) {
            $successByCid[$item.Cid] = $item.LocalUrl
        } else {
            $failures.Add($item) | Out-Null
        }
    } finally {
        Remove-Item -LiteralPath $cleanVideo, $cleanAudio -Force -ErrorAction SilentlyContinue
    }
}

if ($failures.Count -gt 0) {
    $failures | Select-Object Id, Cid, Video, Audio, OutputPath | Format-Table -AutoSize
    throw "Some cache files failed to merge. Database was not updated."
}

$sql = "START TRANSACTION;`n"
$updatedRows = 0
foreach ($item in $ready) {
    if (-not $successByCid.ContainsKey($item.Cid)) {
        continue
    }
    $url = $successByCid[$item.Cid]
    $sql += "UPDATE sekai_memory_book_quote SET video_url=$(SqlLiteral $url) WHERE id=$($item.Id) AND user_id=$UserId;`n"
    $updatedRows++
}
$sql += "COMMIT;`n"
$sql | mysql "--default-character-set=utf8mb4" "-u$MysqlUser" -D $Database

$generated = @(Get-ChildItem -LiteralPath $uploadRoot -File -Filter "bilibili-quote-cid-*.mp4" -ErrorAction SilentlyContinue).Count
Write-Host "DB_UPDATED=$updatedRows"
Write-Host "GENERATED_FILES=$generated"
