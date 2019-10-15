@echo off
setlocal

set "innerBin=%~dp0../inner_bin"

if [%1] == [] (
	echo [Awesome] Invalid command.
	echo Valid commands are [update], [path_update]
	goto :eof
)
if [%1] == [new] (
	if [%2] == [] (
		echo Error: Script Name not set
		goto :eof
	)
	echo.>%~dp0%2.bat
	edit %2
	goto :eof
)
if [%1] == [path_update] (
	%innerBin%/path_update.bat %2
	goto :eof
)
if [%1] == [update] (
	
	cd %~dp0../..
	
	echo Pulling...
	
	git pull
	
	if [%2] NEQ [] (
		
		git add *

		echo Commiting %2

		git commit -m %2
		echo Pushing...

		git push
	)

	cd %cd%

	goto :eof

)

goto :eof