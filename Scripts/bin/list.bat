@echo off 
if [%1] == [] (
	%~dp0..\__lister .bat
) else (
	%~dp0..\__lister | findstr "^%1"
)