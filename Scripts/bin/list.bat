@echo off 
if [%1] == [] (
	node %~dp0..\js\cmds\list-scripts\index.js %2
) else (
	node %~dp0..\js\cmds\list-scripts\index.js %2 | findstr %1
)