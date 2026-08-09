param(
    [string]$PackageName = "SekaiMemoryBook",
    [string]$OutputRoot = "dist",
    [switch]$SkipMavenBuild,
    [switch]$SkipRuntimeBuild
)

$ErrorActionPreference = "Stop"

$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$outputRootPath = Join-Path $projectRoot $OutputRoot
$packageRoot = Join-Path $outputRootPath $PackageName
$targetRoot = Join-Path $projectRoot "target"

function Assert-UnderProject([string]$path) {
    $fullPath = [System.IO.Path]::GetFullPath($path)
    if (-not $fullPath.StartsWith($projectRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to modify path outside project: $fullPath"
    }
}

Assert-UnderProject $outputRootPath

if (-not $SkipMavenBuild) {
    Push-Location $projectRoot
    try {
        & mvn -q -DskipTests package
    } finally {
        Pop-Location
    }
}

$jar = Get-ChildItem -LiteralPath $targetRoot -File -Filter "*.jar" |
    Where-Object { $_.Name -notlike "*.original" -and $_.Name -notlike "*-sources.jar" -and $_.Name -notlike "*-javadoc.jar" } |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1
if (-not $jar) {
    throw "Packaged jar not found under $targetRoot"
}

if (Test-Path -LiteralPath $packageRoot) {
    Assert-UnderProject $packageRoot
    Remove-Item -LiteralPath $packageRoot -Recurse -Force
}

$appDir = Join-Path $packageRoot "app"
$dataDir = Join-Path $packageRoot "data"
$uploadDir = Join-Path $packageRoot "uploads"
$logDir = Join-Path $packageRoot "logs"
$runtimeDir = Join-Path $packageRoot "runtime"
New-Item -ItemType Directory -Path $appDir, $dataDir, $uploadDir, $logDir -Force | Out-Null
Copy-Item -LiteralPath $jar.FullName -Destination (Join-Path $appDir "sekai-memory-book.jar") -Force

if (-not $SkipRuntimeBuild) {
    $jlink = Get-Command jlink -ErrorAction Stop
    $modules = @(
        "java.base",
        "java.compiler",
        "java.desktop",
        "java.instrument",
        "java.logging",
        "java.management",
        "java.naming",
        "java.net.http",
        "java.prefs",
        "java.scripting",
        "java.security.jgss",
        "java.sql",
        "java.transaction.xa",
        "java.xml",
        "jdk.crypto.ec",
        "jdk.management",
        "jdk.unsupported",
        "jdk.zipfs"
    ) -join ","
    & $jlink.Source `
        --add-modules $modules `
        --strip-debug `
        --no-header-files `
        --no-man-pages `
        --compress zip-6 `
        --output $runtimeDir
} elseif (-not (Test-Path -LiteralPath $runtimeDir)) {
    throw "Runtime directory is missing and -SkipRuntimeBuild was set: $runtimeDir"
}

$sourceUploads = Join-Path $projectRoot "uploads"
if (Test-Path -LiteralPath $sourceUploads) {
    Copy-Item -Path (Join-Path $sourceUploads "*") -Destination $uploadDir -Recurse -Force -ErrorAction SilentlyContinue
}

$bat = @"
@echo off
setlocal
cd /d "%~dp0"

if not exist "data" mkdir "data"
if not exist "uploads" mkdir "uploads"
if not exist "logs" mkdir "logs"

echo Sekai Memory Book is starting...
echo Browser will open at http://localhost:18083/login

start "" /b powershell.exe -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 4; Start-Process 'http://localhost:18083/login'"

"%~dp0runtime\bin\java.exe" ^
  -Dfile.encoding=UTF-8 ^
  -Dspring.profiles.active=desktop ^
  "-Dsekai.desktop.data-dir=%~dp0data" ^
  "-Dsekai.uploadRoot=%~dp0uploads" ^
  -jar "%~dp0app\sekai-memory-book.jar" ^
  > "%~dp0logs\app.log" 2> "%~dp0logs\app-error.log"

echo.
echo Sekai Memory Book has stopped. Logs are under "%~dp0logs".
pause
"@
Set-Content -LiteralPath (Join-Path $packageRoot "SekaiMemoryBook.bat") -Value $bat -Encoding ASCII

$readme = @"
Sekai Memory Book Windows Portable

How to run:
1. Double-click SekaiMemoryBook.bat.
2. Wait for the browser to open at http://localhost:18083/home.
3. Register an account on first use.

Data locations:
- data: local H2 database files
- uploads: local images and quote videos
- logs: application logs

To move this app to another Windows computer, copy this whole folder.
"@
Set-Content -LiteralPath (Join-Path $packageRoot "README-Windows.txt") -Value $readme -Encoding UTF8

Write-Host "PACKAGE_ROOT=$packageRoot"
Write-Host "APP_JAR=$($jar.FullName)"
Write-Host "START=$packageRoot\SekaiMemoryBook.bat"
