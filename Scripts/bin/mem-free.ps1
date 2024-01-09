Param(
	[String]
	[ValidateSet("gaming", "dev","cleanup","common")]
	[Parameter(Mandatory=$true, Position = 0)]
	$reason
	# ,

	# [Switch]
	# [Parameter(Mandatory=$false, Position = 1, ParameterSetName = "g")]
	# $gracefully = $false
)

$tab = "  "
$gracefully = $false

$CPU_TOTAL_TIME = 10.6 # (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

$global:TOTAL_CLEARED_RAM = 0
$global:TOTAL_CLEARED_CPU = 0

function Write-Header {
	function Get-Name {
		if ($reason -eq "gaming") {
			return "Gaming"
		} elseif ($reason -eq "dev") {
			return "Development"
		}  elseif ($reason -eq "cleanup") {
			return "Cleaning Up Memory"
		}
		return "Common"
	}

	$Name = Get-Name

	function Write-Grace {
		if($gracefully) {
			Write-Host "$gracefully" -NoNewline -ForegroundColor Red
		} else {
			Write-Host "$gracefully" -NoNewline -ForegroundColor Green
		}
	}
	Write-Host "Freeing Memory for " -NoNewline
	Write-Host "[$Name]" -NoNewline -ForegroundColor Yellow
	Write-Host
	# Write-Host " (Gracefully = " -NoNewline
	# Write-Grace
	# Write-Host ")"
}

function GetProcessCPU {
	Param($process)
	$total = 0
	$count = 0
	$process | ForEach-Object {
		$count = $count + 1
		$total = $total + $_.CPU
	}
	if($count -gt 0) {
		return $total/$count
	}
	return $total
}

function GetProcessRAM {
	Param($process)
	$total = 0
	$process | ForEach-Object {
		$total = $total + $_.WorkingSet64
	}
	return $total
}

function FormatByte {
	Param($value)
	$fmt = '{0:F1}'
	if($value -gt 1GB) {
		return "$fmt Gb" -f ($value/1GB)
	}
	if($value -gt 1MB) {
		return "$fmt Mb" -f ($value/1MB)
	}
	if($value -gt 1KB) {
		return "$fmt Kb" -f ($value/1KB)
	}
	return "$fmt b" -f ($value)
	
}

function WriteResourcesCleared {
	Param($cpu, $ram, $tab = "", $total = "")

	$cpu_percent = ($cpu/$CPU_TOTAL_TIME).tostring("P")
	$fmt_ram = FormatByte $ram
	Write-Host $tab"$fmt_ram$total RAM and $cpu_percent$total CPU cleared"

}

function TerminateProcessByName {
	Param(
		[String]
		[Parameter(Mandatory=$true)]
		$Name
	)

	# Write-Host "$tab" "Killing process: " -NoNewline
	# Write-Host "$Name" -ForegroundColor Yellow

	$process = Get-Process -Name $Name -ErrorAction SilentlyContinue
	if($process) {
		$process_ram = GetProcessRAM $process
		$global:TOTAL_CLEARED_RAM = $global:TOTAL_CLEARED_RAM + $process_ram
		$process_cpu = GetProcessCPU $process
		$global:TOTAL_CLEARED_CPU = $global:TOTAL_CLEARED_CPU + $process_cpu

		
		Stop-Process -Name $Name -Force
		Write-Host $tab "[$Name]: " -NoNewline
		Write-Host "stopped" -ForegroundColor DarkGreen
		WriteResourcesCleared $process_cpu $process_ram "$tab - "
	} else {
		Write-Host $tab "[$Name]: " -NoNewline
		Write-Host "not found" -ForegroundColor DarkRed
	}
	# if ($process) {
	# 	if($gracefully) {
	# 		# try gracefully first
	# 		$closed = $process.CloseMainWindow()
	# 		if(!$closed) {
	# 			Write-Host "Unable to close process [$Name]"
	# 		}
	# 		Write-Host "Closing state for [$Name] is ($closed)"


	# 		# kill after five seconds
	# 		Start-Sleep 5

	# 	}

	# 	if (!$process.HasExited) {
	# 		$process | Stop-Process -Force
	# 	}
	# }
}

function StopWSL {
	Write-Host "$tab" "Stopping " -NoNewline
	Write-Host "WSL" -ForegroundColor Cyan
	wsl --shutdown
}

function killMany {
	Param(
		[string[]]$processNames
	)
	foreach ($processName in $processNames) {
		TerminateProcessByName -Name $processName
	}
}

function killLeftover {
	killMany "git"
}

function killCommon {
	killMany "DriverBooster"
}

Write-Host
Write-Header
killCommon
if ($reason -eq "gaming") {
	killMany "code", "node", "adb", "studio64", "cmd", "pwsh", "slack"
	StopWSL
} elseif ($reason -eq "dev") {
	killMany "Blitz*", "Medal*", "Overwolf*"
}  elseif ($reason -eq "cleanup") {
	killLeftover
	StopWSL
}
Write-Host
WriteResourcesCleared $global:TOTAL_CLEARED_CPU $global:TOTAL_CLEARED_RAM "" " total"