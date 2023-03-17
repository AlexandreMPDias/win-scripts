@echo off
setlocal
set "NEXT_TOGGLE_STATUS=%2"
if [%1] == [] (
    echo Missing first parameter^: device_id
    call :show_usage
    goto :eof
)
if [%2] == [] (
    echo Missing second parameter^: toggle status ^[on/off^]
    call :show_usage
    goto :eof
)
if [%NEXT_TOGGLE_STATUS%] == [on] (
	pnputil /enable-device %1
)
if [%NEXT_TOGGLE_STATUS%] == [off] (
	pnputil /disable-device %1
)

goto :eof

:show_usage
    echo Usage:
    echo   toggle-any-device [device_id] [on/off]
    goto :eof