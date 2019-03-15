@echo off 
set "cwd=%cd%"
cd C:\Dev\EasyPHP-Devserver-17
start run-devserver.exe
cd %cwd%