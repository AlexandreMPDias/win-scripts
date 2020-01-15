@echo off 
setlocal
set scriptAction=cd
set scriptPath=%~dp0..\__multipledir

if exist %scriptPath%.bat (
    ENDLOCAL
    call %~dp0..\__multipledir %1 %scriptAction%
    workon %1
) else (
    echo MultipleDir Resolver was not compiled.
    echo Please run: [update.config] or [edit.path] first
)