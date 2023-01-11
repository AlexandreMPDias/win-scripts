#version v1.0.0

Param(
	[Parameter(
		ParameterSetName='Path',
		Mandatory=$false,
		HelpMessage="Path of the directory to check size",
		Position=0
		)]
	[ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or Folder does not exist" 
            }
            return $true
        })]
	[System.IO.FileInfo]
	$Path = "."
)

$BYTE_SIZES = 'KB','MB','GB'

function Get-SizeWarningLevel{
	param([string]$size)
	if($size -eq "Size") { return "" }
	if($size -match '\s[B]') { return 0 }

	$cleanSize = $size -replace " ", ""
	$value = [int64]"$cleanSize"
	
	if($value -lt [int64]"1KB") {
		return 0
	}
	if($value -lt [int64]"1MB") {
		return 1
	}
	if($value -lt [int64]"1GB") {
		return 2
	}
	if($value -lt [int64]"100GB") {
		return 3
	}
	return 4
}

function Format-Size {
	param([int64]$value)
	if($value -lt [int64]"0.5KB") {
		return "$value B "
	}
	$curr = $value
	$gap = [int64]1024
	for($i = 0; $i -lt $BYTE_SIZES.count; $i++) {
		$curr = $curr / $gap
		if($curr -lt 100) {
			$unit = $BYTE_SIZES[$i]
			$num = "{0:N2}" -f $curr
			return "$num $unit"
		}
	}
	return "$curr $($BYTE_SIZES[$BYTE_SIZES.count - 1])"
}



function Get-SizeColWidth {
	if($Host.UI.RawUI.WindowSize.Width -lt 50) {return 12}
	return 20
}

function Get-NameColWidth {
	$width = $Host.UI.RawUI.WindowSize.Width

	$SIZE_COL_WIDTH = get-SizeColWidth - 1
	return [System.Math]::max($width - $SIZE_COL_WIDTH, 20)
}

function Apply-Alignment {
	param([string]$value, [int]$padSize, [string]$orientation)

	$width = $Host.UI.RawUI.WindowSize.Width

	$edgeFill = $padSize - $value.Length

	if($orientation -eq "left") {
		return $value + (' ' * $edgeFill)
	}
	if($orientation -eq "right") {
		if($width -gt 50) {
			$rightGap = 5
			$edgeFill = $padSize - $value.Length - $rightGap
			return  (' ' * $edgeFill) + $value + (' ' * $rightGap)
		}
		return  (' ' * $edgeFill) + $value
	}
	$halfEdgeFill = $edgeFill/2
	return  (' ' * ($halfEdgeFill - 1)) + $value + (' ' * ($halfEdgeFill) )
}

function Write-TableLine {
	param([string]$name, [string]$size)

	$width = $Host.UI.RawUI.WindowSize.Width

	$SIZE_COL_WIDTH = get-SizeColWidth - 1

	$nameWidth = Get-NameColWidth

	$nameStr = Apply-Alignment $name $nameWidth "left"
	$sizeStr = Apply-Alignment $size $SIZE_COL_WIDTH "right"


	$output = "$nameStr$sizeStr`n"

	# Write-Host "#nameStr=$($nameStr.Length) | #sizeStr=$($sizeStr.Length) | #output=$($output.Length) | width=$width"

	$sizeWarningLevel = Get-SizeWarningLevel $size

	if($sizeWarningLevel -eq 0) {
		Write-Host -NoNewLine $output -ForegroundColor Gray
	}
	elseif($sizeWarningLevel -eq 1) {
		Write-Host -NoNewLine $output -ForegroundColor Green
	}
	elseif($sizeWarningLevel -eq 2) {
		Write-Host -NoNewLine $output -ForegroundColor Yellow
	}
	elseif($sizeWarningLevel -eq 3) {
		Write-Host -NoNewLine $output -BackgroundColor Red
	} else {
		Write-Host -NoNewLine $output
	}
}

function Write-Header {
	Write-Host "`n`tDirectory:"(Resolve-Path $Path)"`n"

	# Write-TableLine "Name" "Size"

	$width = $Host.UI.RawUI.WindowSize.Width
	$SIZE_COL_WIDTH = get-SizeColWidth
 	$nameWidth = Get-NameColWidth

	$nameStr = Apply-Alignment "Name" $nameWidth "left"
	$sizeStr = Apply-Alignment "Size" $SIZE_COL_WIDTH "left"
	Write-Host -NoNewLine "$nameStr$sizeStr`n"

	$nameWidth = [System.Math]::max($nameWidth - 20, 20)

	$nameGap = $nameWidth
	$sizeGap = [System.Math]::min($SIZE_COL_WIDTH, 15)

	$kols = @($nameGap, $sizeGap) | foreach { ("-" * $_) }
	$colsPaddingSize = [Math]::max($width - $nameWidth - $SIZE_COL_WIDTH, 10)
	$colsPadding = (" " * $colsPaddingSize)

	Write-Host ([String]::Join($colsPadding,$kols))
}


function Get-Size {
	param([string]$directory)

# Write-Progress -Activity "Calculation sizes" `
# 		-PercentComplete (($index*100)/$count) `
# 		-Status "$(([math]::Round((($index)/$count * 100),0))) %"

	$output = (Get-ChildItem -Path $directory -Recurse -Force | Measure-Object -Sum Length).Sum
	return $output
}

$totalSize = 0
$rawItems = Get-ChildItem -Path $Path | Sort-Object -Property Length
$directoryFound = $false

Write-Header

for($index = 0; $index -lt $rawItems.count; $index++) {
	$item = $rawItems[$index]
	$name = $item.Name
	$count = $rawItems.count
	$percentComplete = 100 * $index / $rawItems.count
	$percentCompleteFormatted = [math]::Round((($index)/$count * 100),0)

	Write-Progress -Activity "Calculation sizes" `
		-PercentComplete (($index*100)/$count) `
		-Status "$($percentCompleteFormatted) % - $name"
	
	$size = $item.Length
	if(!$item.Directory) {
		if($index -ne 0) {
			if(!$directoryFound) {
				$directoryFound = $true
				Write-Host ""
			}
		}
		$size = Get-Size $item.FullName
		$name = "/"+ $item.Name
	}
	
	$totalSize = $size + $totalSize
	$formattedSize = Format-Size $size

	Write-TableLine $name $formattedSize
}

Write-Host "`nTotal Size: $(Format-Size $totalSize)"