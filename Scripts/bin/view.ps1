param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$scriptName
)
$scriptPath = Join-Path $PSScriptRoot "$scriptName.ps1";
if (Test-Path -Path $scriptPath -PathType Leaf) {
	Get-Content $scriptPath
}
else {
	$Host.UI.WriteErrorLine("[error]: Could not find script { $scriptName.ps1 }")
}