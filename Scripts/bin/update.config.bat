@echo off
set currentDir=%cd%
cd %~dp0..\config
if [%1] == [] (
	py update_path.py
) else (
	if [%1] == [exe] (
		call update_path.exe
	) else (
		%1 update_path.%1
	)
)
cd %currentDir%
