$command, $nextArgs = $args

$env:ALIAS_DEBUG_MODE = $ALIAS_DEBUG_MODE

if(!$nextArgs[0]) {
	$Host.UI.WriteErrorLine("[error]: Missing alias key")
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