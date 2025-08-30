. ("C:\Atari-Monk-Art\prompting\Prompt.ps1")
. ("C:\Atari-Monk-Art\prompting\helpers.ps1")

$loadedPrompt = Import-PromptFromFile -FilePath "C:\Atari-Monk-Art\prompting\turbo-laps-dev\scene-factory.json"

$loadedPrompt.Execute()
