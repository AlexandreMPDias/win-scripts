@echo off
if [%1] == [] (
	echo Missing Second Parameter. Should be either [create][activate][exit]
	goto :eof
)
if [%1] == [create] (
	py -m venv .venv
	goto :eof
)
if [%1] == [activate] (
	.\.venv\Scripts\activate.ps1
	goto :eof
)
if [%1] == [exit] (
	echo This command is not working
	.\.venv\Scripts\deactivate.bat
	goto :eof
)