@echo off
if [%1] == [] (
        echo Function requires script to be read
        goto :eof
)
echo.
type %~dp0%1.bat
echo.