# Function to move top prompt from queue to history file
function Move-QueueToHistory {
    param(
        [Parameter(Mandatory=$true)]
        [string]$QueuePath,
        [Parameter(Mandatory=$true)]
        [string]$HistoryPath,
        [switch]$RemoveFromQueue
    )
    
    if (-not (Test-Path $QueuePath)) {
        Write-Warning "Queue file not found: $QueuePath"
        return $false
    }
    
    try {
        # Load queue data
        $queueData = Get-Content -Path $QueuePath -Raw -Encoding UTF8 | ConvertFrom-Json
        
        if (-not $queueData -or $queueData.Count -eq 0) {
            Write-Warning "Queue is empty: $QueuePath"
            return $false
        }
        
        # Get the top item
        $topItem = $queueData[0]
        
        # Load or create history
        $historyData = @()
        if (Test-Path $HistoryPath) {
            $historyData = Get-Content -Path $HistoryPath -Raw -Encoding UTF8 | ConvertFrom-Json
        }
        
        # Add timestamp to the item
        $topItemWithTimestamp = $topItem | Select-Object *
        $topItemWithTimestamp | Add-Member -NotePropertyName "ProcessedDate" -NotePropertyValue (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        
        # Add to history (at the end)
        $historyData += $topItemWithTimestamp
        
        # Save history
        $historyData | ConvertTo-Json -Depth 3 | Out-File -FilePath $HistoryPath -Encoding UTF8
        
        # Remove from queue if requested
        if ($RemoveFromQueue) {
            $remainingQueue = $queueData | Select-Object -Skip 1
            $remainingQueue | ConvertTo-Json -Depth 3 | Out-File -FilePath $QueuePath -Encoding UTF8
            Write-Host "Moved top item to history and removed from queue. Remaining items: $($remainingQueue.Count)" -ForegroundColor Green
        } else {
            Write-Host "Added top item to history. Queue remains unchanged." -ForegroundColor Green
        }
        
        return $true
    }
    catch {
        Write-Error "Failed to move queue item to history: $($_.Exception.Message)"
        return $false
    }
}