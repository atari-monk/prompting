class Prompt {
    [string]$File
    [string]$Name
    [string]$Text
    [string[]]$Paths
    [string]$Status
    
    Prompt([string]$file, [string]$name, [string]$status, [string]$text, [string[]]$paths) {
        $this.File = $file
        $this.Name = $name
        $this.Text = $text
        $this.Paths = $paths
        $this.SetStatus($status)
    }
    
    [void]SetStatus([string]$status) {
        if ($status -notin @("Pending", "Done")) {
            throw "Status must be either 'Pending' or 'Done'. Received: '$status'"
        }
        $this.Status = $status
    }
    
    [string]GetCombinedText() {
        $combinedText = @()
        
        if (-not [string]::IsNullOrEmpty($this.File)) {
            $combinedText += "File: $($this.File)"
        }
        
        if (-not [string]::IsNullOrEmpty($this.Name)) {
            $combinedText += "Name: $($this.Name)"
        }
        
        if (-not [string]::IsNullOrEmpty($this.Status)) {
            $combinedText += "Status: $($this.Status)"
        }
        
        if (-not [string]::IsNullOrEmpty($this.Text)) {
            $combinedText += "Text: $($this.Text)"
        }
        
        if ($this.Status -eq "Done") {
            $combinedText += "Status is Done so it was already implemented, just check it"
        }

        return $combinedText -join "`r`n"
    }
    
    [void]Execute() {
        foreach ($path in $this.Paths) {
            if (-not (Test-Path $path)) {
                Write-Warning "Path not found: $path"
            }
        }
        
        # Use the combined text instead of just $this.Text
        $combinedText = $this.GetCombinedText()
        Set-Clipboard -Value $combinedText
        
        clipboard_collector reset
        clipboard_collector push
        
        merge_paths $this.Paths
        clipboard_collector push
        
        clipboard_collector pop
    }
}