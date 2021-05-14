param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$scriptName,

	[string]
	[ValidateSet("notepad", "code")]
	[Parameter(Mandatory = $false, Position = 1)]
	$editor = "notepad"
)
$outputFile = $scriptName

if (Test-Path -Path $scriptName -PathType Leaf) {
	$outputFile = $scriptName
} elseif ($scriptName -eq "path") {
	$outputFile = Join-Path $PSScriptRoot "../config/paths";
} else {
	$outputFile = Join-Path $PSScriptRoot "$scriptName.ps1";
}

& $editor $outputFile;



