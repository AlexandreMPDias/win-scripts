@echo off 
if %1 == fix (
	%2 C:\Alexandre\Cyberlabs\Fix
	goto :eof
)
if %1 == exp (
	%2 C:\Alexandre\Experimenting
	goto :eof
)
if %1 == v-ads (
	%2 C:\Alexandre\Cyberlabs\VsAds
	goto :eof
)
if %1 == scripts (
	%2 C:\Alexandre\Script
	goto :eof
)
if %1 == home (
	%2 %appdata%\..\..
	goto :eof
)
if %1 == main (
	%2 C:\Alexandre
	goto :eof
)
if %1 == git (
	%2 C:\Alexandre\Git
	goto :eof
)
if %1 == . (
	%2 .
	goto :eof
)
echo Error. [ %2 ] not set for [ %1 ]
echo Jump set to [exp][v-ads][scripts][fix][git][main][home]