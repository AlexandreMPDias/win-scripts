$utilitiesPath = Join-Path -Path $PSScriptRoot -ChildPath "../powershell-utils"
Write-Debug "Loading DropdownMenu"
# . Join-Path -Path $utilitiesPath -ChildPath "dropdown-menu.ps1"

Import-Module (Join-Path -Path $utilitiesPath -ChildPath "dropdown-menu.psm1")

# $bad = "Item1","Item2"
# $selection = Menu $bad "Select menu item"

# Switch ($selection){
#     0 {
#         Write-Host "Menu item 0"
#     }
#     1 {
#      Write-Host "Menu item 1"
#     }
# }

function ConfirmWithDropdown {
	param([string]$message, [switch]$yesIsDefault = $false)

	$options = "Yes","No"
	$result = DropdownMenu $options $message
	return $result -eq "Yes"
}