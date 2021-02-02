@echo off
setlocal

if [%1] == [] (
	echo Missing required parameter [file]
	call :show_help
	goto :eof
)
set "file=%1"
set "target=C:\\Dev"

mv ./*.%file% %target% 2>NUL  && echo %file% was moved to %target% || echo No %file% was moved
goto :eof


:show_help
	echo Move Dev
	echo.
	echo Moves a file or directory to the Dev directory
	echo.
	echo Usage:
	echo 	mv-dev [file]
	echo.
	echo Example:
	echo 	mv-dev name-of-file-or-directory
	goto :eof