@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

cd %~dp0..\temp
set outfile=ip_regex.txt
ipconfig | findstr /r /i "IPv4" | findstr /r "[0-9][0-9][0-9]\.[0-9][0-9][0-9]\.[0-9]" > %outfile%

SET count=1
FOR /F "tokens=* USEBACKQ" %%F IN (`type ip_regex.txt`) DO (
  SET var!count!=%%F
  SET /a count=!count!+1
)
echo %var1:~36% | clip
echo %var1:~36%
rm -rf %outfile%
ENDLOCAL
