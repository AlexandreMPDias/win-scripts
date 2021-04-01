@echo off
setlocal
set MATCHED=0
set "FFMPEG_COMMAND="
set "source=%1"
set "target=%2"
set source_location=%~dp1
set source_name=%~n1
set source_format=%~x1
set target_format=%~x2
call :parse_target_name

call :valid_format %source_format% source
if %ERRORLEVEL% == 1 exit /b %ERRORLEVEL%

call :valid_format %target_format% target
if %ERRORLEVEL% == 1 exit /b %ERRORLEVEL%

echo source = %source%
echo target = %target%
echo location = %source_location%
echo source_name = %source_name%
echo source_format = %source_format%
echo target_format = %target_format%

if %MATCHED% == 1 ( exit /b 0 ) else call :video_to_video
if %MATCHED% == 1 ( exit /b 0 ) else call :video_to_audio
if %MATCHED% == 1 ( exit /b 0 ) else call :audio_to_audio

echo Unsupported conversion from [ %source_format% ] to [ %target_format% ]

goto :eof


:video_to_video
	echo here
	if %MATCHED% == 1 ( exit /b 0 ) else call :check_match .mkv .mp4
	if %MATCHED% == 1 ffmpeg -i "%source%" "%target%"

	if %MATCHED% == 1 ( exit /b 0 ) else call :check_match .mp4 .mkv
	if %MATCHED% == 1 ffmpeg -i "%source%" "%target%"
goto :eof

:audio_to_audio
	if %MATCHED% == 1 ( exit /b 0 ) else call :check_match .mp3 .wav
	if %MATCHED% == 1 ffmpeg -i "%source%" "%target%"

goto :eof

:video_to_audio
	if %MATCHED% == 1 ( exit /b 0 ) else call :check_match .mp4 .mp3
	if %MATCHED% == 1 ffmpeg -i "%source%" -vn "%target%"

goto :eof

:check_match
	echo Checking %1 %2
	if %1 == %source_format% (
		if %2 == %target_format% (
			echo MATCHED %1 %2
			set MATCHED=1
		)
	)
goto :eof

:valid_format
	if [%1] == [] (
		echo Invalid %2 Format
	)
	if %1 == .mp4 goto :eof
	if %1 == .mkv goto :eof
	if %1 == .wav goto :eof
	if %1 == .mp3 goto :eof
	echo [ %1 ] is not a valid format
	call :show_valid_formats
	exit /b 1
goto :eof


:show_valid_formats
	echo.
	echo Valid Formats are:
	echo   [video]
	echo       .mp4
	echo       .mkv
	echo.
	echo   [audio]
	echo       .wav
	echo       .mp3
goto :eof

:parse_target_name
	if "%target_format%" == "%target%" (
		set "target=%source_location%%source_name%%target_format%"
	)
goto :eof