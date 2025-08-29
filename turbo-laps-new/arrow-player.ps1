$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $scriptPath "..\Prompt.ps1")

$velocityPrompt = [Prompt]::new(
    "arrow-player.ts",
    "Make sure car can be slow downed",
    "Done",
    "
- car.state.velocity *= this.config.offTrackSlowdown;
- do some public method that will fix acces problem
- provide only change",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\track-boundary.ts"
    )
)

$startingPosPrompt = [Prompt]::new(
    "arrow-player.ts",
    "Set car in the starting-grid",
    "Done",
    "
- Use method on car or grid
- Probably in init method
- Show only changes",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\starting-grid.ts"
    )
)

$inputConfigPrompt = [Prompt]::new(
    "arrow-player.ts",
    "Configure Car input",
    "Done",
    "
- Initially car input should be off
- It should be turn on after countdown Go",
    @(
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\countdown.ts",
        "C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts"
    )
)

@{
    "arrow-player:velocityPrompt" = $velocityPrompt
    "arrow-player:startingPosPrompt" = $startingPosPrompt
    "arrow-player:inputConfigPrompt" = $inputConfigPrompt
}