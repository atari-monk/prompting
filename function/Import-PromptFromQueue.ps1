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
        
        # Get the first (topmost) item from the queue
        $queueItem = $queueData[0]
        
        $prompt = [Prompt]::new()
        
        # Only set fields that exist in the queue item
        if ($queueItem.Task) { $prompt.Task = $queueItem.Task }
        if ($queueItem.Requirements) { $prompt.Requirements = $queueItem.Requirements }
        if ($queueItem.Paths) { $prompt.Paths = $queueItem.Paths }
        if ($queueItem.Result) { $prompt.Result = $queueItem.Result }
        
        return $prompt
    }
    catch {
        Write-Error "Failed to load prompt from queue: $($_.Exception.Message)"
        return $null
    }
}