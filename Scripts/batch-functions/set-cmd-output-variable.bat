@REM Usage:
@REM 	set-file-var VAR_NAME "Command"

:set-file-var
	FOR /F "tokens=*" %%g IN ('%2') do (set %1=%%g)

goto :eof