param(
	[Parameter(Position = 0, ValueFromRemainingArguments = $true)]
	[string[]] $arguments
)
. (Join-Path $PSScriptRoot "../inner_bin/resolve_aliased_path")

$binaryPath = Resolve-AliasedPath "lazy" "dist/index.js"

node $binaryPath timer $arguments