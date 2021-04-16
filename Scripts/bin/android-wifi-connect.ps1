param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$ip
)

$devices = & adb devices

$deviceId = ($devices -replace ".*attached\s?", "").Trim()
$deviceId = $deviceId -replace "(.*)\s*device", "`$1"
$deviceId = $deviceId -replace "\s", ""

$extracted_ip = $deviceId -replace ":.*", ""

if ($extracted_ip -eq $ip) {
	Write-Host Already connected
}
else {
	adb -s $deviceId tcpip 5555
	adb connect $ip':5555'
	Write-Host "Connected $deviceId to $ip" -ForegroundColor Green
}