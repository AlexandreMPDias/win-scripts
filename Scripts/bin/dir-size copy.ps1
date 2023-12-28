
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
	$Path = ".",
	# [Parameter(
	# 	ParameterSetName='Format',
	# 	Mandatory=$false,
	# 	HelpMessage="Should format the size value",
	# 	Position=1
	# )]
	# $Property = @("Name", "Length")
	[Parameter(
		ParameterSetName='Format',
		Mandatory=$false,
		HelpMessage="Should format the size value",
		Position=2
		)]
	[boolean]
	$Format = $false
	
)

function addIndexToArray{
	param([array]$array)
	$idx = 0
	return $array | ForEach-Object {
		$_ | Add-Member -MemberType NoteProperty -Name 'Index' -Value ($idx++)
		$_
	}
}

function makeItemEntry{
	param([string]$Name, [int]$Size)
	return [pscustomobject]@{Name=$Name;Size=$Size}
}

function Format-Size {
	param([int]$value)
	if(-Not $Format) {
		return $value.ToString("n0")
	}
	$sizes = 'KB','MB','GB','TB','PB'
	for($x = 0;$x -lt $sizes.count; $x++){
		if ($value -lt [int64]"1$($sizes[$x])"){
			if ($x -eq 0){
				return "$value Bytes"
			} else {
				$num = $value / [int64]"1$($sizes[$x-1])"
				$num = "{0:N2}" -f $num
				return "$num $($sizes[$x-1])"
			}
		}
	}

	
	return $value.toString()
}

function Write-Line {
	param([string]$name, [string]$size, [boolean]$header)

	$width = $Host.UI.RawUI.WindowSize.Width

	$sizeWidth = 20
	$nameWidth = $width - $sizeWidth

	$nameStr = Out-String -InputObject $name -Width $nameWidth
	$sizeStr = Out-String -InputObject $size -Width $sizeWidth

	Write-Host "$nameStr$sizeStr"
	if($header) {
		$cols = @(
			repeat-char("-",$nameWidth - 1),
			repeat-char("-",$sizeWidth - 1)
		)
		Write-Host [String]::Join(' ',$cols)
	}
}

function Get-Size {
	param([string]$directory)
	$output = (Get-ChildItem -Path $directory -Recurse -Force | Measure-Object -Sum Length).Sum
	return $output
}

# $items = Get-ChildItem -Path $Path
# $fucker = addIndexToArray $items
# Write-Host $items
# Write-Host "==================="
# Write-Host $fucker
# Write-Host "==================="
# $fucker | Foreach-Object {
# 	$item = $_
# 	$index = $item.Index
# 	Write-Host "$item - $index"
# }


$totalSize = 0
$rawItems = Get-ChildItem -Path $Path | Sort-Object -Property Length
# [array]::Reverse($rawItems)
$rawItemsWithIndex = addIndexToArray $rawItems

# Write-Host "Style: " $PSStyle.Progress.Style
# Write-Host "View: " $PSStyle.Progress.View
# Write-Host "MaxWidth: " $PSStyle.Progress.MaxWidth

Write-Host "`n`tDirectory:"(Resolve-Path $Path)"`n"
Write-Line "Name" "Size" $true

for($index = 0; $index -lt $rawItems.count; $index++) {
	$item = $rawItems[$index]
	$name = $item.Name
	$count = $rawItems.count
	$percentComplete = 100 * $index / $rawItems.count
	# Write-Progress -Activity "Calculation sizes" `
	# 	-PercentComplete (($index*100)/$count) `
	# 	-Status "$(([math]::Round((($index)/$count * 100),0))) %"
	
	$size = $item.Length
	if(!$item.Directory) {
		$size = Get-Size $item.FullName
	}
	$totalSize = $size + $totalSize

	$size = Format-Size $size

	$item | Add-Member -MemberType NoteProperty -Name 'Size' -Value $size



	# $item | FT  @{Label= "Name";Expression={ $_.Name}; }, `
    #             @{Label = "Size"    ;Expression={ $size } }

	Write-Line $name $size $false
}

# $items = $rawItemsWithIndex | Foreach-Object {
# 	$index = $_.Index
# 	$name = $_.Name
# 	$count = $rawItemsWithIndex.count
# 	$percentComplete = 100 * $index / $rawItemsWithIndex.count
# 	Write-Progress -Activity "Calculation sizes" `
# 		-PercentComplete (($index*100)/$count) `
# 		-Status "$(([math]::Round((($index)/$count * 100),0))) %"
	
# 	$size = $_.Length
# 	if(!$_.Directory) {
# 		$size = Get-Size $_.FullName
# 	}
# 	$totalSize = $size + $totalSize

# 	$size = Format-Size $size

# 	$_ | Add-Member -MemberType NoteProperty -Name 'Size' -Value $size

# 	$col = @(
#     (New-Object -TypeName PSObject -Prop @{'id'='01';'Name'='a';'items'=@('the first item','the second item', 'the third item')}),
#     (New-Object -TypeName PSObject -Prop @{'id'='02';'Name'='b';'items'=@('the first item','the second item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item')}),
#     (New-Object -TypeName PSObject -Prop @{'id'='03';'Name'='c';'items'=@('the first item','the second item', 'the third item')})
#     )

# 	$asArray = @($_, $_)
# 	# Write-Host "Fuck"

# 	# $_
# 	# $directory = Split-Path $item.value -leaf
# 	# $size = Get-Size -Path $item.value
# 	# $totalSize = $totalSize + $size
# 	# $size = $size | Format-Size
#     # makeItemEntry $directory $size
# }

# Format-Table @{Label= "RecordType";Expression={ $_.RecordType};             Width = 10 }, `
#                 @{Label= "Date"      ;Expression={ $_.date};                   Width = 8 },`
#                 @{Label= "Time"      ;Expression={ $_.Time};                   Width = 8 },`
#                 @{Label= "code"      ;Expression={ $_.code}},`
#                 @{Label = "sales"    ;Expression={ [math]::Round($_.sales,2)} }

# $col = @(
#     (New-Object -TypeName PSObject -Prop @{'id'='01';'Name'='a';'items'=@('the first item','the second item', 'the third item')}),
#     (New-Object -TypeName PSObject -Prop @{'id'='02';'Name'='b';'items'=@('the first item','the second item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item', 'the third item')}),
#     (New-Object -TypeName PSObject -Prop @{'id'='03';'Name'='c';'items'=@('the first item','the second item', 'the third item')})
#     )
# $col | FT -Property Name, Size -HideTableHeaders

# $items | FT -AutoSize -Property Name, Size -HideTableHeaders