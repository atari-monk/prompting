# CLI Script for Prompt Input
# Version: 1.1.0 - Fixed property order and empty handling

# Load helper functions
. "C:/Atari-Monk-Art/prompting/helpers.ps1"
. "C:/Atari-Monk-Art/prompting/Prompt.ps1"

function Read-ArrayInput {
    param(
        [string]$PromptMessage,
        [string]$ItemName = "item"
    )
    
    $items = @()
    Write-Host "`n$PromptMessage" -ForegroundColor Cyan
    Write-Host "Enter each $ItemName (press Enter without text to finish):" -ForegroundColor Yellow
    
    $counter = 1
    do {
        $input = Read-Host "  $ItemName #$counter"
        if (-not [string]::IsNullOrWhiteSpace($input)) {
            $items += $input.Trim()
            $counter++
        }
    } while (-not [string]::IsNullOrWhiteSpace($input))
    
    return $items
}

function Show-CurrentPrompt {
    param(
        [Prompt]$Prompt
    )
    
    Write-Host "`n=== CURRENT PROMPT ===" -ForegroundColor Green
    
    # Display in example order
    Write-Host "Role: $($Prompt.Role)" -ForegroundColor Yellow
    Write-Host "Task: $($Prompt.Task)" -ForegroundColor Yellow
    
    if ($Prompt.Requirements -and $Prompt.Requirements.Count -gt 0) {
        Write-Host "Requirements:" -ForegroundColor Yellow
        foreach ($req in $Prompt.Requirements) {
            Write-Host "  - $req" -ForegroundColor White
        }
    }
    
    if ($Prompt.StopConditions -and $Prompt.StopConditions.Count -gt 0) {
        Write-Host "Stop Conditions: $($Prompt.StopConditions -join ', ')" -ForegroundColor Yellow
    }
    
    if ($Prompt.Paths -and $Prompt.Paths.Count -gt 0) {
        Write-Host "Paths:" -ForegroundColor Yellow
        foreach ($path in $Prompt.Paths) {
            Write-Host "  - $path" -ForegroundColor White
        }
    }
    
    Write-Host "Output Format: $($Prompt.OutputFormat)" -ForegroundColor Yellow
    Write-Host "Status: $($Prompt.Status)" -ForegroundColor Yellow
    Write-Host "LLM: $($Prompt.LLM)" -ForegroundColor Yellow
    Write-Host "Prompt Model Version: $($Prompt.PromptModelVersion)" -ForegroundColor Yellow
    Write-Host "Created: $($Prompt.CreatedDate.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
    Write-Host "Last Modified: $($Prompt.ModifiedDate.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Yellow
    
    # Optional fields - only show if not empty
    if (-not [string]::IsNullOrEmpty($Prompt.Name)) {
        Write-Host "Name: $($Prompt.Name)" -ForegroundColor Yellow
    }
    
    if (-not [string]::IsNullOrEmpty($Prompt.File)) {
        Write-Host "File: $($Prompt.File)" -ForegroundColor Yellow
    }
    
    if (-not [string]::IsNullOrEmpty($Prompt.Context)) {
        Write-Host "Context: $($Prompt.Context)" -ForegroundColor Yellow
    }
    
    if (-not [string]::IsNullOrEmpty($Prompt.Reasoning)) {
        Write-Host "Reasoning: $($Prompt.Reasoning)" -ForegroundColor Yellow
    }
    
    Write-Host "=====================" -ForegroundColor Green
}

function Invoke-PromptCreator {
    param(
        [string]$TemplatePath = ".\templates\typescript-dev.json"
    )
    
    Write-Host "=== PROMPT CREATOR CLI ===" -ForegroundColor Magenta
    Write-Host "Loading template from: $TemplatePath" -ForegroundColor Cyan
    
    try {
        # Load the prompt template
        $loadedPrompt = Import-PromptFromFile -FilePath $TemplatePath -ErrorAction Stop
        
        if (-not $loadedPrompt) {
            Write-Error "Failed to load prompt template from $TemplatePath"
            return
        }
        
        Write-Host "Template loaded successfully!" -ForegroundColor Green
        Write-Host "Template Role: $($loadedPrompt.Role)" -ForegroundColor Yellow
        
        # Show current values
        Show-CurrentPrompt -Prompt $loadedPrompt
        
        # Input loop for properties in example order
        Write-Host "`n=== INPUT VALUES ===" -ForegroundColor Cyan
        
        # Get Role
        $roleInput = Read-Host "Enter Role (press Enter to keep current: '$($loadedPrompt.Role)')"
        if (-not [string]::IsNullOrWhiteSpace($roleInput)) {
            $loadedPrompt.Role = $roleInput.Trim()
        }
        
        # Get Task
        $taskInput = Read-Host "Enter Task (press Enter to keep current: '$($loadedPrompt.Task)')"
        if (-not [string]::IsNullOrWhiteSpace($taskInput)) {
            $loadedPrompt.Task = $taskInput.Trim()
        }
        
        # Get Requirements (array input)
        Write-Host "`nCurrent Requirements:" -ForegroundColor Yellow
        if ($loadedPrompt.Requirements -and $loadedPrompt.Requirements.Count -gt 0) {
            foreach ($req in $loadedPrompt.Requirements) {
                Write-Host "  - $req" -ForegroundColor White
            }
        } else {
            Write-Host "  None" -ForegroundColor Gray
        }
        
        $addRequirements = Read-Host "`nAdd new requirements? (Y/N)"
        if ($addRequirements -eq 'Y' -or $addRequirements -eq 'y') {
            $newRequirements = Read-ArrayInput -PromptMessage "Enter Requirements" -ItemName "requirement"
            if ($newRequirements.Count -gt 0) {
                if (-not $loadedPrompt.Requirements) {
                    $loadedPrompt.Requirements = @()
                }
                $loadedPrompt.Requirements += $newRequirements
            }
        }
        
        # Get Stop Conditions (array input)
        Write-Host "`nCurrent Stop Conditions:" -ForegroundColor Yellow
        if ($loadedPrompt.StopConditions -and $loadedPrompt.StopConditions.Count -gt 0) {
            foreach ($stop in $loadedPrompt.StopConditions) {
                Write-Host "  - $stop" -ForegroundColor White
            }
        } else {
            Write-Host "  None" -ForegroundColor Gray
        }
        
        $addStopConditions = Read-Host "`nAdd new stop conditions? (Y/N)"
        if ($addStopConditions -eq 'Y' -or $addStopConditions -eq 'y') {
            $newStopConditions = Read-ArrayInput -PromptMessage "Enter Stop Conditions" -ItemName "stop condition"
            if ($newStopConditions.Count -gt 0) {
                if (-not $loadedPrompt.StopConditions) {
                    $loadedPrompt.StopConditions = @()
                }
                $loadedPrompt.StopConditions += $newStopConditions
            }
        }
        
        # Get Paths (array input)
        Write-Host "`nCurrent Paths:" -ForegroundColor Yellow
        if ($loadedPrompt.Paths -and $loadedPrompt.Paths.Count -gt 0) {
            foreach ($path in $loadedPrompt.Paths) {
                Write-Host "  - $path" -ForegroundColor White
            }
        } else {
            Write-Host "  None" -ForegroundColor Gray
        }
        
        $addPaths = Read-Host "`nAdd new paths? (Y/N)"
        if ($addPaths -eq 'Y' -or $addPaths -eq 'y') {
            $newPaths = Read-ArrayInput -PromptMessage "Enter Paths" -ItemName "path"
            if ($newPaths.Count -gt 0) {
                if (-not $loadedPrompt.Paths) {
                    $loadedPrompt.Paths = @()
                }
                $loadedPrompt.Paths += $newPaths
            }
        }
        
        # Get Output Format
        $outputFormatInput = Read-Host "Enter Output Format (press Enter to keep current: '$($loadedPrompt.OutputFormat)')"
        if (-not [string]::IsNullOrWhiteSpace($outputFormatInput)) {
            $loadedPrompt.OutputFormat = $outputFormatInput.Trim()
        }
        
        # Get Status
        $statusInput = Read-Host "Enter Status (press Enter to keep current: '$($loadedPrompt.Status)')"
        if (-not [string]::IsNullOrWhiteSpace($statusInput)) {
            $loadedPrompt.SetStatus($statusInput.Trim())
        }
        
        # Get LLM
        $llmInput = Read-Host "Enter LLM (press Enter to keep current: '$($loadedPrompt.LLM)')"
        if (-not [string]::IsNullOrWhiteSpace($llmInput)) {
            $loadedPrompt.UpdateLLM($llmInput.Trim())
        }
        
        # Optional fields
        $nameInput = Read-Host "Enter Name (press Enter to keep current: '$($loadedPrompt.Name)')"
        if (-not [string]::IsNullOrWhiteSpace($nameInput)) {
            $loadedPrompt.Name = $nameInput.Trim()
        } elseif ([string]::IsNullOrWhiteSpace($loadedPrompt.Name)) {
            $loadedPrompt.Name = $null
        }
        
        $fileInput = Read-Host "Enter File (press Enter to keep current: '$($loadedPrompt.File)')"
        if (-not [string]::IsNullOrWhiteSpace($fileInput)) {
            $loadedPrompt.File = $fileInput.Trim()
        } elseif ([string]::IsNullOrWhiteSpace($loadedPrompt.File)) {
            $loadedPrompt.File = $null
        }
        
        $contextInput = Read-Host "Enter Context (press Enter to keep current: '$($loadedPrompt.Context)')"
        if (-not [string]::IsNullOrWhiteSpace($contextInput)) {
            $loadedPrompt.Context = $contextInput.Trim()
        } elseif ([string]::IsNullOrWhiteSpace($loadedPrompt.Context)) {
            $loadedPrompt.Context = $null
        }
        
        $reasoningInput = Read-Host "Enter Reasoning (press Enter to keep current: '$($loadedPrompt.Reasoning)')"
        if (-not [string]::IsNullOrWhiteSpace($reasoningInput)) {
            $loadedPrompt.Reasoning = $reasoningInput.Trim()
        } elseif ([string]::IsNullOrWhiteSpace($loadedPrompt.Reasoning)) {
            $loadedPrompt.Reasoning = $null
        }
        
        # Show final prompt
        Write-Host "`n=== FINAL PROMPT ===" -ForegroundColor Green
        Show-CurrentPrompt -Prompt $loadedPrompt
        
        # Confirm execution
        $execute = Read-Host "`nExecute prompt? (Y/N)"
        if ($execute -eq 'Y' -or $execute -eq 'y') {
            $loadedPrompt.Execute()
        } else {
            Write-Host "Prompt not executed." -ForegroundColor Yellow
        }
        
        # Offer to save
        $save = Read-Host "`nSave prompt to file? (Y/N)"
        if ($save -eq 'Y' -or $save -eq 'y') {
            $savePath = Read-Host "Enter file path (or press Enter for default: .\prompt.json)"
            if ([string]::IsNullOrWhiteSpace($savePath)) {
                $savePath = ".\prompt.json"
            }
            $loadedPrompt.SaveToFile($savePath)
        }
        
    } catch {
        Write-Error "Error: $($_.Exception.Message)"
    }
}

# Main execution
if ($MyInvocation.InvocationName -ne '.') {
    Invoke-PromptCreator
}