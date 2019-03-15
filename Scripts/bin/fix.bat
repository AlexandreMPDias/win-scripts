@echo off
if [%1] == [] (
	echo Error: invalid usage
	echo Usage: fix [key]
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
	goto :eof
)
if [%1] == [restart_computer] (
	shutdown /r
	goto :eof
)


echo InvalidKey: %1
echo ValidKeys: [reset_internet],[restart_computer]