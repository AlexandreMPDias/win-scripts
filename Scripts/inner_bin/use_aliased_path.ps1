$command, $nextArgs = $args

$pshost = Get-Host
$pswindows = $pshost.UI.RawUI
$env:ALIAS_DEBUG_MODE = $ALIAS_DEBUG_MODE
$env:ALIAS_TERMINAL_WIDTH = $pswindows.BufferSize.Width

if(!$nextArgs[0]) {
	$Host.UI.WriteErrorLine("[error]: Missing alias key")
} else {
	$ListArgs = $args | Where-Object { $_ -eq "--list" -or $_ -eq "-l" }
	$IsList = $ListArgs.Count -ne 0
	if($IsList) {
		& run-js view-alias-path
	} else {
		if($ALIAS_DEBUG_MODE -eq 1) {
			run-js get-alias-path $nextArgs
		} else {
			$badoutput = $($nextPath = & run-js get-alias-path $nextArgs) 2>&1
	
			if($ALIAS_DEBUG_MODE -eq 2) {
				if ($badoutput) {
					Write-Host "$badoutput"
					Write-Host ""
				}
				Write-Host "$command $nextPath"
			} else {
				if ($badoutput) {
					$Host.UI.WriteErrorLine("[error]: $badoutput")
				}  else {
					& $command $nextPath
				}
			}
		}
	}
}