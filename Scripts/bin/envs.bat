@echo off
echo Opening Env 
REM start %~dp0..\inner_bin\open_env_setter
if [%1] == [] (
    %~dp0..\inner_bin\open_env_setter
    refreshenv
    goto :eof
)
if [%1] == [side] (
    start %~dp0..\inner_bin\open_env_setter
    refreshenv
    goto :eof
)
echo Invalid arg
echo Accepted args: [ side ]