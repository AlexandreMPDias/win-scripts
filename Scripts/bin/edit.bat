@echo off
if [%1] == [] (
        echo Function requires script to be edited/created
        goto :eof
)
notepad %~dp0%1.bat