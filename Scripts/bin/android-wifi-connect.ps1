param(
	[string]
	[Parameter(Position = 0)]
	$ip = "10.0.0.22"
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
	$port = ":5555"
	adb connect "$ip$port"
	adb -s $ip reverse tcp:8081 tcp:8081
	Write-Host "Connected $deviceId to $ip" -ForegroundColor Green
}