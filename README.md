# prompting

## Project structure (outdated)

prompting/
├── documentation-prompts/                     - Generic prompts shared by projects
├── notes/                                     - Notes (gitignored)
├── output/                                    - Store for output (gitignored)
├── scripts/                                   - Project folder
│   ├── prompts/                               - Prompts, each code file has its own md file
│   └── scripts/                               - Scripts generating prompts
├── turbo-laps/                                - Project folder
│   ├── data/                                  - Project meta data
│   ├── prompts/
│   ├── scripts/
├── .gitignore
└── README.md

## Usage

```sh
.\main.ps1 -SpecificPrompts 'lap-tracker:sectionFixPrompt'
```