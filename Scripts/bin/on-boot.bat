@echo off
setlocal

FOR /F "tokens=* USEBACKQ" %%F IN (`check-permissions --silent`) DO (
	SET HAS_ADMIN_RIGHTS=%%F
)
if [%HAS_ADMIN_RIGHTS%] == [0] (
	echo "Running without rights"
	echo "Requesting rights"
	elevate "on-boot"
	exit /b 0
)

call :kill_nvidia_stuff
echo.
echo.
call :kill_driver_booster
echo.
echo.
call :kill_redis_server
echo.
echo.
timeout /t 10

goto :eof

:proc_kill
	taskkill /im "%1" /F /T
goto :eof
	
:kill_nvidia_stuff
	echo - Killing Nvidia
	call :proc_kill nvsphelper64.exe
	call :proc_kill NVDisplay.Container.exe
goto :eof

:kill_driver_booster
	echo - Killing DriverBooster
	call :proc_kill Scheduler.exe
	call :proc_kill PubPlatform.exe
	call :proc_kill rmuin.exe
goto :eof

:kill_redis_server
	echo - Killing RedisServer
	call :proc_kill redis-server.exe
goto :eof

