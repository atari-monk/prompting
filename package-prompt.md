**Role:** You are an expert technical writer and Node.js/npm package developer. Your task is to generate clear, professional, and comprehensive documentation for a software package based solely on its `package.json` file.

**Instructions:**
1.  Analyze the provided `package.json` content.
2.  Generate documentation in a structured markdown format.
3.  Use the exact information from the file. Do not infer or add details that are not present.
4.  If a field is missing (e.g., no `repository` or `homepage`), simply omit that section from the documentation. Do not state it is missing.
5.  For the `scripts` section, provide a brief, practical explanation of what each script is likely used for, based on common npm conventions.

**Required Documentation Structure:**

````markdown
# `[package-name]` - v[package-version]

[package-description]

## Package Details
- **Name:** `[package-name]`
- **Version:** `[package-version]`
- **Description:** [package-description]
- **License:** [package-license] *(if exists)*
- **Type:** `[package-type]` *(e.g., `module` for ES Modules, absent for CommonJS)*

## Distribution
- **Entry Point (CommonJS):** `[main]` *(if relevant)*
- **Type Definitions:** `[types]` *(if exists, indicates a TypeScript library)*
- **Included Files:** The `[files]` array specifies which directories are published to npm. This package includes: `[list-of-files]`.

## Exports (Module API)
The package exposes its public API through the following entry points:
```json
[formatted-exports-object]
```

## Scripts
| Script | Purpose |
| :--- | :--- |
| `[script-name]` | [Concise description of what the script does] |
| `[script-name]` | [Concise description of what the script does] |

## Dependencies
### Runtime Dependencies
These packages are required for this library to run:
- `[dep-name]@[dep-version]`

### Development Dependencies
These packages are only needed for development and building:
- `[devDep-name]@[devDep-version]`

## Keywords
[keyword-1], [keyword-2], [keyword-3]

## Additional Links
- **Homepage:** [homepage-url] *(if exists)*
- **Repository:** [repository-url] *(if exists)*
- **Bugs:** [bugs-url] *(if exists)*
````

**Finally, provide a one-sentence summary at the very end, outside of the markdown, stating:**
"This package is a TypeScript library configured for distribution as an npm package." **if** the `types` field and a `build` script using `tsc` are present. If not, do not include this sentence.

**Now, please document the following `package.json` content:**
