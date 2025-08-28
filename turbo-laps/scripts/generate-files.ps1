$items = @(
    "arrow-player", 
    "elipse-track", 
    "rectangle-track", 
    "starting-grid", 
    "track-boundary", 
    "road-markings", 
    "track-grass", 
    "lap-tracker", 
    "game-score", 
    "menu", 
    "countdown", 
    "main-scenelet", 
    "main-game",
    "continue",
    "scene-factory",
    "register-single-scene")

Set-Location "C:\Atari-Monk-Art\prompting\turbo-laps\prompts"
foreach ($item in $items) {
    if (-not (Test-Path "$item.md")) {
        ni "$item.md"
    }
}
Set-Location "C:\Atari-Monk-Art\prompting\turbo-laps\scripts"
foreach ($item in $items) {
    if (-not (Test-Path "$item.ps1")) {
        ni "$item.ps1"
    }
}