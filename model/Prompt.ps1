# Prompt model version
$global:PromptModelVersion = "0.0.1"

class Prompt {
    # Required fields (must be provided during construction)
    [string]$Role
    [string]$Task
    [string]$OutputFormat
    
    # Optional fields (can be empty/null)
    [string]$Context
    [string]$Reasoning
    [string[]]$StopConditions
    [string[]]$Paths
    [string]$Name
    [string]$File
    [string[]]$Requirements
    [string]$Result 

    # System fields (auto-managed)
    [string]$Status
    [string]$LLM
    [datetime]$CreatedDate
    [datetime]$ModifiedDate
    [string]$PromptModelVersion = $global:PromptModelVersion
    
    # Default constructor for deserialization
    Prompt() {
        $this.CreatedDate = Get-Date
        $this.ModifiedDate = Get-Date
        $this.Status = "Pending"
        $this.LLM = "DeepSeek"
        $this.PromptModelVersion = $global:PromptModelVersion
    }
    
    # Main constructor with required fields
    Prompt(
        [string]$role,
        [string]$task,
        [string]$outputFormat
    ) {
        $this.Role = $role
        $this.Task = $task
        $this.OutputFormat = $outputFormat
        $this.CreatedDate = Get-Date
        $this.ModifiedDate = Get-Date
        $this.Status = "Pending"
        $this.LLM = "DeepSeek"
        $this.PromptModelVersion = $global:PromptModelVersion
    }
    
    # Full constructor with all optional fields
    Prompt(
        [string]$role,
        [string]$task,
        [string]$outputFormat,
        [string]$context,
        [string]$reasoning,
        [string[]]$stopConditions,
        [string[]]$paths,
        [string]$status,
        [string]$llm,
        [string]$name,
        [string]$file,
        [string[]]$requirements,
        [string]$result
    ) {
        $this.Role = $role
        $this.Task = $task
        $this.OutputFormat = $outputFormat
        $this.Context = $context
        $this.Reasoning = $reasoning
        $this.StopConditions = $stopConditions
        $this.Paths = $paths
        $this.SetStatus($status)
        $this.LLM = $llm
        $this.Name = $name
        $this.File = $file
        $this.Requirements = $requirements
        $this.Result = $result
        $this.CreatedDate = Get-Date
        $this.ModifiedDate = Get-Date
        $this.PromptModelVersion = $global:PromptModelVersion
    }
    
    [void]SetStatus([string]$status) {
        $validStatus = @("Pending", "In Progress", "Done", "Blocked", "Archived")
        if ($status -notin $validStatus) {
            throw "Status must be one of: $($validStatus -join ', '). Received: '$status'"
        }
        $this.Status = $status
        $this.ModifiedDate = Get-Date
    }
    
    [void]UpdateLLM([string]$newLLM) {
        $this.LLM = $newLLM
        $this.ModifiedDate = Get-Date
    }
    
    [string]GetCombinedText() {
        $combinedText = @()
        
        # Core prompt components (required)
        $combinedText += "Role: $($this.Role)"
        $combinedText += "Task: $($this.Task)"
        $combinedText += "Output Format: $($this.OutputFormat)"
        
        # Optional components
        if (-not [string]::IsNullOrEmpty($this.Context)) {
            $combinedText += "Context: $($this.Context)"
        }
        
        if (-not [string]::IsNullOrEmpty($this.Reasoning)) {
            $combinedText += "Reasoning: $($this.Reasoning)"
        }
        
        if ($this.StopConditions -and $this.StopConditions.Count -gt 0) {
            $combinedText += "Stop Conditions: $($this.StopConditions -join ', ')"
        }
        
        if ($this.Requirements -and $this.Requirements.Count -gt 0) {
            $combinedText += "Requirements:"
            foreach ($req in $this.Requirements) {
                $combinedText += "- $req"
            }
        }
        
        # Metadata
        $combinedText += "Status: $($this.Status)"
        $combinedText += "LLM: $($this.LLM)"
        $combinedText += "Prompt Model Version: $($this.PromptModelVersion)"
        $combinedText += "Created: $($this.CreatedDate.ToString('yyyy-MM-dd HH:mm:ss'))"
        $combinedText += "Last Modified: $($this.ModifiedDate.ToString('yyyy-MM-dd HH:mm:ss'))"
        
        if (-not [string]::IsNullOrEmpty($this.Name)) {
            $combinedText += "Name: $($this.Name)"
        }
        
        if (-not [string]::IsNullOrEmpty($this.File)) {
            $combinedText += "File: $($this.File)"
        }
        
        if ($this.Paths -and $this.Paths.Count -gt 0) {
            $combinedText += "Paths: $($this.Paths -join ', ')"
        }
        
        # Status-specific message
        if ($this.Status -eq "Done") {
            $combinedText += "Note: Status is Done - this prompt was already implemented, just verify the results"
        }
        
        # Add path content to context
        if ($this.Paths -and $this.Paths.Count -gt 0) {
            $pathContent = @()
            foreach ($path in $this.Paths) {
                if (Test-Path $path) {
                    if (Get-Item $path -ErrorAction SilentlyContinue | Where-Object { $_.PSIsContainer }) {
                        $pathContent += "Directory: $path (contents not read)"
                    } else {
                        try {
                            $content = Get-Content $path -Raw -ErrorAction Stop
                            $pathContent += "File: $path`nContent:`n$content`n"
                        } catch {
                            $pathContent += "File: $path (error reading: $($_.Exception.Message))"
                        }
                    }
                }
            }
            if ($pathContent.Count -gt 0) {
                $combinedText += "Path Contents:`n$($pathContent -join "`n---`n")"
            }
        }

        return $combinedText -join "`r`n"
    }
    
    [void]Execute() {
        # Validate paths
        $validPaths = @()
        if ($this.Paths -and $this.Paths.Count -gt 0) {
            foreach ($path in $this.Paths) {
                if (Test-Path $path) {
                    $validPaths += $path
                } else {
                    Write-Warning "Path not found: $path"
                }
            }
            $this.Paths = $validPaths
        }
        
        # Update status
        if ($this.Status -eq "Pending") {
            $this.SetStatus("In Progress")
        }
        
        # Get enhanced combined text with path contents
        $combinedText = $this.GetCombinedText()
        
        # Copy to clipboard
        try {
            Set-Clipboard -Value $combinedText
            Write-Host "Prompt executed and copied to clipboard!" -ForegroundColor Green
            Write-Host "Character count: $($combinedText.Length)" -ForegroundColor Cyan
        } catch {
            Write-Error "Failed to copy to clipboard: $($_.Exception.Message)"
            Write-Host "Prompt text:`n$combinedText" -ForegroundColor Yellow
        }
    }
    
    # Save to file
    [void]SaveToFile([string]$filePath) {
        $data = @{
            PromptModelVersion = $this.PromptModelVersion
            Role = $this.Role
            Task = $this.Task
            OutputFormat = $this.OutputFormat
            Context = $this.Context
            Reasoning = $this.Reasoning
            StopConditions = $this.StopConditions
            Paths = $this.Paths
            Status = $this.Status
            LLM = $this.LLM
            CreatedDate = $this.CreatedDate.ToString('o')
            ModifiedDate = $this.ModifiedDate.ToString('o')
            Name = $this.Name
            File = $this.File
            Requirements = $this.Requirements
            Result = $this.Result
        }
        
        $data | ConvertTo-Json -Depth 3 | Out-File -FilePath $filePath -Encoding UTF8
        Write-Host "Prompt saved to: $filePath" -ForegroundColor Green
    }
    
    # Validate prompt model version compatibility
    [bool]IsCompatible() {
        return $this.PromptModelVersion -eq $global:PromptModelVersion
    }
    
    # Helper method to get prompt summary
    [string]GetSummary() {
        $taskPreview = if ($this.Task.Length -gt 50) { 
            $this.Task.Substring(0, 47) + "..." 
        } else { 
            $this.Task 
        }
        
        return @"
Prompt Summary:
- Name: $(if ($this.Name) { $this.Name } else { "N/A" })
- Role: $($this.Role)
- Task: $taskPreview
- Status: $($this.Status)
- LLM: $($this.LLM)
- Prompt Model: $($this.PromptModelVersion)
- Created: $($this.CreatedDate.ToString('yyyy-MM-dd'))
- Paths: $(if ($this.Paths) { $this.Paths.Count } else { 0 })
- Requirements: $(if ($this.Requirements) { $this.Requirements.Count } else { 0 })
"@
    }
}