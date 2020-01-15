@echo off
REM if [%1] == [] (
REM     echo Opening Env 
REM     rundll32.exe sysdm.cpl,EditEnvironmentVariables
REM     refreshenv
REM     goto :eof
REM )
REM elevate open_env_setter %1

rundll32.exe sysdm.cpl,EditEnvironmentVariables
exit /B