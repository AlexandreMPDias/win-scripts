@echo off
if [%1] == [no-cors] (
	"C:\Program Files\Google\Chrome\Application\chrome.exe" --disable-web-security --disable-gpu --user-data-dir=%TEMP%/chromeTemp
) else (
	"C:\Program Files\Google\Chrome\Application\chrome.exe" %*
)