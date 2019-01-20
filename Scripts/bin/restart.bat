@echo off
if [%1] == [] (
	echo need something to restart
	goto :eof
)
if [%1] == [backend] (
	taskkill /im code.exe /F
	code .
	code ./app
	goto :eof
)
taskkill /im %1.exe /F
if [%2] == [] (
	%1 .
	goto :eof
)
if [%3] == [] (
	%1 %2
	goto :eof
)
if [%4] == [] (
	%1 %2 & %1 %3
	goto :eof
)
if [%5] == [] (
	%1 %2 & %1 %3 & %1 %4
	goto :eof
)
if [%6] == [] (
	%1 %2 & %1 %3 & %1 %4 & %1 %5
	goto :eof
)

