@echo off

if [%1] == [] (
	Echo missing ip
	goto :eof
)
netsh interface portproxy add v4tov4 listenaddress=0.0.0.0 listenport=2222 connectaddress=%1 connectport=2222