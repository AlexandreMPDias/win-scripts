@echo off

if [%1] == [] (
	echo Missing Target Directory
	goto :eof
)

if [%2] == [] (
	echo Missing Remove pattern
	goto :eof
)

for /f  %%G in ('dir /b /a:d "%1"') do (
	echo rm -rf packages\%%G\%2
)