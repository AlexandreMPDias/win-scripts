Param(
	[String]
	[Parameter(Mandatory = $true)]
	$processPath
);
(Get-WmiObject Win32_Process | Where-Object { $_.Path.StartsWith($processPath) }).Terminate()
