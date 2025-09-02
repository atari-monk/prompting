# Function to load a prompt from JSON file with version checking
function Import-PromptFromFile {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath,
        [switch]$Force
    )
    
    if (-not (Test-Path $FilePath)) {
        throw "File not found: $FilePath"
    }
    
    try {
        $jsonData = Get-Content -Path $FilePath -Raw -Encoding UTF8 | ConvertFrom-Json
        
        $prompt = [Prompt]::new()
        
        # Check version compatibility
        if ($jsonData.PromptModelVersion -ne $global:PromptModelVersion -and -not $Force) {
            Write-Warning "Prompt model version mismatch: File=$($jsonData.PromptModelVersion), Current=$global:PromptModelVersion"
            Write-Warning "Use -Force to load anyway, but some features may not work correctly"
            return $null
        }
        
        # Required fields
        $prompt.Role = $jsonData.Role
        $prompt.Task = $jsonData.Task
        $prompt.OutputFormat = $jsonData.OutputFormat
        
        # Optional fields
        $prompt.Context = $jsonData.Context
        $prompt.Reasoning = $jsonData.Reasoning
        $prompt.StopConditions = $jsonData.StopConditions
        $prompt.Paths = $jsonData.Paths
        $prompt.Status = $jsonData.Status
        $prompt.LLM = $jsonData.LLM
        $prompt.Name = $jsonData.Name
        $prompt.File = $jsonData.File
        $prompt.Requirements = $jsonData.Requirements
        $prompt.PromptModelVersion = $jsonData.PromptModelVersion
        
        # Date fields - handle null/empty values by using current date
        if (-not [string]::IsNullOrEmpty($jsonData.CreatedDate)) {
            $prompt.CreatedDate = [datetime]::Parse($jsonData.CreatedDate)
        } else {
            $prompt.CreatedDate = Get-Date
        }
        
        if (-not [string]::IsNullOrEmpty($jsonData.ModifiedDate)) {
            $prompt.ModifiedDate = [datetime]::Parse($jsonData.ModifiedDate)
        } else {
            $prompt.ModifiedDate = Get-Date
        }
        
        return $prompt
    }
    catch {
        Write-Error "Failed to load prompt from file: $($_.Exception.Message)"
        return $null
    }
}
