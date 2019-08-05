@echo off

set "isAdmin=%2"

if [%1] == [] (
	echo RumKiller: Missing Windows to Kill
	goto :eof
)

if [%isAdmin%] == [] (
	taskkill /F /FI "WindowTitle eq  rum_%1" /T >NUL 2>&1
	taskkill /F /FI "WindowTitle eq  Selecionar rum_%1" /T >NUL 2>&1
) else (
	taskkill /F /FI "WindowTitle eq  Administrador:  rum_%1" /T >NUL 2>&1
	taskkill /F /FI "WindowTitle eq  Selecionar Administrador:  rum_%1" /T >NUL 2>&1
)