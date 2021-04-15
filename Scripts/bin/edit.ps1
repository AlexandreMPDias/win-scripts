param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$scriptName,

	[string]
	[ValidateSet("notepad", "code")]
	$editor = "notepad"
)
$scriptPath = Join-Path $PSScriptRoot "$scriptName.ps1";
if (Test-Path -Path $scriptPath -PathType Leaf) {
	& $editor $scriptPath;
}
else {
	$Host.UI.WriteErrorLine("[error]: Could not find script { $scriptName.ps1 }")
}