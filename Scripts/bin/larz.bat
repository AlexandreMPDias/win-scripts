@echo off



if [%1] == [help] (
	echo.
	echo Lars Commandline Helper
	echo.
	echo ^[reset-cache^]^: Cleans Laravel Caches
	echo ^[force-reset^]^: Composer Install and db-reset
	echo ^[db-reset^]^: Migrate Fresh and db^:seed
	echo ^[db^]^: Run db command
	echo ^[init^]^: Composer Install and db-reset
	echo ^[full-update^]^: git pull and init
	echo ^[rollback^]^: do rollback on bd 
	echo ^[migrate^]^: do migration on bd
	echo ^[set-env^]^: set the env for the following migrations
	goto :eof
)

if [%1] neq [set-env] (
if LARS_ENV=="" (
	echo Env not defined. Using Default
) else (
	echo Env: ^[%LARS_ENV%^]
))

if [%1] == [reset-cache] (
	echo Resetting Cache
	php artisan optimize:clear
	php artisan config:clear
	composer dump-autoload
	goto :eof
)
if [%1] == [force-reset] (
	echo composer install
	composer install > NUL
	lars db-reset
	goto :eof
)
if [%1] == [db-reset] (
	echo Running Migrate:Fresh
	php artisan migrate:fresh --env=%LARS_ENV% > NUL
	echo Running DB:seed --env=%LARS_ENV%
	php artisan db:seed --env=%LARS_ENV% > NUL
	php artisan passport:install --env=%LARS_ENV% & php artisan key:generate --env=%LARS_ENV%
	if [%2] == [serve] (
		php artisan serve
	)
	goto :eof
)
if [%1] == [migrate] (
	if [%2] == [] (
		php artisan migrate --env=%LARS_ENV%
	) else (
		php artisan migrate:%2 --env=%LARS_ENV%
	)
	goto :eof
)
if [%1] == [rollback] (
	if [%2] == [] (
		php artisan migrate:rollback --env=%LARS_ENV%
	) else (
		php artisan migrate:rollback --step=%2 --env=%LARS_ENV%
	)
	goto :eof
)
if [%1] == [db] (
	if [%2] == [] (
		php artisan db --env=%LARS_ENV%
	) else (
		php artisan db:%2 --env=%LARS_ENV%
	)
	goto :eof
)
if [%1] == [set-env] (
	set "LARS_ENV=%2"
	goto :eof
)
if [%1] == [init] (
	echo composer install
	composer install > NUL
	echo php artisan migrate:fresh --env=%LARS_ENV%
	php artisan migrate:fresh > NUL
	echo php artisan db:seed --env=%LARS_ENV%
	php artisan db:seed --env=%LARS_ENV% > NUL
	echo php artisan passport:install --env=%LARS_ENV%
	php artisan passport:install --env=%LARS_ENV% > NUL
	echo php artisan key:generate --env=%LARS_ENV%
	php artisan key:generate --env=%LARS_ENV% > NUL
	php artisan serve
	goto :eof
)
if [%1] == [full-update] (
	git pull
	call lars init
	goto :eof
)
echo Command not set. [%1]
echo Run [lars help] for more instructions
goto :eof