. ("C:\Atari-Monk-Art\prompting\Prompt.ps1")
. ("C:\Atari-Monk-Art\prompting\helpers.ps1")

# Example 1: Create a basic prompt (only required fields)
$basicPrompt = New-Prompt -Role "AI Assistant" -Task "Help with PowerShell scripting" -OutputFormat "Code with comments"

# Example 2: Create a detailed prompt with all optional fields
$detailedPrompt = New-Prompt `
    -Role "Senior Developer" `
    -Task "Create a function to process JSON data" `
    -OutputFormat "PowerShell function with error handling" `
    -Context "Working on data processing pipeline" `
    -Reasoning "Need robust JSON handling for production environment" `
    -StopConditions @("Function works", "Error handling implemented", "Tests pass") `
    -Paths @("C:\Data\", "C:\Scripts\") `
    -LLM "DeepSeek" `
    -Name "JSONProcessor" `
    -File "json_processor.json" `
    -Requirements @(
        "Robust error handling for malformed JSON",
        "Support for large files (>100MB)",
        "Memory efficiency",
        "Proper input validation",
        "Comprehensive unit tests"
    )

# Example 3: Save to file
$detailedPrompt.SaveToFile(".\examples/my_prompt.json")

# Example 4: Load from file
$loadedPrompt = Import-PromptFromFile -FilePath ".\examples/my_prompt.json"

# Example 5: Execute the prompt
$loadedPrompt.Execute()

# Example 6: Check version compatibility
if ($loadedPrompt.IsCompatible()) {
    Write-Host "Prompt is compatible with current model version" -ForegroundColor Green
} else {
    Write-Host "Prompt version mismatch!" -ForegroundColor Red
}

# Example 7: Get current model version
Write-Host "Current Prompt Model Version: $(Get-PromptModelVersion)"

# Example 8: Create prompt with different LLM
$gptPrompt = New-Prompt `
    -Role "Code Reviewer" `
    -Task "Review TypeScript code for best practices" `
    -OutputFormat "Detailed review report" `
    -LLM "GPT-4" `
    -Requirements @(
        "Check for TypeScript best practices",
        "Identify potential bugs",
        "Suggest performance improvements",
        "Verify SOLID principles compliance"
    )

# Example 9: Update LLM for an existing prompt
$basicPrompt.UpdateLLM("Claude-3")

# Example 10: Display prompt summary
Write-Host $detailedPrompt.GetSummary()