@echo off
setlocal

set VIDEO_INPUT=C:\Users\Administrator\Desktop\123.mp4
set AUDIO_INPUT=C:\Users\Administrator\Desktop\audio_segments\segment_000.wav
set VIDEO_OUTPUT=C:\Users\Administrator\Desktop\123_final.mp4

echo Merging audio and video...

ffmpeg -y -i "%VIDEO_INPUT%" -i "%AUDIO_INPUT%" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest "%VIDEO_OUTPUT%"

if %ERRORLEVEL% EQU 0 (
    echo Success! Output: %VIDEO_OUTPUT%
) else (
    echo Failed to merge video and audio.
)

pause
