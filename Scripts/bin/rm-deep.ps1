# . C:\script_common\MyCode.ps1
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$pattern,

    [Parameter(Position=1)]
    [string]$location = (Get-Location),

    [Alias("f")]
    [Parameter(Mandatory=$false, HelpMessage="Don't ask before removing the directory")]
    [switch]$force = $false,

    [Alias("l")]
    [Parameter(Mandatory=$false, HelpMessage="Only list the directories, instead of deleting them")]
    [switch]$list = $false,

    [Alias("max-depth")]
    [Parameter(Mandatory=$false, HelpMessage="Max Depth to look for directories")]
    [int]$maxDepth = -1
)
. load-powershell-utils.ps1
# [found_counter, deleted_count]
$counts = 0,0

function Remove-NodeModules([string]$path,[int]$depth) {
    if($depth -eq 0) {
        Write-Host "[ $path ] - Looking for ($pattern) inside path"
    } else {
        Write-Verbose "[ $path ] - Looking for ($pattern) inside path"
    }
    if($maxDepth -gt -1) {
        if($depth -gt $maxDepth) {
            Write-Verbose "Max depth of [$maxDepth] reached"
            return
        }
    }
    Get-ChildItem -Path $path -Directory | ForEach-Object {
        if ($_.Name -eq $pattern) {
            $counts[0]=$counts[0]+1
            Write-Debug "[ $path ] - is a ($pattern)"
			$relativePath = Resolve-Path -Relative -Path $_.FullName
            if($list) {
                Write-Host "Located ($pattern) at $relativePath"
                return
            }
            Write-Host "Removing $($_.FullName)\**"
            try {
                $removed = FastRemoval $_.FullName
                if($removed) {
                    Write-Host "`rRemoved $relativePath successfully." -ForegroundColor Green
                    $counts[1]=$counts[1]+1
                } else {
                    Write-Debug "[ $path ] - not removed"
                }
            } catch {
                Write-Host "`rError removing $relativePath): $($_.Exception.Message)" -ForegroundColor Red
            }
        } else {
            Write-Debug "[ $path ] - is not a $pattern"
            Remove-NodeModules $_.FullName ($depth+1)
        }
    }
}

function FastRemoval([string] $path) {
    if(!$force) {
        $confirmation = ConfirmWithDropdown "You sure you want to remove ($pattern) at [ $path ]"
        if (!$confirmation) {
            Write-Host "User declined removing directory, ignoring"
            return $false
        }
    }
	$temp_path = ($path + "_temp")
	Move-Item $path $temp_path
	Remove-Item $temp_path -Recurse -Force
    Write-Verbose "[ $path ] - ($pattern) deleted"
    return $true
}

$initial_depth = -1
Remove-NodeModules $location $initial_depth

Write-Host ""
Write-Host "For pattern ($pattern)"
Write-Host "  [ $($counts[0]) ] directories found"
if(!$list) {
    Write-Host "  [ $($counts[1]) ] directories deleted"
}
