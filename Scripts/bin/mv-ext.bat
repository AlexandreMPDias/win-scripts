@echo off
setlocal

if [%1] == [] (
	echo Invalid extension set
	call :show_help
	goto :eof
)
set "ext=%1"
set "target=%2"
if [%2] == [] (
	set "target=./%1s"
)
mv ./*.%ext% %target% 2>NUL  && echo %ext% file(s) were moved to %target% || echo No %ext% file moved
goto :eof


:show_help
	echo Move Extension
	echo.
	echo Moves all files from a given extension to a target directory
	echo.
	echo Usage:
	echo 	mv-ext [extension] (output-directory)
	echo.
	echo Example:
	echo 	mv-ext json
	echo 	mv-ext json ./dir/jsons
	goto :eof