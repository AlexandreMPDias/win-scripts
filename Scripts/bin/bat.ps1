param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$scriptName,

	[string[]]
	[Parameter(Position = 1, ValueFromRemainingArguments)]
	$rest
)
$scriptPath = Resolve-Path(Join-Path $PSScriptRoot "$scriptName.bat");
if (Test-Path -Path $scriptPath -PathType Leaf) {
	& $scriptPath $rest;
}
else {

	$Host.UI.WriteErrorLine("[error]: Could not find script { $scriptName.bat } at $scriptPath")
}