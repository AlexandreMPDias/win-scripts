Param(
	[string]$key = 0
)

$NF = "__not_found__"

$PHONE_NAME = "__not_found__"
$EMULATOR_PATH = "__not_found__"
$phone_name_found = $False
foreach ($line in [System.IO.File]::ReadLines("$PSScriptRoot\..\config\.env") <#| ForEach-Object#>) {
	if ($PHONE_NAME -eq $NF) {
		$ar_path = $line.Split("=", 2, [System.StringSplitOptions]::RemoveEmptyEntries)
		if ($ar_path[0] -eq "ANDROID_EMULATOR_$key") {
			$PHONE_NAME = $ar_path[1]
		}
	}
	if ($EMULATOR_PATH -eq $NF) {
		$ar_path = $line.Split("=", 2, [System.StringSplitOptions]::RemoveEmptyEntries)
		if ($ar_path[0] -eq 'ANDROID_SDK_EMULATOR_PATH') {
			$EMULATOR_PATH = $ar_path[1]
		}
	}
}
if ($PHONE_NAME -eq $NF -Or $EMULATOR_PATH -eq $NF) {
	if ($PHONE_NAME -eq $NF ) {
		Write-Host "Key not found. Make sure you set [ANDROID_EMULATOR_$key] in your .env file" -foregroundcolor Red
	}
	if ($EMULATOR_PATH -eq $NF ) {
		Write-Host "Tools Path not found. Make sure you set [ANDROID_SDK_EMULATOR_PATH] in your .env file" -foregroundcolor Red
	}
}
else {
	Write-Host "Starting $PHONE_NAME" -foregroundcolor Green
	$path = (Join-Path $EMULATOR_PATH emulator.exe)
	$command = "$path -avd $PHONE_NAME"
	# invoke-item -Path $EMULATOR_PATH "emulator -avd $PHONE_NAME"
	$args = @("-avd", $PHONE_NAME)
	& "$path" $args
	Write-Host $command
}