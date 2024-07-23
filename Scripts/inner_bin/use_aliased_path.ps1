$utilitiesPath = (Join-Path -Path $PSScriptRoot -ChildPath "../powershell-utils" | Resolve-Path).Path
Import-Module (Join-Path -Path $utilitiesPath -ChildPath "paint.psm1")

$script_name, $command, $nextArgs = $args
$script_args = $args[1..($args.Length - 1)]

$pshost = Get-Host
$pswindows = $pshost.UI.RawUI
$env:ALIAS_DEBUG_MODE = $ALIAS_DEBUG_MODE
$env:ALIAS_TERMINAL_WIDTH = $pswindows.BufferSize.Width

function ScriptMain {
    if(!$nextArgs[0]) {
        $Host.UI.WriteErrorLine("[error]: Missing alias key")
        $Host.UI.WriteErrorLine("Run '$script_name --help' for more information.")
    } else {
        if($command -eq "help" -or $command -eq "h" -or (HasNamedFlag "help")) {
            Show-Help
            return
        }
        if(HasNamedFlag "list") {
            & run-js view-alias-path $nextArgs[1..($nextArgs.Length - 1)]
            return
        }
        if($ALIAS_DEBUG_MODE -eq 1) {
            run-js get-alias-path $nextArgs
            return
        }
        $badoutput = $($nextPath = & run-js get-alias-path $nextArgs) 2>&1

        if($ALIAS_DEBUG_MODE -eq 2) {
            if ($badoutput) {
                Write-Host "$badoutput"
                Write-Host ""
            }
            Write-Host "$command $nextPath"
        } else {
            if ($badoutput) {
                $Host.UI.WriteErrorLine("[error]: $badoutput")
            }  else {
                & $command $nextPath
            }
        }
    }
}

function HasNamedFlag {
    param (
        [string]$name,
        [string]$alias = ""
    )
    if($alias -eq "") {
        $alias = $name[0]
    }
    return ($script_args | Where-Object { $_ -eq "--$name" -or $_ -eq "-$alias" }).Count -ne 0
}

function Show-Help {
    $named_param_color = "Red"
    $positional_param_color = "Red"
    
    $NamedParamPainter = MakePainter Red
    $PositionalParamPainter = MakePainter Green
    $DescriptionPainter = MakePainter DarkYellow
    
    
    function Write-HelpShow1Line {
        param (
            [Parameter(ValueFromRemainingArguments = $true)]
            $WriteHostArgs
        )
        Write-Host  @WriteHostArgs
    }

    function Write-HelpNamedFlag {
        param (
            [string]$line,
            [Parameter(ValueFromRemainingArguments = $true)]
            $WriteHostArgs
        )
        if ($line -match '^(\s*--[a-zA-Z][a-zA-Z0-9-_*+]+),(\s*-[a-zA-Z])(\s+.+)$') {
            $longOption = $NamedParamPainter.invoke($matches[1])
            $shortOption = $NamedParamPainter.invoke($matches[2])
            $remainder = $DescriptionPainter.invoke($matches[3])

            Write-Host "$longOption,$shortOption$remainder" @WriteHostArgs
            return
        }
        Write-Error "Invalid help Flag Parameter format"
        exit 1
    }
    function Write-HelpPostional {
        param (
            [string]$line,
            [Parameter(ValueFromRemainingArguments = $true)]
            $WriteHostArgs
        )
        if ($line -match '^(\s{5,}.+)') {
            Write-Host $DescriptionPainter.invoke($line) -ForegroundColor DarkYellow @WriteHostArgs
            return
        }
        if ($line -match '^(\s*[a-zA-Z][a-zA-Z0-9-_*+]+)(\s+.+)') {
            $option = $PositionalParamPainter.invoke($matches[1])
            $remainder = $DescriptionPainter.invoke($matches[2])

            Write-Host "$option$remainder" @WriteHostArgs
            return
        }
        Write-Error "Invalid help Positional Parameter format"
        exit 1
    }

    Write-HelpShow1Line "Usage: $script_name [$($NamedParamPainter.invoke("options"))] $($PositionalParamPainter.invoke("alias_key"))"
    Write-HelpShow1Line ""
    Write-HelpShow1Line "Options:"
    Write-HelpShow1Line ""
    Write-HelpNamedFlag "  --help, -h    Show this help message"
    Write-HelpNamedFlag "  --list, -l    List all aliases"
    Write-HelpShow1Line ""
    Write-HelpShow1Line "Arguments:"
    Write-HelpPostional "  alias_key     The key identifying the alias to be used."
    Write-HelpPostional "                This is a mandatory argument unless --help or --list is used."

}

ScriptMain