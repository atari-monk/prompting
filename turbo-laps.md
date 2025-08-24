# main.ts

## Scene Mode Setup [x]

- We have Scene Mode "all" and "current"
- In "all" mode we want to register  scenes selected for game
- In "current" mode we want to register all scenes and select one for testing by providing its index in array
- Refactor main to reflect these requirerments

# starting-grid.ts

## Convert form js to ts [x]

- Use latest typescript
- Convert from js to ts class
- Clsss must implement Scene interface
- Use rectangle-track.ts as a dependency instead of js track

# rectangle-track.ts

## Make sure state and config can be accessed by other class [x]

- use some way to make state and config accessable in other class