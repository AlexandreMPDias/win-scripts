$command, $nextArgs = $args

if(!$nextArgs[0]) {
	$Host.UI.WriteErrorLine("[error]: Missing alias key")
} else {
	$badoutput = $($nextPath = & run-js get-alias-path $nextArgs) 2>&1
	
	if ($badoutput) {
		$Host.UI.WriteErrorLine("[error]: $badoutput")
	} else {
		& $command $nextPath
	}
}