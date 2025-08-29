$configPath = Read-Host "Enter path to config file"
if (-not (Test-Path $configPath)) {
    Write-Error "Config file not found"
    exit
}

$items = Get-Content $configPath
$configDir = Split-Path $configPath -Parent
Set-Location $configDir

foreach ($item in $items) {
    if ($item.Trim() -ne "" -and -not (Test-Path "$item.ps1")) {
        ni "$item.ps1"
    }
}