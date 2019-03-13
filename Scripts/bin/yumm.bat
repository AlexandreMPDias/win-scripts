@echo off

if [%1] == [] (
	call yarn build:win
) else (
	call yarn build:%1
)

call yarn awesome

if [%2] == [] (
	yarn run:web
) else (
	yarn run:%2
)
