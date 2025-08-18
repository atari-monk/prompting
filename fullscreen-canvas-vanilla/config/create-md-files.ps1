<#
.SYNOPSIS
Creates empty markdown files in documentation directory based on a list from file-list.md.
#>

# Hardcoded paths
$dataFile = "C:\Atari-Monk-Art\prompting\fullscreen-canvas-vanilla\config\file-list.md"
$targetDir = "C:\Atari-Monk-Art\prompting\fullscreen-canvas-vanilla\config\payload"

# Read and parse the file list
$content = Get-Content $dataFile -Raw
$fileList = $content -split "[\r\n,]+" | 
           Where-Object { $_ -match '"([^"]+\.md)"' } |
           ForEach-Object { $matches[1] } |
           Where-Object { $_ -ne "" }

Write-Host "Found $($fileList.Count) files to process`n" -ForegroundColor Cyan

$created = 0
$existing = 0

foreach ($file in $fileList) {
    $filePath = Join-Path -Path $targetDir -ChildPath $file
    
    if (-not (Test-Path $filePath)) {
        New-Item -ItemType File -Path $filePath -Force | Out-Null
        Write-Host "Created: $file" -ForegroundColor Green
        $created++
    }
    else {
        Write-Host "Exists: $file" -ForegroundColor Yellow
        $existing++
    }
}

# Summary
Write-Host "`nSummary:" -ForegroundColor Cyan
Write-Host "New files created: $created" -ForegroundColor Green
Write-Host "Files already existed: $existing" -ForegroundColor Yellow
Write-Host "Total processed: $($fileList.Count)" -ForegroundColor White