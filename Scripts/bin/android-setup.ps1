function Android-Setup {
	Write-Host "Initializing ADB Daemon" -ForegroundColor Green
	adb reverse tcp:8081 tcp:8081
}

$curDir = Get-Location
Set-Location C:\Users\Tijuk\Projects\android-setup-root
Android-Setup
Set-Location $curDir