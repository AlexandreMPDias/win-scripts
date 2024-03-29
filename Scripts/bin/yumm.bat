@echo off
setlocal EnableDelayedExpansion

set "defaultRun=web"
set "skipRun=0"
set "skipBuild=0"
set "declarations=0"
set "workspace=__empty__"
set "runspace=__empty__"
set arguments=%1 %2 %3 %4 %5 %6 %7

echo.

for %%A in (%arguments%) do (
	set value=%%A
	if "!value:~0,1!" == "\" (
		set "command=!value:~1!"
		if !command! == r (
			echo Skipping Run
			set "skipRun=1"
		)
		if !command! == d (
			set "declarations=1"
		)
		if !command! == b (
			set "skipBuild=1"
		)
		if !command! == a (
			set "workspace=all"
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

if %workspace% neq __empty__ (
	if %skipBuild% == 1 (
		echo [ Building]^: Skipping Build
	) else (
		echo [ Building ]^: %workspace%
	)
) else (
	if %skipBuild% == 1 (
		echo [ Building]^: Skipping Build
	) else (
		echo [ Building ]^: Everything ^(No buildSpace set, running all^)
	)
)
if %declarations% neq 0 (
	echo [ Building ]^: declarations
)
if %runspace% neq __empty__ (
	if %skipRun% == 1 (
		echo [ Running]^: Skipping Run
	) else (
		echo [ Running  ]^: %runspace%
	)
) else (
	if %skipRun% == 1 (
		echo [ Running]^: Skipping Run
	) else (
		echo [ Running  ]^: [%defaultRun%] ^(No runSpace set, running default^)
	)
)
echo.

if %skipBuild%==0 (
	if %workspace%==__empty__ (
		call yarn build
	) else (
		if %workspace%==all (
			call yarn build
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
		call yarn run:%defaultRun%
	) else (
		call yarn run:%runspace%
	)
)