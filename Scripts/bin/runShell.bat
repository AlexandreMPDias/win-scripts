@echo off
set "bp=%~dp0..\ps_bin"
call powershell.exe "& '%bp%\%1.ps1' %2 %3 %4 %5"