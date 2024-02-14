@echo off

for /F "usebackq tokens=2* delims=: " %%W in (`mode con ^| findstr Columns`) do set ALIAS_TERMINAL_WIDTH=%%W

set "cmd=%1"
set "args=%2 %3 %4 %5 %6 %7 %8 %9"
if [%2] == [--list] (
    run-js view-alias-path
    exit /b 0
) 
if [%2] == [-l] (
    run-js view-alias-path
    exit /b 0
)
FOR /F "tokens=*" %%g IN ('run-js get-alias-path %args%') do (set NEXT_GO_TO_PATH=%%g)
%cmd% %NEXT_GO_TO_PATH%

set "NEXT_GO_TO_PATH="