Role: Senior Developer (typescript)
Task: Extend mouse-cursor scene
Requirements:
- Render clicked points as small red rects, where point is in center
Reasoning: Use SOLID, best/proven/latest practices
Stop Conditions: Requrierments implemented
Output Format: Self documenting, latest typescript, do not use any comments
Created: 2025-09-02 20:36:38
Last Modified: 2025-09-02 20:36:43
Status: In Progress
LLM: DeepSeek
Prompt Model Version: 0.0.1
Paths: C:/Atari-Monk-Art/turbo-laps-scenelet/src/scenes/mouse-cursor.ts
Path Contents:
File: C:/Atari-Monk-Art/turbo-laps-scenelet/src/scenes/mouse-cursor.ts
Content:
```ts
import type { InputSystem, Scene } from "zippy-game-engine";
import type { FrameContext } from "zippy-shared-lib";

export class MouseCursor implements Scene {
    private static readonly NAME = "Mouse-Cursor";
    private static readonly DISPLAY_NAME = "Mouse Cursor";
    private previousButtonState: boolean = false;

    readonly name = MouseCursor.NAME;
    readonly displayName = MouseCursor.DISPLAY_NAME;

    constructor(private inputSystem: InputSystem) {}

    update(_context: FrameContext): void {
        const mousePosition = this.inputSystem.mouse.getPosition();
        const currentButtonState = this.inputSystem.mouse.isButtonDown(0);

        if (currentButtonState && !this.previousButtonState) {
            console.log(
                `Click at position: X: ${mousePosition.x}, Y: ${mousePosition.y}`
            );
        }

        this.previousButtonState = currentButtonState;
    }
}
```
