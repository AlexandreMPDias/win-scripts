# Adapted from: https://gist.githubusercontent.com/hapylestat/b940d13b7d272fb6105a1146ddcd4e2a/raw/0edd8c9a3f67951d24cec9d12a1552ae9b932fda/text_menu.ps1
function moveCursor{ param($position)
  $host.UI.RawUI.CursorPosition = $position
}

$writeMenuTab = "  "

function DrawMenuOption {
	param ([string]$content, [int]$position, [switch]$Selected)
	$fcolor = $host.UI.RawUI.ForegroundColor
	$bcolor = $host.UI.RawUI.BackgroundColor
	Write-Host $writeMenuTab -NoNewLine
	if ($Selected) {
		Write-Host "(*) $content" -fore $bcolor -back $fcolor -NoNewline
	} else {
		Write-Host "( ) $content" -fore $fcolor -back $bcolor -NoNewline
	}
}
function RedrawMenuItems{ 
	param ([array]$menuItems, $oldMenuPos=0, $menuPosition=0, $currPos)
	
	# +1 comes from leading new line in the menu
	$menuLen = $menuItems.Count + 1
	$fcolor = $host.UI.RawUI.ForegroundColor
	$bcolor = $host.UI.RawUI.BackgroundColor
	$menuOldPos = New-Object System.Management.Automation.Host.Coordinates(0, ($currPos.Y - ($menuLen - $oldMenuPos)))
	$menuNewPos = New-Object System.Management.Automation.Host.Coordinates(0, ($currPos.Y - ($menuLen - $menuPosition)))
	
	moveCursor $menuOldPos
	DrawMenuOption "$($menuItems[$oldMenuPos])" $oldMenuPos
	
	moveCursor $menuNewPos
	DrawMenuOption "$($menuItems[$menuPosition])" $menuPosition -Selected

	moveCursor $currPos
}
function DrawMenu { param ([array]$menuItems, $menuPosition, $menuTitel)
	$fcolor = $host.UI.RawUI.ForegroundColor
	$bcolor = $host.UI.RawUI.BackgroundColor

	$menuwidth = $menuTitel.length + 4
	Write-Host "$menuTitel`:" -fore $fcolor -back $bcolor
	for ($i = 0; $i -le $menuItems.length;$i++) {
		$content = "$($menuItems[$i])"
		if ($i -eq $menuPosition) {
			DrawMenuOption $content $i -Selected
			Write-Host "" -fore $fcolor -back $bcolor
		} else {
			if ($($menuItems[$i])) {
				DrawMenuOption $content $i
				Write-Host ""
			} 
		}
	}
	# leading new line
	Write-Host ""
}

function DropdownMenu { param ([array]$menuItems, $menuTitel = "MENU")
	$vkeycode = 0
	$pos = 0
	$oldPos = 0
	DrawMenu $menuItems $pos $menuTitel
	$currPos=$host.UI.RawUI.CursorPosition
	While ($vkeycode -ne 13) {
		$press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
		$vkeycode = $press.virtualkeycode
		Write-host "$($press.character)" -NoNewLine
		$oldPos=$pos;
		If ($vkeycode -eq 38) {$pos--}
		If ($vkeycode -eq 40) {$pos++}
		if ($pos -lt 0) {$pos = 0}
		if ($pos -ge $menuItems.length) {$pos = $menuItems.length -1}
		RedrawMenuItems $menuItems $oldPos $pos $currPos
	}
	return $menuItems[$pos]
}

# EXAMPLE <<<<<<<<<<<<
# $bad = "Item1","Item2"
# $selection = DropdownMenu $bad "Select menu item"
