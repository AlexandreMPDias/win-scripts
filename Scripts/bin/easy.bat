@echo off
if [%1] == [] (
	echo Env not set.
	echo Envs^: [laravel]
	goto: eof
)
if [%1] == [laravel] (
	if [%2] == [reset-cache] (
		echo Resetting Cache
		php artisan optimize:clear
		php artisan config:clear
		composer dump-autoload
		goto: eof
	)
	if [%2] == [force-reset] (
		echo composer install
		composer install > NUL
		echo Running Migrate:Fresh
		php artisan migrate:fresh > NUL
		echo Running DB:seed
		php artisan db:seed > NUL
		php artisan passport:install & php artisan key:generate
		php artisan serve
	)
	if [%2] == [init] (
		echo composer install
		composer install > NUL
		echo php artisan migrate
		php artisan migrate:fresh > NUL
		echo php artisan db:seed
		php artisan db:seed > NUL
		echo php artisan passport:install
		php artisan passport:install > NUL
		echo php artisan key:generate
		php artisan key:generate > NUL
		php artisan serve
	)
	if [%2] == [full-update] (
		git pull
		easy laravel 
	)
	echo Command not set. [%2]
	echo Commands for [%1]^: [reset-cache][force-reset][init]
	goto: eof
)
echo Invalid Env. [%1]
echo Envs^: [laravel]