@echo off
set args=%2
set command=%1
if [%command%] == [] (
	echo Need command set.
	goto :eof
) else (
	if %command% == cd 	GOTO :continue
	if %command% == start 	GOTO :continue
	echo Invalid Command: [ %command% ]
	echo Valid commands are [ cd ] and [ start ]
	goto :eof
)

:continue
if [%args%] == [] (
	echo Its a no point
	%command% %args%
	goto :eof	
)
if %args% == . (
	echo Its a point
	%command% %args%
	goto :eof
)
if %args% == .. (
	echo Its a double point
	%command% %args%
	goto :eof
)
if %args% == ... (
	echo Its a triple point
	%command% %args%
	goto :eof
)
echo default
goto :eof
