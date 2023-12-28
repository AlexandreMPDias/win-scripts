function Get-Directory {
	param( $item )
	if ( $ParamSetName -eq "Path" ) {
		if ( Test-Path -Path $item -PathType Container ) {
			$item = Get-Item -Path $item -Force
		}
	}

	elseif ( $ParamSetName -eq "LiteralPath" ) {
		if ( Test-Path -LiteralPath $item -PathType Container ) {
			$item = Get-Item -LiteralPath $item -Force
		}
	}

	if ( $item -and ($item -is [System.IO.DirectoryInfo]) ) {
		return $item
	}

}

function Get-DirectoryStats {
	param( $directory, $recurse, $format )
	Write-Progress -Activity "Get-DirStats.ps1" -Status "Reading '$($directory.FullName)'"

	$files = $directory | Get-ChildItem -Force -Recurse:$recurse | Where-Object { -not $_.PSIsContainer }

	if ( $files ) {
		Write-Progress -Activity "Get-DirStats.ps1" -Status "Calculating '$($directory.FullName)'"
		
		$output = $files | Measure-Object -Sum -Property Length | Select-Object `
			@{Name="Path"; Expression={$directory.FullName}},
			@{Name="Files"; Expression={$_.Count; $script:totalcount += $_.Count}},
			@{Name="Size"; Expression={$_.Sum; $script:totalbytes += $_.Sum}}

	}
	else {
		$output = "" | Select-Object `
			@{Name="Path"; Expression={$directory.FullName}},
			@{Name="Files"; Expression={0}},
			@{Name="Size"; Expression={0}}

	}

	if ( -not $format ) { 
		$output
	} else { 
		$output | Format-Output
	}
}

Export-ModuleMember -Function '*'