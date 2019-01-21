@echo off 
if [%1] == [] (
	Echo Missing Branch
	call:show_usage
	goto :eof
) else (
	if [%2] == [] (
		Echo Missing Repository
		call:show_usage
		goto :eof
	) else (
		git clone --single-branch -b %1 %2 %3
		goto :eof
	)
)
::git clone https://al3xandre@bitbucket.org/libereducationtech/liberedu-api-v2.git

:show_usage
echo Usage: gclone [branch] [repository] [dirname]
exit /B 0