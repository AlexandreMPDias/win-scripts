Param(
	[Parameter(
		Position=0,
		Mandatory=$true,
		HelpMessage="Path of the input mkv file"
    )]
	[ValidateScript({
        $file = [System.IO.FileInfo]([System.IO.Path]::GetFullPath((Resolve-Path -Path $_).Path))
        if( -not $file.Exists ) {
            throw "Input file does not exist"
        }
        if ($file.Extension -ne ".mkv") {
            throw "The first parameter should be a .mkv file."
            return
        }
        return $true
    })]
	[System.IO.FileInfo]$inputPath,
    [Parameter(
		Position=1,
		Mandatory=$false,
		HelpMessage="Path of the output mp4 file"
    )]
	[ValidateScript({
        $file = $_
        if ($file.Extension -ne ".mp4") {
            throw "The second parameter should be a .mp4 file."
        }
        return $true
    })]
	[System.IO.FileInfo]$outputPath=$null
)

$inputPath = [System.IO.FileInfo]([System.IO.Path]::GetFullPath((Resolve-Path -Path $inputPath).Path))

if (-not $outputPath) {
    $outputPath = $inputPath.FullName -replace "\.mkv$", ".mp4"
}

# Write-Host "ffmpeg -i `"$inputPath`" -filter:v fps=30 -strict -2 -map 0 -c:a aac `"$outputPath`""
ffmpeg -i "$inputPath" -filter:v fps=30 -strict -2 -map 0 -c:a aac "$outputPath"

