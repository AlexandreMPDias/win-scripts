@echo off

if [%1] == [] (
	yarn run:tutor-app
	goto: eof
) else (
yarn run:%1
)