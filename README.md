# Prompt Generation System

This system combines structured data and file contents to generate comprehensive prompts, placing the final output directly into the clipboard for easy use.

## Evolution

### Stage 1: Scripts and Markdown Files

The initial solution used scripts from a personal scripts repository. Prompts were defined in Markdown (`.md`) files and managed with PowerShell (`.ps1`) scripts. A script would copy a specific prompt from a list in the MD file and provide commands and file paths for context. This resulted in the complete prompt text being placed in the clipboard.

**Drawback:** Requiring a separate pair of MD and PS1 files for each project became inconvenient.

### Stage 2: Integrated Prompt Model

A model was defined to structure the prompt data. This stage used a single PS1 file per project to define all prompts. Scripts from the central repository were still used to assemble the prompt data and file contents into the clipboard. A main script allowed for importing all prompts and executing them by name.

**Result:** The output (the assembled prompt text) was still delivered to the clipboard.

### Stage 3: JSON-Based Model

A new, improved model was implemented. This version reads from JSON data and external files, combines them, and places the final prompt into the clipboard.

**Benefits:** The system is now simple (one model class with helpers), flexible, and easily expandable. New, specialized models can be created based on this foundation.
