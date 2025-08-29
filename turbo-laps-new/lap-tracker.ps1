$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $scriptPath "..\Prompt.ps1")

$convertPrompt = [Prompt]::new(
    "lap-tracker.ts",
    "Convert form js to ts",
    "Done",
    "
- Use latest typescript
- Convert from js to ts class
- Class must implement Scene interface
- Use rectangle-track.ts as a dependency instead of js track
- Use arrow-player.ts instead of car in update
- Use ctor DI for player
- Mod player if access for its elements is needed",
    @(
        "C:\Atari-Monk-Art\turbo-laps-js\src\turbo-laps\lap_tracker.js",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\rectangle-track.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts"
    )
)

$integratePrompt = [Prompt]::new(
    "lap-tracker.ts",
    "Integrate LapTracker with main.ts",
    "Done",
    "
- Generate instance
- Register
- Scene in both modes
- Show just changes",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts"
    )
)

$apiPrompt = [Prompt]::new(
    "lap-tracker.ts",
    "Stop lap tracker", 
    "Done",
    "
- It shouldnt start automatically
- Provide interface to start/stop/reset it",
    @("C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts")
)

$stopPrompt = [Prompt]::new(
    "lap-tracker.ts",
    "Stop after race", 
    "Done",
    "- Stop lap tracker when race is over",
    @("C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts")
)

$bug1Prompt = [Prompt]::new(
    "lap-tracker.ts",
    "There is a bug", 
    "Done",
    "
- After 1 lap is made, stop() should run
- Break point dosent hit
- This is becouse handler is null, make it set in ctor",
    @("C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts")
)

$sectionFixPrompt = [Prompt]::new(
    "lap-tracker.ts",
    "We need sections rework", 
    "Pending",
    "
- Fix section detection logic
- I would like starting grid to be placed at start of section 0
- Section 0 should be from start/finish line for a full lap
- Section 1 should be next one clockwise and so on
- Also starting grid should be on straight part of road, not on curve
- We need sections to form a full lap loop and place car on straight part of road of section 0
- Do you see what i mean?
- Currently car starts in some point of section 2 and race ends at section 1
- It is not a full lap
",
    @("C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts",
    "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\rectangle-track.ts",
    "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts",
    "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\starting-grid.ts")
)

$bug2Prompt = [Prompt]::new(
    "lap-tracker.ts",
    "There is a bug", 
    "Done",
    "
- tracker is starting automatically,
- initially it should be stopped
- it should start on GO
- check createLapTrackerFeature",
    @("C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts",
      "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts",
      "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scene-factory.ts")
)

@{
    "lap-tracker:convertPrompt" = $convertPrompt
    "lap-tracker:integratePrompt" = $integratePrompt
    "lap-tracker:apiPrompt" = $apiPrompt
    "lap-tracker:stopPrompt" = $stopPrompt
    "lap-tracker:bug1Prompt" = $bug1Prompt
    "lap-tracker:sectionFixPrompt" = $sectionFixPrompt
    "lap-tracker:bug2Prompt" = $bug2Prompt
}