@echo off
cd %1 && if [%1] == [] ( 
	echo.
) else (
	prompt %1^>
)