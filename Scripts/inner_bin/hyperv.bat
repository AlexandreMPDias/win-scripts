@echo off
echo INSIDE
rename %~dp0log.txt log2.txt
if [%1] == [auto] (
	bcdedit /set hypervisorlaunchtype %1 > hyper-v-log.txt 2>&1
	pause
	goto :eof
)
if [%1] == [off] (
	bcdedit /set hypervisorlaunchtype %1 > hyper-v-log.txt 2>&1
	pause
	goto :eof
)

@REM (
@REM 	echo Invalid Hyper-v argument
@REM 	echo.
@REM 	echo Usage:
@REM 	echo      hyper-v [auto^|off]
@REM ) > hyper-v-log.txt 2>&1

@REM goto :eof


@REM :show_help
@REM 	(
@REM 		echo Invalid Hyper-v argument
@REM 		echo.
@REM 		echo Usage:
@REM 		echo      hyper-v [auto^|off]
@REM 	) > hyper-v-log.txt 2>&1
@REM goto :eof