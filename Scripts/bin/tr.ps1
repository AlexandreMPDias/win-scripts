param(
	[string]
	[Parameter(Mandatory = $true, Position = 0)]
	$matcher,

	[string]
	[Parameter(Mandatory = $true, Position = 1)]
	$replacer,

	[string]
	[Parameter(ValueFromPipeline=$true, Mandatory = $true, Position = 2)]
	$value
)
Write-Host $value.Replace($matcher, $replacer)