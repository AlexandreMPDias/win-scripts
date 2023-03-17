@echo off
if [%1] == [] (
    echo Missing first parameter^: device alias
    call :show_usage
    call :show_known
    goto :eof
)
if [%2] == [] (
    echo Missing second parameter^: toggle status ^[on/off^]
    call :show_usage
    goto :eof
)

if [%1] == [HP_TOUCHSCREEN] (
    toggle-any-device "HID\VID_04F3&PID_2274&COL02\6&32F0618A&0&0001" %2
    goto :eof
)

echo Unknown devices
call :show_known

goto :eof

:show_usage
    echo Usage:
    echo   toggle-device [device_alias] [on/off]
    goto :eof

:show_known
    echo Known Devices:
    echo   - HP_TOUCHSCREEN
    goto :eof