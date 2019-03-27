@echo off

if [%1] == [update] (
	cd %~dp0../..
	echo Pulling...
	git pull
	if [%2] NEQ [] (
		git add *
		echo Commiting %2
		git commit -m "%2"
		echo Pushing...
		git push
	)
	cd %cd%
	goto :eof
)