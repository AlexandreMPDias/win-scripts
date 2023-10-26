[CmdletBinding()]param()
Write-Debug "Refreshing `$PATH"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")