@echo off
setlocal

echo.
if [%1] == [] (
	echo Listing every process that is listening to a port
) else (
	echo Listing every process that is listening to port [ %1 ]
)
for /f "tokens=5" %%a in ('netstat -aon ^| find /i "listening" ^| findstr /c:":%1"') do (
	set "notEmpty=1"
	if [%1] == [] (
		tasklist /NH /FI "PID eq %%a"
	) else (
		tasklist /FI "PID eq %%a"
	)
)

if "%notEmpty%" == "" (
	echo.
	echo No process is listening to port [ %1 ]
)
