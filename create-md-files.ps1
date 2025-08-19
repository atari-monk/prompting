<#
.SYNOPSIS
Creates empty markdown files in documentation directory based on a list from file-list.md.

.PARAMETER InputFile
Path to the input file containing the list of markdown files

.PARAMETER OutputDirectory
Path to the target directory where markdown files will be created

.EXAMPLE
.\Create-MarkdownFiles.ps1 -InputFile "C:\path\to\file-list.md" -OutputDirectory "C:\path\to\docs"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    
    [Parameter(Mandatory=$true)]
    [string]$OutputDirectory
)

# Validate input file exists
if (-not (Test-Path $InputFile)) {
    Write-Error "Input file '$InputFile' does not exist!"
    exit 1
}

# Validate output directory (create if it doesn't exist)
if (-not (Test-Path $OutputDirectory)) {
    Write-Host "Creating output directory: $OutputDirectory" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
}

# Read and parse the file list
$content = Get-Content $InputFile -Raw
$fileList = $content -split "[\r\n,]+" | 
           Where-Object { $_ -match '"([^"]+\.md)"' } |
           ForEach-Object { $matches[1] } |
           Where-Object { $_ -ne "" }

Write-Host "Found $($fileList.Count) files to process`n" -ForegroundColor Cyan
Write-Host "Input file: $InputFile" -ForegroundColor Gray
Write-Host "Output directory: $OutputDirectory`n" -ForegroundColor Gray

$created = 0
$existing = 0

foreach ($file in $fileList) {
    $filePath = Join-Path -Path $OutputDirectory -ChildPath $file
    
    # Ensure the directory structure exists for nested files
    $fileDir = Split-Path $filePath -Parent
    if (-not (Test-Path $fileDir)) {
        New-Item -ItemType Directory -Path $fileDir -Force | Out-Null
    }
    
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
Write-Host "Input file: $InputFile" -ForegroundColor Gray
Write-Host "Output directory: $OutputDirectory" -ForegroundColor Gray
Write-Host "New files created: $created" -ForegroundColor Green
Write-Host "Files already existed: $existing" -ForegroundColor Yellow
Write-Host "Total processed: $($fileList.Count)" -ForegroundColor White