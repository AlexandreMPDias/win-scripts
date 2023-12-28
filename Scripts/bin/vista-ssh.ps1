[cmdletbinding()]
param(
    [Parameter(Mandatory=$True)]
    [ValidateSet('dev08')]
    [string]$machine
)

$PERMISSIONS = @{
	dev08 = "VCAZDEV08_key.pem"
}

$ADDRESSES = @{
	dev08 = "vistadev@dev08.vista.dev"
}

$permission = Join-Path "~\.ssh\vista_capital" $PERMISSIONS[$machine] -Resolve
$address = $ADDRESSES[$machine]

Write-Host "Connecting to machine " -ForegroundColor Green -NoNewline
Write-Host "[$machine]" -ForegroundColor Red -NoNewline
Write-Host " at " -ForegroundColor Green -NoNewline
Write-Host "[$address]" -ForegroundColor Yellow
ssh -i $permission $address
