@echo off
setlocal

call :find_flag help %1 %2
call :check_params help %1
if [%1] == [] (
	echo Invalid Hyper-v call
	set help=1
)
if %help% == 1 (
	call :show_help
	goto :eof
)

call :find_flag edit %1 %2
if %edit% == 1 (
	code %~dp0..\inner_bin\hyperv.bat
	goto :eof
)

@REM call :find_flag no-admin %1 %2
bcdedit /set hypervisorlaunchtype %1
goto :eof

:show_help
	echo Hyper-v Command
	echo Usage^:
	echo     hyper-v ^[auto^|off^] ^<--no-admin^>
	echo     hyper-v ^[--help^|--edit]
	goto :eof
goto :eof

:check_params
	set "target-flag=%1"
	set "%target-flag%=0"
	if [%2] == [auto] (
		goto :eof
	)
	if [%2] == [off] (
		goto :eof
	)
	set "%target-flag%=1"
	echo Invalid Parameter
goto :eof

:find_flag
	set "target-flag=%1"
	set "%target-flag%=0"
	if [%2] == [--%target-flag%] (
		set "%target-flag%=1"
		goto :eof
	)
	if [%2] == [-%target-flag:~0,1%] (
		set "%target-flag%=1"
		goto :eof
	)
	if [%3] == [--%target-flag%] (
		set "%target-flag%=1"
		goto :eof
	)
	if [%3] == [-%target-flag:~0,1%] (
		set "%target-flag%=1"
		goto :eof
	)
goto :eof