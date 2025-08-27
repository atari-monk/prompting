# lap-tracker.ts

## Convert form js to ts [x]

- Use latest typescript
- Convert from js to ts class
- Class must implement Scene interface
- Use rectangle-track.ts as a dependency instead of js track
- Use arrow-player.ts instead of car in update
- Use ctor DI for player
- Mod player if access for its elements is needed

## Integrate LapTracker with main.ts [x]

- Generate instance
- Register
- Scene in both modes
- Show just changes

## Stop lap tracker [x]

- It shouldnt start automatically
- Provide interface to start/stop/reset it

## Stop after race [x]

- Stop lap tracker when race is over

## There is a bug []

- After 1 lap is made, stop() should run
- Break point dosent hit
- This is becouse handler is null, make it set in ctor
