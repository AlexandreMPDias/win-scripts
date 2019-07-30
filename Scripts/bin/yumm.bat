@echo off
setlocal EnableDelayedExpansion

set "skipRun=0"
set "skipBuild=0"
set "declarations=0"
set "workspace=__empty__"
set "runspace=__empty__"
set arguments=%1 %2 %3 %4 %5 %6 %7

for %%A in (%arguments%) do (
	set value=%%A
	if "!value:~0,1!" == "\" (
		set "command=!value:~1!"
		if !command! == r (
			set "skipRun=1"
		)
		if !command! == d (
			set "declarations=1"
		)
		if !command! == b (
			set "skipBuild=1"
		)
	) else (
		if !workspace!==__empty__ (
			set "workspace=%%A"
			echo !workspace!
		) else (
			if !runspace!==__empty__ (
				set "runspace=%%A"
			) else (
				echo already set
			)
		)
	)
)

echo Workspace = %workspace%
echo RunSpace = %runspace%

if %skipBuild%==0 (
	if %workspace%==__empty__ (
		call yarn build
	) else (
		if %workspace%==all (
			call yarn build:win
		) else (
			call yarn build:%workspace%
		)
	)
) else (
	set "runspace=%workspace%"
)

if %declarations%==1 ( 
	call yarn build:declarations
)
if %skipRun%==0 (
	if %runspace%==__empty__ (
		call yarn run:web
	) else (
		call yarn run:%runspace%
	)
)