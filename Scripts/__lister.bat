@echo off
if [%1] == [] (
	for %%a in ("%~dp0\bin\*") do @echo %%~na
	goto :eof
)
for %%a in ("%~dp0\bin\*%1") do @echo %%~na