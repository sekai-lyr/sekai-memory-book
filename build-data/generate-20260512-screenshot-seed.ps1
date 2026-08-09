$ErrorActionPreference = 'Stop'

$scriptRoot = if ([string]::IsNullOrWhiteSpace($PSScriptRoot)) {
    Join-Path (Get-Location) 'build-data'
} else {
    $PSScriptRoot
}
$outPath = Join-Path $scriptRoot 'sekai-20260512-more-anime-seed.sql'
$cachePath = Join-Path $scriptRoot 'sekai-20260512-more-anime-seed-cache.json'

function Escape-Sql([string] $value) {
    if ($null -eq $value) { return 'NULL' }
    return "'" + $value.Replace("'", "''") + "'"
}

function Date-Or-Null([string] $value) {
    if ([string]::IsNullOrWhiteSpace($value)) { return 'NULL' }
    return Escape-Sql $value
}

function Invoke-Jikan([string] $url) {
    try {
        Start-Sleep -Milliseconds 450
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 15
        return $response.Content | ConvertFrom-Json
    } catch {
        return $null
    }
}

$items = @(
    @{ Title='烟花'; Search='Uchiage Hanabi Shita kara Miru ka Yoko kara Miru ka'; Type='日本/动画,剧情'; Score='10.0'; Release='2017-08-18'; Episodes=1; Tags='动画,剧情' },
    @{ Title='刀剑神域：序列之争剧场版'; Search='Sword Art Online Movie Ordinal Scale'; Type='日本/科幻,动作,动画'; Score='10.0'; Release='2017-02-18'; Episodes=1; Tags='科幻,动作,动画' },
    @{ Title='BanG Dream! Episode of Roselia I: 约定'; Search='BanG Dream Episode of Roselia I Yakusoku'; Type='日本/动画,青春,音乐'; Score='10.0'; Release='2021-04-23'; Episodes=1; Tags='动画,青春,音乐' },
    @{ Title='黑子的篮球剧场版：LAST GAME'; Search='Kuroko no Basket Movie Last Game'; Type='日本/动作,动画,运动'; Score='10.0'; Release='2017-03-18'; Episodes=1; Tags='动作,动画,运动' },
    @{ Title='轻音少女'; Search='K-On!'; Type='日本/搞笑,冒险,青春,校园,治愈,励志,美少女'; Score='10.0'; Release='2009-04-03'; Episodes=14; Tags='搞笑,青春,校园,治愈,音乐' },
    @{ Title='轻音少女 第二季'; Search='K-On!!'; Type='日本/搞笑,冒险,青春,校园,治愈,励志,美少女'; Score='10.0'; Release='2010-04-07'; Episodes=27; Tags='搞笑,青春,校园,治愈,音乐' },
    @{ Title='轻音少女 剧场版'; Search='K-On! Movie'; Type='日本/爱情,动画,青春'; Score='10.0'; Release='2011-12-03'; Episodes=1; Tags='动画,青春,音乐' },
    @{ Title='孤独摇滚！'; Search='Bocchi the Rock'; Type='日本/奇幻'; Score='10.0'; Release='2022-10-09'; Episodes=12; Tags='音乐,搞笑,日常,青春' },
    @{ Title='吹响！上低音号'; Search='Hibike Euphonium'; Type='日本/校园,治愈,励志,百合'; Score='10.0'; Release='2015-04-08'; Episodes=13; Tags='校园,治愈,励志,音乐' },
    @{ Title='吹响！上低音号第二季'; Search='Hibike Euphonium 2'; Type='日本/校园,治愈,励志,百合'; Score='10.0'; Release='2016-10-06'; Episodes=13; Tags='校园,治愈,励志,音乐' },
    @{ Title='吹响！上低音号第三季'; Search='Hibike Euphonium 3'; Type='日本/日常,校园,百合,青春,励志'; Score='1.0'; Release='2024-04-07'; Episodes=13; Tags='日常,校园,百合,青春,励志,音乐' },
    @{ Title='吹响！上低音号剧场版合集'; Search='Hibike Euphonium Movie Kitauji Koukou Suisougaku-bu e Youkoso'; Type='日本/校园,治愈,励志,百合'; Score='10.0'; Release='2016-04-23'; Episodes=4; Tags='校园,治愈,励志,音乐,剧场版' },
    @{ Title='金牌得主'; Search='Medalist'; Type='日本/运动,励志,竞技,漫画改,热血,萝莉'; Score='10.0'; Release='2025-01-05'; Episodes=13; Tags='运动,励志,竞技,热血' },
    @{ Title='金牌得主 第二季'; Search='Medalist 2nd Season'; Type='日本/热血,竞技,励志,运动,萝莉,漫画改'; Score='10.0'; Release='2026-01-01'; Episodes=9; Tags='运动,励志,竞技,热血' },
    @{ Title='想吃掉我的非人少女'; Search='Watashi wo Tabetai Hito de Nashi'; Type='日本/奇幻,百合,漫画改'; Score='10.0'; Release='2025-10-02'; Episodes=13; Tags='奇幻,百合,漫画改' },
    @{ Title='关于我在无意间被隔壁的天使变成废柴这件事'; Search='Otonari no Tenshi-sama ni Itsunomanika Dame Ningen ni Sareteita Ken'; Type='日本/恋爱,校园'; Score='10.0'; Release='2023-01-07'; Episodes=12; Tags='恋爱,校园,日常' },
    @{ Title='关于我在无意间被隔壁的天使变成废柴这件事 第二季'; Search='Otonari no Tenshi-sama 2nd Season'; Type='日本/校园,日常,恋爱,轻小说改'; Score='10.0'; Release='2026-04-03'; Episodes=6; Tags='校园,日常,恋爱,轻小说改' },
    @{ Title='欢迎来到实力至上主义教室第四季'; Search='Youkoso Jitsuryoku Shijou Shugi no Kyoushitsu e 4th Season'; Type='日本/校园,后宫,恋爱,轻小说改'; Score='10.0'; Release='2026-01-01'; Episodes=9; Tags='校园,后宫,恋爱,轻小说改' },
    @{ Title='咒术回战 第三季'; Search='Jujutsu Kaisen 3rd Season'; Type='日本/奇幻,热血,战斗,搞笑,漫画改'; Score='10.0'; Release='2026-01-01'; Episodes=12; Tags='奇幻,热血,战斗,漫画改' },
    @{ Title='杖与剑的魔剑谭 第二季'; Search='Tsue to Tsurugi no Wistoria 2nd Season'; Type='日本/奇幻,热血,战斗,异世界,后宫,漫画改'; Score='10.0'; Release='2026-01-01'; Episodes=5; Tags='奇幻,热血,战斗,漫画改' },
    @{ Title='夜樱家的大作战 第二季'; Search='Yozakura-san Chi no Daisakusen 2nd Season'; Type='日本/搞笑,恋爱,战斗,漫画改'; Score='10.0'; Release='2026-01-01'; Episodes=5; Tags='搞笑,恋爱,战斗,漫画改' },
    @{ Title='魔法少女与恶曾是敌人'; Search='Katsute Mahou Shoujo to Aku wa Tekitai shiteita'; Type='日本/奇幻,恋爱,搞笑,魔法'; Score='10.0'; Release='2024-07-09'; Episodes=12; Tags='奇幻,恋爱,搞笑,魔法' },
    @{ Title='Love Live!'; Search='Love Live School Idol Project'; Type='日本/搞笑,青春,校园,励志,美少女'; Score='10.0'; Release='2013-01-06'; Episodes=13; Tags='偶像,校园,励志,音乐' },
    @{ Title='Love Live!第二季'; Search='Love Live School Idol Project 2nd Season'; Type='日本/搞笑,青春,校园,励志,美少女'; Score='10.0'; Release='2014-04-06'; Episodes=13; Tags='偶像,校园,励志,音乐' },
    @{ Title='Love Live! 虹咲学园校园偶像同好会'; Search='Love Live Nijigasaki Gakuen School Idol Doukoukai'; Type='日本/校园,励志,百合'; Score='10.0'; Release='2020-10-03'; Episodes=13; Tags='偶像,校园,励志,百合' },
    @{ Title='Love Live! Superstar!!'; Search='Love Live Superstar'; Type='日本/校园,励志,百合'; Score='10.0'; Release='2021-07-11'; Episodes=12; Tags='偶像,校园,励志,百合' },
    @{ Title='Love Live! Superstar!!第二季'; Search='Love Live Superstar 2nd Season'; Type='日本/校园,励志,百合'; Score='10.0'; Release='2022-07-17'; Episodes=12; Tags='偶像,校园,励志,百合' },
    @{ Title='Love Live! 虹咲学园校园偶像同好会 第二季'; Search='Love Live Nijigasaki Gakuen School Idol Doukoukai 2nd Season'; Type='日本/青春,校园,励志,百合'; Score='10.0'; Release='2022-04-02'; Episodes=13; Tags='偶像,校园,励志,百合' },
    @{ Title='租借女友'; Search='Kanojo Okarishimasu'; Type='日本/搞笑,校园,恋爱'; Score='5.0'; Release='2020-07-11'; Episodes=12; Tags='搞笑,校园,恋爱' },
    @{ Title='租借女友 第二季'; Search='Kanojo Okarishimasu 2nd Season'; Type='日本/搞笑,后宫,恋爱,校园,青春'; Score='10.0'; Release='2022-07-02'; Episodes=12; Tags='搞笑,后宫,恋爱,校园,青春' },
    @{ Title='租借女友 第三季'; Search='Kanojo Okarishimasu 3rd Season'; Type='日本/搞笑,恋爱'; Score='10.0'; Release='2023-07-08'; Episodes=12; Tags='搞笑,恋爱' },
    @{ Title='租借女友 第四季'; Search='Kanojo Okarishimasu 4th Season'; Type='日本/搞笑,恋爱,后宫,青春,漫画改'; Score='10.0'; Release='2025-07-05'; Episodes=12; Tags='搞笑,恋爱,后宫,青春,漫画改' },
    @{ Title='租借女友 第五季'; Search='Kanojo Okarishimasu 5th Season'; Type='日本/恋爱,后宫,漫画改'; Score='5.5'; Release='2026-01-01'; Episodes=5; Tags='恋爱,后宫,漫画改' },
    @{ Title='Re：从零开始的异世界生活'; Search='Re Zero kara Hajimeru Isekai Seikatsu'; Type='日本/战斗,奇幻,冒险'; Score='10.0'; Release='2016-04-04'; Episodes=25; Tags='战斗,奇幻,冒险' },
    @{ Title='Re：从零开始的异世界生活 Memory Snow'; Search='Re Zero kara Hajimeru Isekai Seikatsu Memory Snow'; Type='日本/战斗,奇幻,冒险'; Score='10.0'; Release='2018-10-06'; Episodes=1; Tags='战斗,奇幻,冒险,OVA' },
    @{ Title='Re：从零开始的异世界生活 新编集版'; Search='Re Zero kara Hajimeru Isekai Seikatsu Shin Henshuu-ban'; Type='日本/战斗,奇幻,冒险'; Score='10.0'; Release='2020-01-01'; Episodes=13; Tags='战斗,奇幻,冒险' },
    @{ Title='Re：从零开始的异世界生活 冰结之绊'; Search='Re Zero kara Hajimeru Isekai Seikatsu Hyouketsu no Kizuna'; Type='日本/战斗,奇幻,冒险,美少女'; Score='10.0'; Release='2019-11-08'; Episodes=1; Tags='战斗,奇幻,冒险,美少女' },
    @{ Title='Re：从零开始的异世界生活第二季'; Search='Re Zero kara Hajimeru Isekai Seikatsu 2nd Season'; Type='日本/战斗,奇幻,冒险,恋爱'; Score='10.0'; Release='2020-07-08'; Episodes=25; Tags='战斗,奇幻,冒险,恋爱' },
    @{ Title='Re：从零开始的异世界生活第三季 反击篇'; Search='Re Zero kara Hajimeru Isekai Seikatsu 3rd Season Hangeki-hen'; Type='日本/奇幻,战斗,后宫,热血,冒险,恋爱'; Score='10.0'; Release='2025-02-05'; Episodes=8; Tags='奇幻,战斗,冒险,恋爱' },
    @{ Title='Re：从零开始的异世界生活第三季'; Search='Re Zero kara Hajimeru Isekai Seikatsu 3rd Season'; Type='日本/奇幻,冒险,后宫,战斗'; Score='10.0'; Release='2024-10-02'; Episodes=8; Tags='奇幻,冒险,后宫,战斗' },
    @{ Title='Re：从零开始的异世界生活第四季'; Search='Re Zero kara Hajimeru Isekai Seikatsu 4th Season'; Type='日本/奇幻,冒险,战斗,异世界,穿越,恋爱,悬疑,轻小'; Score='10.0'; Release='2026-01-01'; Episodes=5; Tags='奇幻,冒险,战斗,恋爱' },
    @{ Title='黑色四叶草'; Search='Black Clover'; Type='日本/热血,战斗,奇幻,冒险,魔法'; Score='10.0'; Release='2017-10-03'; Episodes=170; Tags='热血,战斗,奇幻,冒险,魔法' },
    @{ Title='我推的孩子'; Search='Oshi no Ko'; Type='日本/恋爱,猎奇,推理'; Score='10.0'; Release='2023-04-12'; Episodes=11; Tags='偶像,推理,剧情' },
    @{ Title='我推的孩子 第二季'; Search='Oshi no Ko 2nd Season'; Type='日本/恋爱,推理,青春,美少女'; Score='10.0'; Release='2024-07-03'; Episodes=13; Tags='偶像,推理,青春' },
    @{ Title='我推的孩子 第三季'; Search='Oshi no Ko 3rd Season'; Type='日本/奇幻,恋爱,后宫,偶像,悬疑,漫画改'; Score='10.0'; Release='2026-01-01'; Episodes=11; Tags='偶像,悬疑,漫画改' }
)

$animeRows = New-Object System.Collections.Generic.List[object]
$characterRows = New-Object System.Collections.Generic.List[object]

foreach ($item in $items) {
    $query = [System.Uri]::EscapeDataString($item.Search)
    $searchData = Invoke-Jikan "https://api.jikan.moe/v4/anime?q=$query&limit=1"
    $anime = $null
    if ($searchData -and $searchData.data -and $searchData.data.Count -gt 0) {
        $anime = $searchData.data[0]
    }

    $cover = if ($anime) { $anime.images.jpg.large_image_url } else { $null }
    if ([string]::IsNullOrWhiteSpace($cover) -and $anime) { $cover = $anime.images.jpg.image_url }
    $malId = if ($anime) { $anime.mal_id } else { $null }
    $url = if ($anime) { $anime.url } else { $null }

    $animeRows.Add([pscustomobject]@{
        Title = $item.Title
        Type = $item.Type
        Score = $item.Score
        Cover = $cover
        Release = $item.Release
        Episodes = $item.Episodes
        Tags = $item.Tags
        Source = $url
        MalId = $malId
    })

    if ($malId) {
        $characters = Invoke-Jikan "https://api.jikan.moe/v4/anime/$malId/characters"
        if ($characters -and $characters.data) {
            $selected = @($characters.data | Sort-Object @{ Expression = { if ($_.role -eq 'Main') { 0 } else { 1 } } }, @{ Expression = { -1 * [int]$_.favorites } } | Select-Object -First 3)
            foreach ($entry in $selected) {
                $img = $entry.character.images.jpg.image_url
                if (-not [string]::IsNullOrWhiteSpace($img)) {
                    $characterRows.Add([pscustomobject]@{
                        AnimeTitle = $item.Title
                        Name = $entry.character.name
                        Image = $img
                        Reason = "$($item.Title) 的主要角色，承载了这部作品最鲜明的记忆点。"
                        Level = 5
                        Quote = '我会继续向前。'
                    })
                }
            }
        }
    }
}

$payload = [pscustomobject]@{
    generatedAt = (Get-Date).ToString('s')
    anime = $animeRows
    characters = $characterRows
}
$payload | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $cachePath

$lines = New-Object System.Collections.Generic.List[string]
$lines.Add('USE sekai_friend;')
$lines.Add('SET NAMES utf8mb4;')
$lines.Add('')
$lines.Add("SET @sekai_user_id := (SELECT id FROM sekai_memory_book_user WHERE username = 'sekai' LIMIT 1);")
$lines.Add("SET @watched_on := '2026-05-12';")
$lines.Add('')
$lines.Add('CREATE TEMPORARY TABLE seed_20260512_more_anime (')
$lines.Add('    title VARCHAR(100) NOT NULL,')
$lines.Add('    type VARCHAR(100),')
$lines.Add('    status VARCHAR(20),')
$lines.Add('    score DECIMAL(3,1),')
$lines.Add('    cover_url VARCHAR(1000),')
$lines.Add('    watch_date DATE,')
$lines.Add('    release_date DATE,')
$lines.Add('    total_episodes INT,')
$lines.Add('    current_episode INT,')
$lines.Add('    last_watch_date DATE,')
$lines.Add('    tags VARCHAR(255)')
$lines.Add(');')
$lines.Add('')
$lines.Add('INSERT INTO seed_20260512_more_anime')
$lines.Add('(title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)')
$lines.Add('VALUES')
$animeValues = @()
foreach ($row in $animeRows) {
    $animeValues += '(' + (@(
        Escape-Sql $row.Title
        Escape-Sql $row.Type
        "'看完'"
        $row.Score
        Escape-Sql $row.Cover
        '@watched_on'
        Date-Or-Null $row.Release
        $row.Episodes
        $row.Episodes
        '@watched_on'
        Escape-Sql $row.Tags
    ) -join ', ') + ')'
}
$lines.Add(($animeValues -join ",`n") + ';')
$lines.Add('')
$lines.Add('INSERT INTO sekai_memory_book_anime')
$lines.Add('    (user_id, title, type, status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags)')
$lines.Add('SELECT @sekai_user_id, title, LEFT(type, 50), status, score, cover_url, watch_date, release_date, total_episodes, current_episode, last_watch_date, tags')
$lines.Add('FROM seed_20260512_more_anime seed')
$lines.Add('WHERE @sekai_user_id IS NOT NULL')
$lines.Add('  AND NOT EXISTS (')
$lines.Add('      SELECT 1 FROM sekai_memory_book_anime existing')
$lines.Add('      WHERE existing.user_id = @sekai_user_id')
$lines.Add('        AND existing.title = seed.title')
$lines.Add('  );')
$lines.Add('')
$lines.Add('UPDATE sekai_memory_book_anime anime')
$lines.Add('JOIN seed_20260512_more_anime seed ON seed.title = anime.title')
$lines.Add('SET anime.type = LEFT(seed.type, 50),')
$lines.Add('    anime.status = seed.status,')
$lines.Add('    anime.score = seed.score,')
$lines.Add('    anime.cover_url = COALESCE(seed.cover_url, anime.cover_url),')
$lines.Add('    anime.watch_date = seed.watch_date,')
$lines.Add('    anime.release_date = seed.release_date,')
$lines.Add('    anime.total_episodes = seed.total_episodes,')
$lines.Add('    anime.current_episode = seed.current_episode,')
$lines.Add('    anime.last_watch_date = seed.last_watch_date,')
$lines.Add('    anime.tags = seed.tags')
$lines.Add('WHERE anime.user_id = @sekai_user_id;')
$lines.Add('')
$lines.Add('CREATE TEMPORARY TABLE seed_20260512_more_characters (')
$lines.Add('    anime_title VARCHAR(100),')
$lines.Add('    character_name VARCHAR(100),')
$lines.Add('    image_url VARCHAR(1000),')
$lines.Add('    reason VARCHAR(255),')
$lines.Add('    favorite_level TINYINT')
$lines.Add(');')
$lines.Add('')
$lines.Add('INSERT INTO seed_20260512_more_characters')
$lines.Add('(anime_title, character_name, image_url, reason, favorite_level)')
$lines.Add('VALUES')
$characterValues = @()
foreach ($row in $characterRows) {
    $characterValues += '(' + (@(
        Escape-Sql $row.AnimeTitle
        Escape-Sql $row.Name
        Escape-Sql $row.Image
        Escape-Sql $row.Reason
        $row.Level
    ) -join ', ') + ')'
}
$lines.Add(($characterValues -join ",`n") + ';')
$lines.Add('')
$lines.Add('INSERT INTO sekai_memory_book_character_favorite')
$lines.Add('    (user_id, anime_id, character_name, image_url, reason, favorite_level)')
$lines.Add('SELECT @sekai_user_id, MIN(anime.id), seed.character_name,')
$lines.Add('       SUBSTRING_INDEX(GROUP_CONCAT(seed.image_url ORDER BY seed.anime_title SEPARATOR ''||''), ''||'', 1),')
$lines.Add('       SUBSTRING_INDEX(GROUP_CONCAT(seed.reason ORDER BY seed.anime_title SEPARATOR ''||''), ''||'', 1),')
$lines.Add('       MAX(seed.favorite_level)')
$lines.Add('FROM seed_20260512_more_characters seed')
$lines.Add('JOIN sekai_memory_book_anime anime')
$lines.Add('  ON anime.user_id = @sekai_user_id')
$lines.Add(' AND anime.title = seed.anime_title')
$lines.Add('WHERE @sekai_user_id IS NOT NULL')
$lines.Add('  AND NOT EXISTS (')
$lines.Add('      SELECT 1 FROM sekai_memory_book_character_favorite existing')
$lines.Add('      WHERE existing.user_id = @sekai_user_id')
$lines.Add('        AND existing.character_name = seed.character_name')
$lines.Add('  )')
$lines.Add('GROUP BY seed.character_name;')
$lines.Add('')
$lines.Add('CREATE TEMPORARY TABLE seed_20260512_more_quotes (')
$lines.Add('    anime_title VARCHAR(100),')
$lines.Add('    character_name VARCHAR(100),')
$lines.Add('    content VARCHAR(500),')
$lines.Add('    feeling TEXT,')
$lines.Add('    tag VARCHAR(50)')
$lines.Add(');')
$lines.Add('')
$lines.Add('INSERT INTO seed_20260512_more_quotes')
$lines.Add('(anime_title, character_name, content, feeling, tag)')
$lines.Add('VALUES')
$quoteValues = @()
foreach ($row in $characterRows) {
    $quoteValues += '(' + (@(
        Escape-Sql $row.AnimeTitle
        Escape-Sql $row.Name
        Escape-Sql $row.Quote
        Escape-Sql "$($row.AnimeTitle) 的角色短句，适合放在回忆台词里。"
        Escape-Sql '前进'
    ) -join ', ') + ')'
}
$lines.Add(($quoteValues -join ",`n") + ';')
$lines.Add('')
$lines.Add('INSERT INTO sekai_memory_book_quote')
$lines.Add('    (user_id, anime_id, character_name, content, feeling, tag)')
$lines.Add('SELECT @sekai_user_id, anime.id, seed.character_name, seed.content,')
$lines.Add('       SUBSTRING_INDEX(GROUP_CONCAT(seed.feeling ORDER BY seed.feeling SEPARATOR ''||''), ''||'', 1),')
$lines.Add('       seed.tag')
$lines.Add('FROM seed_20260512_more_quotes seed')
$lines.Add('JOIN sekai_memory_book_anime anime')
$lines.Add('  ON anime.user_id = @sekai_user_id')
$lines.Add(' AND anime.title = seed.anime_title')
$lines.Add('WHERE @sekai_user_id IS NOT NULL')
$lines.Add('  AND NOT EXISTS (')
$lines.Add('      SELECT 1 FROM sekai_memory_book_quote existing')
$lines.Add('      WHERE existing.user_id = @sekai_user_id')
$lines.Add('        AND existing.anime_id = anime.id')
$lines.Add('        AND existing.character_name = seed.character_name')
$lines.Add('        AND existing.content = seed.content')
$lines.Add('  )')
$lines.Add('GROUP BY anime.id, seed.character_name, seed.content, seed.tag;')

$lines | Set-Content -Encoding UTF8 $outPath

Write-Host "Generated $outPath"
Write-Host "Anime rows: $($animeRows.Count)"
Write-Host "Character rows: $($characterRows.Count)"
