## Script [x]

- Py script
- Hard coded input path with yaml files
- Hard coded output path for md files
- Main for entry point
- Converts my log yaml files to md
- Strict typing with pylance
- There should be validation of yamls format and skip wrong files
- Multiple projects have yaml log format, turbo-laps is just one example, generalize it as just format, content dosent matter it this case
- Make sure to write it in a way that will pass pylance validation
- If it is smart then use pydantic to model our format
- DO Not use any comments, code should self document

## Printout Colors [x]

- Print converted in green and skipped in red

## Validation Errors [x]

- Why this yaml file was skipped ?

## Ignore Daily Stats File in logs script [x]

- productivity_logs script should ignore file "C:\Atari-Monk-Art\productivity\content\daily-projects.yaml"