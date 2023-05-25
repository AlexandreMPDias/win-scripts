param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$pattern,
    [Parameter(Position=1)]
    [string]$location = (Get-Location)
)

function Remove-NodeModules([string]$path) {
    Get-ChildItem -Path $path -Directory | ForEach-Object {
        if ($_.Name -eq $pattern) {
			$relativePath = Resolve-Path -Relative -Path $_.FullName
            Write-Host "Removing $($_.FullName)..."
            try {
                Fast-Removal $_.FullName
                Write-Host "`rRemoved $relativePath successfully.`n" -NoNewline -ForegroundColor Green
            } catch {
                Write-Host "`rError removing $relativePath): $($_.Exception.Message)`n" -NoNewline -ForegroundColor Red
            }
        } else {
            Remove-NodeModules $_.FullName
        }
    }
}

function Fast-Removal([string] $path) {
	$temp_path = ($path + "_temp")
	Move-Item $path $temp_path
	Remove-Item $temp_path -Recurse -Force
}

Remove-NodeModules $location
