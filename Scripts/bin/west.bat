@echo off

if [%1] == [] (
	echo Package not set. Aborting
	goto :eof
) else (
	echo Running test for [%1]
	yarn workspace @liberedu/%1 test %2 %3 %4 %5 %6
	goto :eof
)