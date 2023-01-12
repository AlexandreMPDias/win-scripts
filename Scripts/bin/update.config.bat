@echo off
set currentDir=%cd%
cd %~dp0..\config
if [%1] == [] (
	py update_path.py
) else (
	if [%1] == [exe] (
		call update_path.exe
	)
	if [%1] == [js] (
		run-js update-path-alias-script
	) else (
		%1 update_path.%1
	)
)
cd %currentDir%
