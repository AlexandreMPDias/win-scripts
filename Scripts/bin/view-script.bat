@echo off 
if [%1] == [] (
	echo Script's Name is needed
) else (
	type %~dp0%1.bat
)