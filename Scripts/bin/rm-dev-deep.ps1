param(
    [Parameter(Mandatory=$false, Position=0)]
    [string]$location = (Get-Location),

    [Alias("f")]
    [Parameter(Mandatory=$false, HelpMessage="Don't ask before removing the directory")]
    [switch]$force = $false,

    [Alias("l")]
    [Parameter(Mandatory=$false, HelpMessage="Only list the directories, instead of deleting them")]
    [switch]$list = $false,

    [Alias("max-depth")]
    [Parameter(Mandatory=$false, HelpMessage="Max Depth to look for directories")]
    [int]$maxDepth = -1
)
$rootArgs = $args

function RmDeepCleanUp {
	param([string]$pattern, $forceParam)
	$nextArgs = [System.Collections.ArrayList]@()
	$nextArgs += "$location"
	if($forceParam) { $nextArgs += '-f' }
	if($list) { $nextArgs += '-l' }
	if($maxDepth) { $nextArgs += "-maxDepth $maxDepth" }
	$allArgs = $($nextArgs; $rootArgs)
	Invoke-Expression "powershell rm-deep `"$($pattern)`" $allArgs"
}

RmDeepCleanUp node_modules $force
RmDeepCleanUp .jest $true
RmDeepCleanUp .next $true
RmDeepCleanUp __pycache__ $true
RmDeepCleanUp .venv $true

