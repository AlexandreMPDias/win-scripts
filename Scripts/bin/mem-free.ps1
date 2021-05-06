Param(
	[String]
	[ValidateSet("gaming", "dev")]
	[Parameter(Mandatory=$true)]
	$reason
)

function killMany {
	Param(
		[string[]]$processNames
	)
	foreach ($processName in $processNames) {
		Stop-Process -Name $processName -Force
	}
}

function killCommon {
	killMany "DriverBooster"
}

if ($reason -eq "gaming") {
	Write-Host "Freeing Memory for Gaming"

	wsl --shutdown
	killCommon
	killMany "code", "node", "adb", "studio64", "cmd", "pwsh", "slack"
} elseif ($reason -eq "dev") {

	Write-Host "Freeing Memory for Development"
	killCommon
	killMany "Blitz*"
}