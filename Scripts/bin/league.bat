@echo off
if [%1] == [] (
	"C:\Riot Games\League of Legends\LeagueClient.exe" --locale=en_US
	goto :eof
)
if [%1] == [--clean] (
	taskkill /im Riot* /F
	taskkill /im League* /F
	"C:\Riot Games\League of Legends\LeagueClient.exe" --locale=en_US
	goto :eof
)
echo Invalid parameter
echo Valid parameters are:
echo 	--clean
echo.
echo Usage:
echo 	league ^[--clean^]