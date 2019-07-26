@echo off
notepad %~dp0../config/paths
if [%1] == [] (
	update.config py
	goto :eof
)
if [%1] == [--nc] (
	goto :eof
)
update.config %1