@echo off
taskkill /im Thetan* /F
echo Waiting 1s
timeout 1
start /b "" "C:\Program Files (x86)\Thetan Arena\Thetan Arena.exe"