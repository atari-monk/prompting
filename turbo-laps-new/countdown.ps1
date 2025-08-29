$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $scriptPath "..\Prompt.ps1")

$countdownPrompt = [Prompt]::new(
    "countdown.ts",
    "Countdown Scene",
    "Done",
    "
- Must implement Scene
- Countdown scene, draw Countdown, 3, 2, 1 Go, and start lap tracker
- Integrate it with main.ts
- Draw atractive text in center of the screen
- Wait 0.5s before Countdown
- We need to block player input initially
- Unblock it after countdown
- Countdown should start with delay after menu Start button click
",
    @(
        "C:\Atari-Monk-Art\zippy-game-engine\src\interfaces\scene.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\lap-tracker.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\menu.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts"
    )
)

$afterGoPrompt = [Prompt]::new(
    "countdown.ts",
    "After Go",
    "Done",
    "
- After Go i dont want overlay
- It blocks game view
- It should be on during countdown
- Turn it off after Go
",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts"
    )
)

$startAgainPrompt = [Prompt]::new(
    "countdown.ts",
    "Start Again",
    "Done",
    "
- Countdown needs to have start again method
",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts"
    )
)

$fixGoPrompt = [Prompt]::new(
    "countdown.ts",
    "Fix Go",
    "Pending",
    "
- Countdown should turn on car input on GO, not after GO
- Right after GO starts to be visible, car input should be on
- createCountdownFeature in scene-factory.ts tests this feature
",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scene-factory.ts"
    )
)

@{
    "countdown:countdownPrompt" = $countdownPrompt
    "countdown:afterGoPrompt" = $afterGoPrompt
    "countdown:startAgainPrompt" = $startAgainPrompt
    "countdown:fixGoPrompt" = $fixGoPrompt
}