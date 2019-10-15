@echo off
if [%1] == [] (
	echo Javascript Script not selected.
	echo Please choose one of the following
	# ls %~dp0../js | tr '.js' ''
	goto :eof
)
node %~dp0..\js\%1.js %cd% %*