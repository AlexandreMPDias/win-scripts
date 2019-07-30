@echo off
if [%1] == [] (
	runShell android
) else (
	runShell android "-key '%1'"
)