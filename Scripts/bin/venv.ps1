param (
	[Parameter(Mandatory = $true, Position = 0)]
    [string]$action,
	[Parameter(Mandatory = $false, Position = 1)]
	[string]$version = "3.11"
)

if (-not $action) {
    Write-Host "Missing Second Parameter. Should be either [create][activate][exit]"
    return
}

function EnvCheck {
	return Test-Path "./.venv"
}

function EnvActivate {
	.\.venv\Scripts\activate.ps1
	python --version
}


function EnvCreate {
	$exists = EnvCheck
	if ($exists) {
		Write-Host "Environment already exists"
		return
	}
	$version_path = $version.replace('.','')
	$python_path = "C:\Python" + $version_path + "\python.exe"
	Write-Host "Creating Environment (Python $version)" -ForegroundColor DarkRed
    & $python_path -m venv .venv

	EnvActivate
}

if ($action -eq "shell") {
	$exists = EnvCheck
	if ($exists) {
		EnvActivate
	} else {
		EnvCreate
	}
	return
}

if ($action -eq "create") {
	EnvCreate
    return
}

if ($action -eq "activate") {
    EnvActivate
    return
}

if ($action -eq "exit") {
    Write-Host "This command is not working"
    .\.venv\Scripts\deactivate.bat
    return
}
