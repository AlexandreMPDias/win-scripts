if (-not $env:WORKON_HOME) {
    $env:WORKON_HOME = "$env:USERPROFILE\Envs"
}

if (-not $env:VIRTUALENVWRAPPER_PROJECT_FILENAME) {
    $env:VIRTUALENVWRAPPER_PROJECT_FILENAME = ".project"
}

$previousLocation = Get-Location

if (-not $args) {
    Write-Host ""
    Write-Host "Pass a name to activate one of the following virtualenvs:"
    Write-Host "=============================================================================="
    Get-ChildItem -Directory $env:WORKON_HOME | Select-Object -ExpandProperty Name
    Exit
}

$VENV = $args[0]
$scriptArgs = $args[1..($args.Length - 1)]
$CHANGEDIR = $false

for ($i = 0; $i -lt $scriptArgs.Length; $i++) {
    if ($scriptArgs[$i] -eq "-c") {
        $CHANGEDIR = $true
        $scriptArgs = $scriptArgs[0..($i - 1)] + $scriptArgs[($i + 1)..($scriptArgs.Length - 1)]
        break
    }
}

if ($env:VIRTUAL_ENV) {
    & $env:VIRTUAL_ENV\Scripts\deactivate.bat
}

Push-Location $env:WORKON_HOME | Out-Null

if ($LASTEXITCODE -ne 0) {
    New-Item -ItemType Directory -Path $env:WORKON_HOME | Out-Null
}

Push-Location "$env:WORKON_HOME\$VENV" | Out-Null

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "virtualenv '$VENV' does not exist."
    Write-Host "Create it with 'mkvirtualenv $VENV'"
    Exit
}

if (-not (Test-Path "$env:WORKON_HOME\$VENV\Scripts\Activate.ps1")) {
    Write-Host ""
    Write-Host "$env:WORKON_HOME\$VENV"
    Write-Host "doesn't contain a virtualenv (yet)."
    Write-Host "Create it with 'mkvirtualenv $VENV'"
    Exit
}

& "$env:WORKON_HOME\$VENV\Scripts\Activate.ps1"

if ($env:WORKON_OLDTITLE) {
    $host.UI.RawUI.WindowTitle = "$VENV (VirtualEnv)"
}

if (Test-Path "$env:WORKON_HOME\$VENV\$env:VIRTUALENVWRAPPER_PROJECT_FILENAME") {
    & cdproject.bat
} elseif ($CHANGEDIR) {
    Set-Location "$env:WORKON_HOME\$VENV"
}

Set-Location $previousLocation