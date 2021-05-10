param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$scriptName,

	[string]
	[ValidateSet("notepad", "code")]
	[Parameter(Mandatory = $false, Position = 1)]
	$editor = "notepad"
)
$scriptPath = Join-Path $PSScriptRoot "$scriptName.ps1";
& $editor $scriptPath;