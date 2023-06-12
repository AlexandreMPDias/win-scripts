@echo off
setlocal

set "SILENT=%1"

if [%SILENT%] == [--silent] (
	goto check_silent_permissions
) else (
	goto check_permissions
)

exit 0

:check_permissions
    echo Administrative permissions required. Detecting permissions...
    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate.
    )
    echo.
    pause
    exit 0

:check_silent_permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo 1
    ) else (
        echo 0
    )
    exit 0