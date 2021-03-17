@echo off

if [%1] == [] (
	echo Missing Package name
	echo Usage:
	echo     %0 [package-name]
)
if [%2] == [--st] (
	echo Skipping Type
	yarn add %1
) else (
	yarn add -D @types/%1
	yarn add %1
)