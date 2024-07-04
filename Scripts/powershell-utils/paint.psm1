$ASCII_COLOR_CODES = @{
    'black'       = "`e[30m"
    'red'         = "`e[31m"
    'green'       = "`e[32m"
    'yellow'      = "`e[33m"
    'blue'        = "`e[34m"
    'magenta'     = "`e[35m"
    'cyan'        = "`e[36m"
    'white'       = "`e[37m"
    'darkyellow'  = "`e[38;5;3m"
    'reset'       = "`e[39m" # Default terminal color
}

function Get-ANSIColorCode {
    param (
        [string]$colorName
    )
    if ($ASCII_COLOR_CODES.ContainsKey($colorName.ToLower())) {
        return $ASCII_COLOR_CODES[$colorName.ToLower()]
    } else {
        return $ASCII_COLOR_CODES['reset']
    }
}

function PaintText {
    param (
        [string]$text,
        [string]$color
    )
    $color_code = Get-ANSIColorCode $color
    $reset_code = $ASCII_COLOR_CODES['reset']
    
    return "$color_code$text$reset_code"
}

function MakePainter {
    param (
        [string]$default_color
    )

    return [ScriptBlock]::Create("
        param (
            [string]`$text,
            [string]`$color = '$default_color'
        )
        return PaintText `$text `$color
    ")
}

Export-ModuleMember -Function PaintText, MakePainter
