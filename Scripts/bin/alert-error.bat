@echo off
start "SERVICE CRASH ALERT" cmd /c "echo SERVICE CRASH ALERT && echo %* && echo. && pause"
exit /B 1