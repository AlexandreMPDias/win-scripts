[cmdletbinding()]
param(
    [Parameter(Mandatory=$True)]
    [ValidateSet('app')]
    [string]$machine
)

$PERMISSIONS = @{
	app = "app_key.pem"
}

$ADDRESSES = @{
	app = "ubuntu@app-production.estratz.local"
}

$permission = Join-Path "~\.ssh\estratz" $PERMISSIONS[$machine] -Resolve
$address = $ADDRESSES[$machine]

Write-Host "Using key located at " -NoNewLine
Write-Host "[$permission]" -ForegroundColor Cyan

Write-Host "Connecting to machine " -ForegroundColor Green -NoNewline
Write-Host "[$machine]" -ForegroundColor Red -NoNewline
Write-Host " at " -ForegroundColor Green -NoNewline
Write-Host "[$address]" -ForegroundColor Yellow
ssh -i $permission $address
