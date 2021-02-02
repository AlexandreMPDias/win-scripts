@echo off
if [%1] == [auto] (
	bcdedit /set hypervisorlaunchtype %1
	pause
)
if [%1] == [off] (
	bcdedit /set hypervisorlaunchtype %1
	pause
)
echo Invalid Hyper-v argument
echo.
echo Usage:
echo	hyper-v [auto|off]