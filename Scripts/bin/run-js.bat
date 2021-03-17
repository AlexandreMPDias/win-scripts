@echo off
if [%1] == [] (
	echo Javascript Script not selected.
	echo Please choose one of the following
	ls %~dp0../js/cmds
	goto :eof
)
node %~dp0..\js\cmds\%1\index.js %cd% %*