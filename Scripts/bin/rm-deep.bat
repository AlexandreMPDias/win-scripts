@echo off
if [%2] == [] (
	echo Missing Remove pattern
	goto :eof
)

for /f  %%G in ('dir /b /a:d "./%1"') do (
	if exist ./%1/%%G\%2 (
		echo Deleting [./%1/%%G\%2]
		mv ./%1/%%G\%2 ./%1/%%G\%2_delete
		rm -rf ./%1/%%G\%2_delete
	) else (
		echo [./%1/%%G\%2] doesnt exist
	)
)