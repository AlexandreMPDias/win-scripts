@echo off 
if [%1] == [] (
	%~dp0..\__lister
) else (
	%~dp0..\__lister %1
)