Param(
	[String]
	[ValidateSet("gaming", "dev")]
	[Parameter(Mandatory=$true, Position = 0)]
	$reason,

	[Boolean]
	[Parameter(Mandatory=$false, Position = 1)]
	$gracefully = $false
)

function Write-Header {
	Param(
		[String]
		[Parameter(Mandatory=$true, Position = 0)]
		$Name
	)

	function Write-Grace {
		if($gracefully) {
			Write-Host "$gracefully" -NoNewline -ForegroundColor Red
		} else {
			Write-Host "$gracefully" -NoNewline -ForegroundColor Green
		}
	}
	Write-Host "Freeing Memory for " -NoNewline
	Write-Host "$Name" -NoNewline -ForegroundColor Yellow
	Write-Host " [ Gracefully = " -NoNewline
	Write-Grace
	Write-Host " ]"
}

function Kill-Process {
	Param(
		[String]
		[Parameter(Mandatory=$true)]
		$Name
	)

	Write-Host "  Killing process: " -NoNewline
	Write-Host "$Name" -ForegroundColor Red

	# get Firefox process
	$process = Get-Process $Name -ErrorAction SilentlyContinue
	if ($process) {

		if($gracefully) {
			# try gracefully first
			$process.CloseMainWindow()

			# kill after five seconds
			Sleep 5
		}

		if (!$process.HasExited) {
			$process | Stop-Process -Force
		}
	}
}

function killMany {
	Param(
		[string[]]$processNames
	)
	foreach ($processName in $processNames) {
		Kill-Process -Name $processName
	}
}

function killCommon {
	killMany "DriverBooster"
}

Write-Host
if ($reason -eq "gaming") {
	Write-Header -Name "Gaming"

	Write-Host Stopping WSL
	wsl --shutdown
	killCommon
	killMany "code", "node", "adb", "studio64", "cmd", "pwsh", "slack"
} elseif ($reason -eq "dev") {
	Write-Header -Name "Development"

	killCommon
	killMany "Blitz*"
}
Write-Host