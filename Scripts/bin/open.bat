@echo off 
setlocal
set scriptAction=explorer
set scriptPath=%~dp0..\__multipledir

if exist %scriptPath%.bat (
    ENDLOCAL
    call %~dp0..\__multipledir %1 %scriptAction%
) else (
    echo MultipleDir Resolver was not compiled.
	echo Please run: [update.config] or [edit.path] first
)