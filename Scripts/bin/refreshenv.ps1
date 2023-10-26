[CmdletBinding()]param()
Write-Debug "Refreshing Environents using Custom Script"

. C:\ProgramData\chocolatey\bin\RefreshEnv.cmd
. refreshpath