@echo off
g++ -o open header\\open.cpp header\\switcher.cpp
cp open.exe bin\open.exe
rm open.exe
echo 33%% Complete


g++ -o init header\\init.cpp header\\switcher.cpp
cp init.exe bin\init.exe
rm init.exe
echo 66%% Complete

g++ -o jump header\\jump.cpp header\\switcher.cpp
cp jump.exe bin\jump.exe
rm jump.exe
echo Instalation Completed