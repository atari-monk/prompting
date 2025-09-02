# Function to load the topmost prompt from a queue file
function Import-PromptFromQueue {
    param(
        [Parameter(Mandatory=$true)]
        [string]$QueuePath,
        [switch]$Force
    )
    
    if (-not (Test-Path $QueuePath)) {
        throw "Queue file not found: $QueuePath"
    }
    
    try {
        $queueData = Get-Content -Path $QueuePath -Raw -Encoding UTF8 | ConvertFrom-Json
        
        if (-not $queueData -or $queueData.Count -eq 0) {
            Write-Warning "Queue is empty: $QueuePath"
            return $null
        }
        
        # Get the first (topmost) item from the queue array
        $queueItem = $queueData[0]
        
        $prompt = [Prompt]::new()
        
        # Only set fields that exist in the queue item (prompt object)
        if ($queueItem.PSObject.Properties['Task']) { $prompt.Task = $queueItem.Task }
        if ($queueItem.PSObject.Properties['Requirements']) { $prompt.Requirements = $queueItem.Requirements }
        if ($queueItem.PSObject.Properties['Paths']) { $prompt.Paths = $queueItem.Paths }
        if ($queueItem.PSObject.Properties['Result']) { $prompt.Result = $queueItem.Result }
        if ($queueItem.PSObject.Properties['Role']) { $prompt.Role = $queueItem.Role }
        if ($queueItem.PSObject.Properties['OutputFormat']) { $prompt.OutputFormat = $queueItem.OutputFormat }
        
        return $prompt
    }
    catch {
        Write-Error "Failed to load prompt from queue: $($_.Exception.Message)"
        return $null
    }
}