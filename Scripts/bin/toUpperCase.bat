@echo off
setlocal enabledelayedexpansion
if %1 == [] (
	echo Expected a parameter
	goto: eof
)
set lower=%1
set alpha=ABCDEFGHIJKLMNOPQRSTUVWXYZ
set i=0
:letter
set !alpha:~%i%,1!_=!alpha:~%i%,1!
set /a i += 1
if %i% LSS 26 goto letter
set i=0
set upper=
:uppercase
set let=!lower:~%i%,1!
if "%let%" == "" goto done
if defined %let%_ (set upper=%upper%!%let%_!) else (set upper=%upper%%let%)
set /a i += 1
goto uppercase
:done
echo %upper%