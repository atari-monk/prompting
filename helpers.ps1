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
        
        # Date fields
        $prompt.CreatedDate = [datetime]::Parse($jsonData.CreatedDate)
        $prompt.ModifiedDate = [datetime]::Parse($jsonData.ModifiedDate)
        
        return $prompt
    }
    catch {
        Write-Error "Failed to load prompt from file: $($_.Exception.Message)"
        return $null
    }
}

# Function to create a new prompt
function New-Prompt {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Role,
        [Parameter(Mandatory=$true)]
        [string]$Task,
        [Parameter(Mandatory=$true)]
        [string]$OutputFormat,
        
        # Optional parameters
        [string]$Context,
        [string]$Reasoning,
        [string[]]$StopConditions,
        [string[]]$Paths,
        [string]$Status = "Pending",
        [string]$LLM = "DeepSeek",
        [string]$Name,
        [string]$File,
        [string[]]$Requirements,
        [string]$OutputPath
    )
    
    $prompt = [Prompt]::new(
        $Role,
        $Task,
        $OutputFormat,
        $Context,
        $Reasoning,
        $StopConditions,
        $Paths,
        $Status,
        $LLM,
        $Name,
        $File,
        $Requirements
    )
    
    if ($OutputPath) {
        $prompt.SaveToFile($OutputPath)
    }
    
    return $prompt
}

# Function to check prompt model version
function Get-PromptModelVersion {
    return $global:PromptModelVersion
}

# Function to update prompt model version (use with caution!)
function Update-PromptModelVersion {
    param(
        [Parameter(Mandatory=$true)]
        [string]$NewVersion
    )
    
    $global:PromptModelVersion = $NewVersion
    Write-Host "Prompt model version updated to: $NewVersion" -ForegroundColor Yellow
}