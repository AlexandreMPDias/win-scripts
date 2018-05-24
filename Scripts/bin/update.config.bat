@echo off
set currentDir=%cd%
cd %~dp0..\config
call update_path.exe
cd %currentDir%
