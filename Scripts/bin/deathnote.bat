@echo off
if [%1] == [] (
	echo You need to pass a process name
	echo Example^: deathnote code
	goto :eof
)
taskkill /im %1.exe /F
