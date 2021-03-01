@echo off

if [%LEAGUE_LOCALE%] == [] (
	echo League Locale not set
	echo Setting Locale to default value [ %defaultLocale% ]
	set "LEAGUE_LOCALE=en_US"
)

if [%1] == [--clean] (
	call :run_league 1 1
	goto :eof
)
if [%1] == [--purge] (
	call :run_league 1 0
	goto :eof
)
if [%1] == [--start] (
	call :run_league 0 1
	goto :eof
)
if [%1] == [] (
	call :run_league 0 1
	goto :eof
)

echo Invalid parameter
echo Valid parameters are:
echo 	--clean (Starts League after killing all League processes)
echo 	--purge (only kill all League related processes)
echo.
echo Usage:
echo 	league ^[--clean^]


goto :eof

:run_league
	if %1 == 1 (
		echo.
		(taskkill /im Riot* /F 2> nul || echo No Active Riot Processes found) && echo Active Riot Processes Killed
		(taskkill /im League* /F 2> nul  || echo No Active League Processes found) && echo Active League Processes Killed
	)
	if %2 == 1 (
		echo.
		echo Starting Riot using locale = %LEAGUE_LOCALE%
		echo You can alternate the Locale by setting the locale to LEAGUE_LOCALE
		"C:\Riot Games\League of Legends\LeagueClient.exe" --locale=%LEAGUE_LOCALE%
	)
goto :eof
