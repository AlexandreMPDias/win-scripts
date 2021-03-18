@echo off

set "cmd=%1"
set "args=%2 %3 %4 %5 %6 %7 %8 %9"
FOR /F "tokens=*" %%g IN ('run-js get-alias-path %args%') do (set NEXT_GO_TO_PATH=%%g)
%cmd% %NEXT_GO_TO_PATH%

set "NEXT_GO_TO_PATH="