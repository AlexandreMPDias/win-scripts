Param(
    [string]$destinationPath = ".",
    [string]$command = "cd"
)

#Write-Host $PSScriptRoot

function execute{
	Param(
		[string]$dpath,
		[string]$comm
	)
	#Write-Host "$dpath : $comm"
	switch($comm){
		"cd" { set-location ($dpath) }
		"start" { invoke-item ($dpath) }
	}
}


$alias_found = $False
foreach($line in [System.IO.File]::ReadLines("$PSScriptRoot\config\paths") <#| ForEach-Object#>){
		if(-not $alias_found){
		$ar_path =  $line.Split(" ", 2,[System.StringSplitOptions]::RemoveEmptyEntries)
		if($ar_path[0] -eq $destinationPath){
			switch($command){
				"cd" { set-location ($ar_path[1]) }
				"start" { invoke-item ($ar_path[1]) }
			}
			$alias_found = $True
		}
	}
}
if(-not $alias_found){
	Write-Host "Alias to Path not found. Valid alias are:" -foregroundcolor Red
	foreach($line in [System.IO.File]::ReadLines("$PSScriptRoot\config\paths") <#| ForEach-Object#>){
		$ar_path =  $line.Split(" ", 2,[System.StringSplitOptions]::RemoveEmptyEntries)
		$fpath = $ar_path[1]
		Write-Host "`t"$ar_path[0]:`t`t$fpath
		if($ar_path[0] -eq $destinationPath){
			switch($command){
				"cd" { set-location ($ar_path[1]) }
				"start" { invoke-item ($ar_path[1]) }
			}
			exit
		}
	}
}

<#
switch($destinationPath){
    "fix" { 
		execute -dpath $destinationPath -comm $command
	}
	default {
		Write-Host "Error"
	}
}#>