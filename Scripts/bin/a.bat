@echo off
:echo ffmpeg -i %1 -filter_complex "compand,[0:a]showwavespic=s=1280x920:mode=cline,format=yuv420p[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy %1.mp4 | clip
echo ffmpeg -i %1 -filter_complex "[0:a]showwaves=s=1280x720:mode=line:scale=log:colors=yellow,format=yuv420p[v]" -map "[v]" -map 0:a -c:v libx264 -c:a copy %1.mp4 | clip
echo Now run Ctrl+V