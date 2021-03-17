@echo off 
cls
FOR /F "tokens=*" %%g IN ('run-js get-alias-path %*') do (set NEXT_GO_TO_PATH=%%g)
cd %NEXT_GO_TO_PATH%
@REM set scriptAction=cd
@REM set scriptPath=%~dp0..\__multipledir

@REM if exist %scriptPath%.bat (
@REM     ENDLOCAL
@REM     @REM call %~dp0..\__multipledir %1 %scriptAction%
@REM     run-js get-alias-path
@REM ) else (
@REM     echo MultipleDir Resolver was not compiled.
@REM     echo Please run: [update.config] or [edit.path] first
@REM )