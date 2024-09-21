$scriptName, $params = $args

if (!$scriptName) {
	Write-Error "Javascript Script not selected."
	showHelp
}
elseif (Test-Path -Path (Join-Path $PSScriptRoot "../js/cmds/$scriptName/index.js") -PathType Leaf) {
	$script = Resolve-Path -Path (Join-Path $PSScriptRoot "../js/cmds/$scriptName/index.js");
	$Node = Resolve-Path -Path "C:/Users/Tijuk/AppData/Local/nvs/default/node.exe"
	& $Node $script $params
}
else {
	Write-Error "Javascript Script [ $scriptName ] not found."
	showHelp
}

function showHelp() {
	Write-Error "Please choose one of the following"
	Get-ChildItem (Join-Path $PSScriptRoot "../js/cmds")
}