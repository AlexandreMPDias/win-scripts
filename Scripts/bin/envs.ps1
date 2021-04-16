Write-Host "Opening Env" -ForegroundColor Green
Start-Process rundll32.exe -NoNewWindow -Wait -ArgumentList sysdm.cpl,EditEnvironmentVariables
refreshenv