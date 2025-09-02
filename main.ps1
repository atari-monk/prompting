# Main script for template selection and prompt loading with prompt.json merging
param(
    [string]$TemplatesPath = "C:/Atari-Monk-Art/prompting/templates",
    [string]$PromptJsonPath = "C:/Atari-Monk-Art/prompting/prompt.json",
    [switch]$Force
)

# Import required modules
. "C:/Atari-Monk-Art/prompting/Prompt.ps1"
. "C:/Atari-Monk-Art/prompting/helpers.ps1"

function Show-TemplateMenu {
    param(
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        Write-Error "Templates directory not found: $Path"
        return $null
    }
    
    $templateFiles = Get-ChildItem -Path $Path -Filter "*.json" -File
    if ($templateFiles.Count -eq 0) {
        Write-Host "No template files found in: $Path" -ForegroundColor Yellow
        return $null
    }
    
    Write-Host "`n=== Available Templates ===" -ForegroundColor Cyan
    Write-Host "0. Exit" -ForegroundColor Yellow
    
    $menuItems = @()
    for ($i = 0; $i -lt $templateFiles.Count; $i++) {
        $templateFile = $templateFiles[$i]
        $templateNumber = $i + 1
        
        try {
            $templateData = Get-Content -Path $templateFile.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
            $role = $templateData.Role
            $taskPreview = if ($templateData.Task.Length -gt 40) { 
                $templateData.Task.Substring(0, 37) + "..." 
            } else { 
                $templateData.Task 
            }
            
            Write-Host "$templateNumber. [$role] $taskPreview" -ForegroundColor White
            $menuItems += @{
                Number = $templateNumber
                FilePath = $templateFile.FullName
                Role = $role
                Task = $templateData.Task
            }
        }
        catch {
            Write-Host "$templateNumber. [Error] Could not read: $($templateFile.Name)" -ForegroundColor Red
            $menuItems += @{
                Number = $templateNumber
                FilePath = $templateFile.FullName
                Role = "Error"
                Task = "Could not read template"
            }
        }
    }
    
    Write-Host "`nSelect a template (0 to exit): " -ForegroundColor Green -NoNewline
    $selection = Read-Host
    
    if ($selection -eq "0") {
        Write-Host "Exiting..." -ForegroundColor Yellow
        return $null
    }
    
    if (-not $selection -or -not ($selection -match "^\d+$")) {
        Write-Host "Invalid selection. Please enter a number." -ForegroundColor Red
        return $null
    }
    
    $selectedNumber = [int]$selection
    if ($selectedNumber -lt 1 -or $selectedNumber -gt $menuItems.Count) {
        Write-Host "Invalid selection. Please choose between 1 and $($menuItems.Count)." -ForegroundColor Red
        return $null
    }
    
    $selectedItem = $menuItems[$selectedNumber - 1]
    return $selectedItem.FilePath
}

function Load-PromptJson {
    param(
        [string]$FilePath,
        [switch]$Force
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Warning "prompt.json not found at: $FilePath"
        return $null
    }
    
    try {
        $jsonData = Get-Content -Path $FilePath -Raw -Encoding UTF8 | ConvertFrom-Json
        
        # Create a minimal prompt object with only the fields we need
        $promptData = @{
            Task = $jsonData.Task
            Requirements = $jsonData.Requirements
            Paths = $jsonData.Paths
            PromptModelVersion = $jsonData.PromptModelVersion
        }
        
        Write-Host "Loaded prompt.json successfully" -ForegroundColor Green
        return $promptData
    }
    catch {
        Write-Error "Failed to load prompt.json: $($_.Exception.Message)"
        return $null
    }
}

function Merge-PromptWithTemplate {
    param(
        [object]$BasePrompt,
        [object]$TemplatePrompt,
        [switch]$Force
    )
    
    # Create a new prompt object based on the template
    $mergedPrompt = [Prompt]::new()
    
    # Copy all properties from template first
    $templateProps = $TemplatePrompt | Get-Member -MemberType Properties | Where-Object { $_.Name -notin @('CreatedDate', 'ModifiedDate') }
    foreach ($prop in $templateProps) {
        $propName = $prop.Name
        $propValue = $TemplatePrompt.$propName
        if ($null -ne $propValue -and $propValue -ne "") {
            $mergedPrompt.$propName = $propValue
        }
    }
    
    # Override with values from prompt.json where they exist
    if ($BasePrompt.Task) {
        $mergedPrompt.Task = $BasePrompt.Task
    }
    
    if ($BasePrompt.Requirements -and $BasePrompt.Requirements.Count -gt 0) {
        $mergedPrompt.Requirements = $BasePrompt.Requirements
    }
    
    if ($BasePrompt.Paths -and $BasePrompt.Paths.Count -gt 0) {
        # Merge paths, avoiding duplicates
        $allPaths = @()
        if ($mergedPrompt.Paths) {
            $allPaths += $mergedPrompt.Paths
        }
        $allPaths += $BasePrompt.Paths | Where-Object { $_ -notin $allPaths }
        $mergedPrompt.Paths = $allPaths
    }
    
    # Update metadata
    $mergedPrompt.ModifiedDate = Get-Date
    $mergedPrompt.Status = "In Progress"
    
    return $mergedPrompt
}

function Load-SelectedTemplate {
    param(
        [string]$TemplatePath,
        [object]$PromptJsonData,
        [switch]$Force
    )
    
    try {
        $templatePrompt = Import-PromptFromFile -FilePath $TemplatePath -Force:$Force
        if (-not $templatePrompt) {
            Write-Error "Failed to load template from: $TemplatePath"
            return $null
        }
        
        # If we have prompt.json data, merge it with the template
        if ($PromptJsonData) {
            $mergedPrompt = Merge-PromptWithTemplate -BasePrompt $PromptJsonData -TemplatePrompt $templatePrompt -Force:$Force
            Write-Host "`n=== Merged Prompt (Template + prompt.json) ===" -ForegroundColor Green
        } else {
            $mergedPrompt = $templatePrompt
            Write-Host "`n=== Loaded Template ===" -ForegroundColor Green
        }
        
        Write-Host "Role: $($mergedPrompt.Role)" -ForegroundColor Cyan
        Write-Host "Task: $($mergedPrompt.Task)" -ForegroundColor Cyan
        Write-Host "Output Format: $($mergedPrompt.OutputFormat)" -ForegroundColor Cyan
        
        if ($mergedPrompt.Requirements -and $mergedPrompt.Requirements.Count -gt 0) {
            Write-Host "Requirements:" -ForegroundColor Cyan
            foreach ($req in $mergedPrompt.Requirements) {
                Write-Host "  - $req" -ForegroundColor White
            }
        }
        
        if ($mergedPrompt.Paths -and $mergedPrompt.Paths.Count -gt 0) {
            Write-Host "Paths: $($mergedPrompt.Paths.Count)" -ForegroundColor Cyan
        }
        
        Write-Host "`nPrompt loaded successfully!" -ForegroundColor Green
        return $mergedPrompt
    }
    catch {
        Write-Error "Error loading template: $($_.Exception.Message)"
        return $null
    }
}

function Main {
    Write-Host "=== Template Loader with prompt.json Merging ===" -ForegroundColor Magenta
    Write-Host "Loading templates from: $TemplatesPath" -ForegroundColor Gray
    
    # Load prompt.json first
    $promptJsonData = Load-PromptJson -FilePath $PromptJsonPath -Force:$Force
    if ($promptJsonData) {
        Write-Host "Loaded prompt.json with task: $($promptJsonData.Task)" -ForegroundColor Cyan
    } else {
        Write-Host "No prompt.json loaded, will use template as-is" -ForegroundColor Yellow
    }
    
    $selectedTemplatePath = Show-TemplateMenu -Path $TemplatesPath
    if (-not $selectedTemplatePath) {
        return
    }
    
    $prompt = Load-SelectedTemplate -TemplatePath $selectedTemplatePath -PromptJsonData $promptJsonData -Force:$Force
    if (-not $prompt) {
        return
    }
    
    # Ask user if they want to execute the prompt
    Write-Host "`nDo you want to execute this prompt? (Y/N): " -ForegroundColor Green -NoNewline
    $executeChoice = Read-Host
    
    if ($executeChoice -eq "Y" -or $executeChoice -eq "y") {
        Write-Host "Executing prompt..." -ForegroundColor Yellow
        $prompt.Execute()
    }
    else {
        Write-Host "Prompt loaded but not executed." -ForegroundColor Yellow
        Write-Host "You can access it via `$prompt variable." -ForegroundColor Gray
    }
}

# Execute main function
Main