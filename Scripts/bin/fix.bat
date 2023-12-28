@echo off
if [%1] == [] (
	echo Error: invalid usage
	echo Usage: fix [key]
	echo ValidKeys: [reset_internet],[restart_computer][cpu_usage]
	goto :eof
)

if [%1] == [cpu_usage] (
	if [%2] == [] (
		echo "Not level."
		echo "You can set the level by calling: [fix cpu_usage --level N]"
		call :cpu_usage 1
		goto :eof
	)
	if "%2" == "--level" (
		set /a level=%3
		if [%3] == [1] (
			call :cpu_usage 1
			goto :eof
		)
		if [%3] == [2] (
			call :cpu_usage 1
			call :cpu_usage 2
			goto :eof
		)
		if [%3] == [3] (
			call :cpu_usage 1
			call :cpu_usage 2
			call :cpu_usage 3
			goto :eof
		)
	)
	goto :eof
) 
if [%1] == [reset_internet] (
	echo Resetting the Internet
	echo --------------------------------
	netsh int ip reset C:\resetlog.txt
	echo --------------------------------
	echo netsh winsock reset
	echo --------------------------------
	netsh winsock reset
	echo --------------------------------
	echo netsh winhttp reset proxy
	echo --------------------------------
	netsh winhttp reset proxy
	echo --------------------------------
	echo netsh winhttp reset tracing
	echo --------------------------------
	netsh trace stop
	echo --------------------------------
	echo netsh winsock reset catalog
	echo --------------------------------
	netsh winsock reset catalog
	echo --------------------------------
	echo netsh int ipv4 reset catalog
	echo --------------------------------
	netsh int ipv4 reset catalog
	echo --------------------------------
	echo netsh int ipv6 reset catalog
	echo --------------------------------
	netsh int ipv6 reset catalog
	echo --------------------------------
	echo netsh int ip reset
	echo --------------------------------
	netsh int ip reset
	echo --------------------------------
	ipconfig /release
	ipconfig /flushdns
	ipconfig /renew
	echo --------------------------------
	goto :eof
)
if [%1] == [restart_computer] (
	shutdown /r
	goto :eof
)

echo InvalidKey: %1
echo ValidKeys: [reset_internet][restart_computer][cpu_usage]
goto :eof

:cpu_usage
	if [%1] == [1] (
		echo "Level Set to 1"
		deathnote Monitor.exe
		deathnote PubMonitor.exe
		deathnote UninstallMonitor.exe
	)
	if [%1] == [2] (
		echo "Level Set to 2"
		deathnote Blitz.exe
		deathnote chrome
		deathnote Code.exe
		deathnote TeamViewer.exe
		deathnote TeamViewer_Service.exe
	)
	if [%1] == [3] (
		echo "Level Set to 3"
		echo level 3
		goto :eof
	)
exit /B 0
