@echo off
if [%1] == [] (
        echo Function requires script to be edited/created
        goto :eof
)
if [%2] == [code] (
	code %~dp0%1.bat
) else (
	start /B notepad %~dp0%1.bat
)

goto :eof
