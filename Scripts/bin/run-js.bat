@echo off
if [%1] == [] (
	echo Javascript Script not selected.
	echo Please choose one of the following
	ls %~dp0../js/cmds
	goto :eof
)
if exist %~dp0..\personal_bin\node@latest.bat (
	%~dp0..\personal_bin\node@latest.bat %~dp0..\js\cmds\%1\index.js %cd% %*
) else (
	node %~dp0..\js\cmds\%1\index.js %cd% %*
)