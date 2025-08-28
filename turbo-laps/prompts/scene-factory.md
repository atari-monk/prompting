# scene-factory.ts

## Scene Factory [x]

- Dont u think given register-single-scene.ts
- It would be nice to have a scenes factory ?
- Nice to have some enum of scenes
- Given scene name from enum factory should produce new instance
- Provide all dependencies
- By default all it should generate new instances and dependencies
- For testing purposes, each scene should be independent and not share state
- So factory should always create new instances without caching
- Just do simplest factory with function for each instance produced
- Also provide method that takes enum with scene and returns instance for convinience
- Do it only for single scenes for now

## Use factory [x]

- Lets use factory in a correct way
- Need to test each scene in separation
- Had register-single-scene.ts
- Now we can maybe skip it and use factory in main directly ?
- What do u propose ?
- Make composite scene into MultiSceneType
- Make factory to create those scenes
- Scene mode all is for MultiSceneType
- Current is for SceneType
- MultiSceneType needs scenes to be registered 
- SceneType also registers but just one scene
- I am think

## Check implementation []

- Check if i implemented ok
- Keep in mind, cureent is for single scene registration
- All mode is for multi registration where we need to register each scene stated in create of multi
- Only single scene (current mode) needs transition, in all mode they all run