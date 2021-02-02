@echo off

if %1 == start (
	watchman watch C:\Users\tijuk\AppData\Roaming\nvm\v15.5.0\node_modules\wml\src
	goto :eof
)
if %1 == end (
	echo Killing watchers
	watchman watch-del-all
	echo Cleaning Up WML
	wml rm all
	goto :eof
)
echo Invalid watch arguments
echo Valid args are either [start] or [stop]