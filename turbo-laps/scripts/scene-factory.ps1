##############################################
# Scene Factory [x]
##############################################

# clipboard_collector reset
# clipboard_collector push

# merge_paths "C:\Atari-Monk-Art\turbo-laps-scenelet\src\register-single-scene.ts"
# clipboard_collector push

# clipboard_collector pop

##############################################
# Use factory [x]
##############################################

# clipboard_collector reset
# clipboard_collector push

# merge_paths C:\Atari-Monk-Art\turbo-laps-scenelet\src\scene-factory.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts "C:\Atari-Monk-Art\turbo-laps-scenelet\src\register-single-scene.ts" "C:\Atari-Monk-Art\turbo-laps-scenelet\src\register-multi-scene.ts"
# clipboard_collector push

# clipboard_collector pop

##############################################
# Check implementation []
##############################################

clipboard_collector reset
clipboard_collector push

merge_paths C:\Atari-Monk-Art\turbo-laps-scenelet\src\scene-factory.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts
clipboard_collector push

clipboard_collector pop