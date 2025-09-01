. ("C:\Atari-Monk-Art\prompting\Prompt.ps1")
. ("C:\Atari-Monk-Art\prompting\helpers.ps1")

$folderPath = "C:\Atari-Monk-Art\prompting"
$fileName = "prompt"
$fileType = ".json"
$fullPath = $folderPath + "\" + $fileName  + $fileType

$loadedPrompt = Import-PromptFromFile -FilePath $fullPath
$loadedPrompt.Execute()
