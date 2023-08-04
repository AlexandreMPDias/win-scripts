<#
.FORWARDHELPTARGETNAME League
.FORWARDHELPCATEGORY Cmdlet
.SYNOPSIS
	Methods to help open/close League of Legends.

.DESCRIPTION
	This script has 2 actions built-in.
		- Initialing League of Legends while setting a specific Locale
    	- Forcefully closing League of Legends

.PARAMETER NAME
	league

.PARAMETER locale
	Locale of the Game. Set's in-game and client languages.

.PARAMETER clean
	Forcefully close the game before attempting to start it

.PARAMETER noRun
	Don't try to run the game.
	Useful if you want to use this script to forcefully close the game.

.PARAMETER help
	Show help
#>

param (
		[Parameter(
			Mandatory=$false,
			Position=0,
			HelpMessage="Locale of the Game. Sets in-game and client languages."
		)]
		[string]$locale,

		[Parameter(
			Mandatory=$false,
			HelpMessage="Forcefully close the game before attempting to start it."
		)]
		[switch]$clean = $false,

		[Parameter(
			Mandatory=$false,
			HelpMessage="Don't try to run the game. Useful if you want to use this script to forcefully close the game."
		)]
		[switch]$noRun = $false,

		[Parameter(
			Mandatory=$false,
			HelpMessage="Show help."
		)]
		[switch]$help = $false
	)

if($help) {
	Write-Host "NAME"
	Write-Host "    League"
	Write-Host ""

	Write-Host "SYNOPSIS"
	Write-Host "    Methods to help open/close League of Legends."
	Write-Host ""

	Write-Host "DESCRIPTION"
	Write-Host "    This script has 2 actions built-in:"
	Write-Host "    - Initializing League of Legends while setting a specific Locale"
	Write-Host "    - Forcefully closing League of Legends"
	Write-Host ""

	Write-Host "PARAMETERS"
	Write-Host "    -locale <String>"
	Write-Host "        Locale of the Game. Sets in-game and client languages."
	Write-Host ""

	Write-Host "    -clean [<SwitchParameter>]"
	Write-Host "        Forcefully close the game before attempting to start it."
	Write-Host ""

	Write-Host "    -noRun [<SwitchParameter>]"
	Write-Host "        Don't try to start the game."
	Write-Host "        Useful if you want to use this script to forcefully close the game."
	Write-Host ""

	return 
}

$FALLBACK_LEAGUE_LOCALE = "en_US"
$LOCALES = @("en_US", "pt_BR", "jp_JP", "de_DE", "ko_KO", "es_ES")

if (-not $env:LEAGUE_LOCALE) {
		$env:LEAGUE_LOCALE = $FALLBACK_LEAGUE_LOCALE
	}


function Kill-Process {
	Param(
		[string]
		[Parameter(Mandatory=$true)]
		$Name
	)

	$processMatcher = "$name*"

	$process = Get-Process $processMatcher -ErrorAction SilentlyContinue
	if ($process) {
		$process | Stop-Process -Force
		Write-Host "Success: [ $name ] processes killed" -ForegroundColor Green
	} else {
		Write-Host "Error: No active [ $name ] processes found" -ForegroundColor Red
	}
}

function Parse-LocaleAlias {
    param (
        [string]
		[AllowEmptyString()]
		[Parameter(Mandatory = $true, Position = 0)]
		$localeAlias
    )
	$localeAlias = $localeAlias.ToLower()

	$locale = $LOCALES | Where-Object {
		$curr_locale = $_.ToLower()
		if ($localeAlias -eq $curr_locale) {
			return $true
		}
		$language = $curr_locale -replace "_", ""
		if ($localeAlias -eq $language) {
			return $true
		}
		$language = $curr_locale.Substring(0, 2)
		if ($localeAlias -eq $language) {
			return $true
		}
		return $false

	}
	if (-not $locale) {
		Write-Warning "Invalid locale [$locale] found. Setting locale to [$FALLBACK_LEAGUE_LOCALE]"
		return $FALLBACK_LEAGUE_LOCALE
	}
	return $locale
}

function Get-Locale {
	param (
		[string]
		[AllowEmptyString()]
		[Parameter(Mandatory = $true)]
		$inputLocale = $env:LEAGUE_LOCALE
    )
	if (-not $inputLocale) {
		Write-Warning "League Locale not set.`nSetting Locale to default value [ $env:LEAGUE_LOCALE ] from env [ LEAGUE_LOCALE ]"
		$inputLocale = $env:LEAGUE_LOCALE
	}
	return Parse-LocaleAlias $inputLocale
}


function Kill-League {
	Write-Host ""
	Kill-Process -Name "Riot"
	Kill-Process -Name "League"

}

function Run-League {
	param (
		[string]
		[Parameter(Mandatory = $true)]
		$locale
    )
	Write-Host ""
	Write-Host "Starting Riot using " -NoNewLine
	Write-Host "locale = $locale" -ForegroundColor Cyan
	# Start-Process -FilePath "C:\Riot Games\League of Legends\LeagueClient.exe" -ArgumentList "--locale=$locale"
}


if ($clean) {
	Kill-League
}
if (-not $noRun) {
	$locale = Get-Locale $locale
	Run-League $locale
}