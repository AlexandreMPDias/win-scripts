@echo off
if [%1] == [] (
	echo Env not set.
	echo Envs^: [laravel]
	goto: eof
)
if [%1] == [laravel] (
	if [%2] == [] (
		echo Command not set.
		echo Commands for [%1]^: [reset-cache]
		goto: eof
	)
	if [%2] == [reset-cache] (
		echo Resetting Cache
		php artisan optimize:clear
		php artisan config:clear
		composer dump-autoload
	)
)
