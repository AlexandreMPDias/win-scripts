@echo off
if %1 == fix (
%2 C:\Alexandre\Cyberlabs\Fix
goto :eof
)
if %1 == exp (
%2 C:\Alexandre\Codigos\Experimenting
goto :eof
)
if %1 == scripts (
%2 C:\Dev\win-scripts\Scripts
goto :eof
)
if %1 == main (
%2 C:\Alexandre
goto :eof
)
if %1 == git (
%2 C:\Alexandre\Codigos\Git
goto :eof
)
if %1 == config (
%2 C:\Dev\win-scripts\Scripts\config
goto :eof
)
if %1 == node (
%2 C:\Users\Alexandre\node_modules
goto :eof
)
if %1 == work (
%2 C:\Alexandre\Work\Liber
goto :eof
)
if %1 == . (
	%2 .
	goto :eof
)
echo Error. [ %2 ] not set for [ %1 ]
echo Jump set to [fix][exp][scripts][main][git][config][node][work]
