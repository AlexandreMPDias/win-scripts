@echo off 
setlocal

set filename=%2
if [%2] == [] (
	set "filename=default"
)

if [%1] == [c] (
	Compiling C
	gcc -o %filename% *.c
	goto :eof
)
if [%1] == [cpp] ( 
	echo Compiling C++
	g++ *.cpp -static-libstdc++ -static-libgcc -o %filename%
	goto :eof
)
if [%1] == [c++] (
	echo Compiling C++
	g++ *.cpp -static-libstdc++ -static-libgcc -o %filename%
	goto :eof
)
echo Invalid Format.
echo Usage: compile [format][filename]
echo Valid Formats: [ c ][ c++ ]