##############################################
# Convert form js to ts [x]
##############################################

# clipboard_collector reset
# clipboard_collector push

# merge_paths C:\Atari-Monk-Art\turbo-laps-js\src\turbo-laps\track_boundary.js C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\rectangle-track.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts 
# clipboard_collector push

# clipboard_collector pop

############################################## 
# Extract logic [x]
##############################################

# clipboard_collector reset
# clipboard_collector push

# merge_paths C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\track-boundary.ts C:\Atari-Monk-Art\turbo-laps-js\src\turbo-laps\turbo_laps.js
# clipboard_collector push

# clipboard_collector pop

############################################## 
# Integrate scenes [x]
##############################################

# clipboard_collector reset
# clipboard_collector push

# merge_paths C:\Atari-Monk-Art\turbo-laps-scenelet\src\main.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\arrow-player.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\rectangle-track.ts C:\Atari-Monk-Art\turbo-laps-scenelet\src\scenes\track-boundary.ts
# clipboard_collector push

# clipboard_collector pop