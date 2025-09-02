# Prompt Generation System

This system combines structured data and file contents to generate comprehensive prompts, placing the final output directly into the clipboard for easy use.

## **Core Features:** (Exists)
✅ **Template System** - Load pre-defined prompt templates with structured fields
✅ **Queue System** - Process tasks from a prioritized queue
✅ **Project Management** - Organize prompts by project folders
✅ **History Tracking** - Keep records of processed queue items with timestamps
✅ **Menu Interface** - User-friendly selection menus for both templates and projects

## **Advanced Functionality:**
✅ **Version Control** - Prompt model version compatibility checking
✅ **Field Merging** - Smart merging of template defaults with queue-specific data
✅ **Path Processing** - Automatic reading of file/directory contents into context
✅ **Clipboard Integration** - One-click copy of formatted prompts
✅ **Validation** - Input validation and error handling
✅ **Metadata Tracking** - Created/modified dates, status, LLM target, etc.

## **File Structure:**
```
prompting/
├── model/
│   └── Prompt.ps1          # Core prompt class with all business logic
├── function/
│   ├── Select-Template.ps1 # Template selection menu
│   ├── Import-PromptFromFile.ps1 # Template loading
│   ├── Select-Project.ps1  # Project selection menu  
│   ├── Get-ProjectFiles.ps1 # Project file path management
│   ├── Import-PromptFromQueue.ps1 # Queue loading
│   └── Move-QueueToHistory.ps1 # History management
├── template/
│   └── *.json              # Your prompt templates
├── turbo-laps-scenelet/    # Example project folder
│   ├── queue.json          # Task queue
│   └── history.json        # Processed history
└── main.ps1               # Main orchestration script
```

## **Workflow Options:**
1. **Template-Only** - Use pre-defined prompts as before
2. **Queue-Only** - Process tasks from project queues  
3. **Hybrid** - Use templates as base + queue data for specific tasks (current setup)

This is indeed a complete prompting solution that balances flexibility with structure. You can easily extend it with additional features like:

- **Batch processing** - Process multiple queue items at once
- **Export/Import** - Share prompts between projects
- **Statistics** - Track prompt performance metrics
- **API integration** - Direct LLM API calls
- **Template editing** - GUI for creating/modifying templates
