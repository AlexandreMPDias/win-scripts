function Resolve-AliasedPath {
	param(
		[Parameter(
		Mandatory=$true,
		HelpMessage="Alias of the path",
		Position=0
		)]
		[string]$Alias,

		[Parameter(Position = 1, ValueFromRemainingArguments = $true)]
		[string[]] $RemainingPaths
	)

	$env:ALIAS_DEBUG_MODE = $ALIAS_DEBUG_MODE

	if ($ALIAS_DEBUG_MODE -eq 1) {
		return run-js get-alias-path $Alias $RemainingPaths
	} else {
		$badoutput = $($nextPath = & run-js get-alias-path $Alias $RemainingPaths) 2>&1

		if ($ALIAS_DEBUG_MODE -eq 2) {
			if ($badoutput) {
				Write-Host "$badoutput"
				Write-Host ""
			}
			Write-Host "$command $nextPath"
		} else {
			if ($badoutput) {
				$Host.UI.WriteErrorLine("[error]: $badoutput")
			}  else {
				return $nextPath
			}
		}
	}
}
