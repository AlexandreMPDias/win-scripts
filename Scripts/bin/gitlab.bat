@echo off
set "loc=C:\Alexandre\Script\gitlabdir"

if [%1] == [] (
	type %loc%\public | clip
	goto :eof
)
if [%1] == [public] (
	type %loc%\public | clip
	goto :eof
)
if [%1] == [pub] (
	type %loc%\public | clip
	goto :eof
)
if [%1] == [pass] (
	type %loc%\pass | clip
	goto :eof
)
if [%1] == [password] (
	type %loc%\pass | clip
	goto :eof
)
echo Invalid param: [ %1 ] - try^: [ public ] or [ password ]