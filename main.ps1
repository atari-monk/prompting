param(
    [string]$SpecificPrompts
)

function Get-AllPrompts {
    $promptFiles = @(
        "C:\Atari-Monk-Art\prompting\turbo-laps-new\lap-tracker.ps1",
        "C:\Atari-Monk-Art\prompting\turbo-laps-new\arrow-player.ps1",
        "C:\Atari-Monk-Art\prompting\tools-prompts\generate-files.ps1"
        "C:\Atari-Monk-Art\prompting\turbo-laps-new\countdown.ps1"
        # Add more prompt files here as needed
    )
    
    $allPrompts = @{}
    
    foreach ($file in $promptFiles) {
        if (Test-Path $file) {
            $filePrompts = & $file
            foreach ($prompt in $filePrompts.GetEnumerator()) {
                $allPrompts[$prompt.Key] = $prompt.Value
            }
        } else {
            Write-Warning "Prompt file not found: $file"
        }
    }
    
    return $allPrompts
}

# Get all prompts
$allPrompts = Get-AllPrompts

# Get the specific prompt requested
$selectedPrompt = $allPrompts[$SpecificPrompts]

if ($selectedPrompt) {
    # Use the selected prompt
    Write-Host "Using prompt:"
    Write-Host "File-'$($selectedPrompt.File)'"
    Write-Host "Name-'$($selectedPrompt.Name)'"
    Write-Host "Status-'$($selectedPrompt.Status)'"
    Write-Host "Text-'$($selectedPrompt.Text)'"
    Write-Host "Files: $($selectedPrompt.Paths -join ', ')"
    
    # Actually execute the prompt
    $selectedPrompt.Execute()
    
    Write-Host "Prompt text copied to clipboard and paths merged!"
} else {
    Write-Host "Prompt '$SpecificPrompts' not found. Available prompts: $($allPrompts.Keys -join ', ')"
}