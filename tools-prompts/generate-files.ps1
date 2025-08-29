$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
. (Join-Path $scriptPath "..\Prompt.ps1")

$newScriptPrompt = [Prompt]::new(
    "generate-files.ps1",
    "Tool to generate files",
    "Done",
    "
- Generate array with names items reading from a config file
- Give me example config file
- Let user speciffy path to config file
- cd to folder of config file
- foreach item create files with ni command
- ni item.ps1
- dont create if already exists to protect content
- dont use comments in code
",
    @(
        "C:\Atari-Monk-Art\prompting\tools\generate-files.ps1"
    )
)

@{
    "generate-files:newScriptPrompt" = $newScriptPrompt
}