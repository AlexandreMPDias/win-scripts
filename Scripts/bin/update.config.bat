@echo off
set currentDir=%cd%
cd %~dp0..\config
if [%1] == [] (
	call update_path.exe
) else (
	%1 update_path.%1
)
cd %currentDir%
