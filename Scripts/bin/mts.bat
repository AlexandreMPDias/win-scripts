@echo off
setlocal
set "target=C:\\Alexandre\\bin\\NSFW"

call :move_files .mp4
call :move_files .mkv

goto :eof

:move_files
	set "ext=%1"
	mv C:\\Users\\tijuk\\Downloads\\*%ext% %target% 2>NUL && echo %ext% files were moved to %target% || echo No %ext% file moved
	goto :eof