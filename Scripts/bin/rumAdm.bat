@echo off
set "newTitle=%1"
set "package=%2"

if [%package%] == [] (
	set "package=all"
)

if [%newTitle%] == [] (
	echo Needs Title
	goto :eof
)

set "processTitle=rum_%newTitle%" 

rumKiller %1 yes & start _rummerTime %1 %package% %3 %4 %5 %6 %7 %8