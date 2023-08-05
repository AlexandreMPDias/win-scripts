@echo off
powershell -file "%~dp0league.ps1" %*

@REM if [%LEAGUE_LOCALE%] == [] (
@REM 	echo League Locale not set
@REM 	echo Setting Locale to default value [ %defaultLocale% ]
@REM 	set "LEAGUE_LOCALE=en_US"
@REM )

@REM if [%1] == [--clean] (
@REM 	call :run_league 1 1
@REM 	goto :eof
@REM )
@REM if [%1] == [--purge] (
@REM 	call :run_league 1 0
@REM 	goto :eof
@REM )
@REM if [%1] == [--start] (
@REM 	call :run_league 0 1
@REM 	goto :eof
@REM )
@REM if [%1] == [] (
@REM 	call :run_league 0 1
@REM 	goto :eof
@REM )

@REM echo Invalid parameter
@REM echo Valid parameters are:
@REM echo 	--clean (Starts League after killing all League processes)
@REM echo 	--purge (only kill all League related processes)
@REM echo.
@REM echo Usage:
@REM echo 	league ^[--clean^]


@REM goto :eof

@REM :run_set_locale_alias
@REM 	if %1 == "en_US" (
@REM 		set "LEAGUE_LOCALE=en_US"
@REM 	)
@REM 	if %1 == "enUS" (
@REM 		set "LEAGUE_LOCALE=en_US"
@REM 	)
@REM 	if %1 == "en" (
@REM 		set "LEAGUE_LOCALE=en_US"
@REM 	)
@REM 	if %1 == "pt_BR" (
@REM 		set "LEAGUE_LOCALE=pt_BR"
@REM 	)
@REM 	if %1 == "ptBR" (
@REM 		set "LEAGUE_LOCALE=pt_BR"
@REM 	)
@REM 	if %1 == "pt" (
@REM 		set "LEAGUE_LOCALE=pt_BR"
@REM 	)

@REM :run_league
@REM 	if %1 == 1 (
@REM 		echo.
@REM 		(taskkill /im Riot* /F 2> nul || echo No Active Riot Processes found) && echo Active Riot Processes Killed
@REM 		(taskkill /im League* /F 2> nul  || echo No Active League Processes found) && echo Active League Processes Killed
@REM 	)
@REM 	if %2 == 1 (
@REM 		echo.
@REM 		echo Starting Riot using locale = %LEAGUE_LOCALE%
@REM 		echo You can alternate the Locale by setting the locale to LEAGUE_LOCALE
@REM 		"C:\Riot Games\League of Legends\LeagueClient.exe" --locale=%LEAGUE_LOCALE%
@REM 	)
@REM goto :eof
