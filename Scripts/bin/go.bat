@echo off 
%~dp0..\inner_bin\use_aliased_path.bat cd %*
@REM cls
@REM run-js get-alias-path %*
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