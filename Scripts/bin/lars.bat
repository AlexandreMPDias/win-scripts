@echo off
if [%1] == [help] (
	echo.
	echo Lars Commandline Helper
	echo.
	echo ^[reset-cache^]^: Cleans Laravel Caches
	echo ^[force-reset^]^: Composer Install and db-reset
	echo ^[db-reset^]^: Migrate Fresh and db^:seed
	echo ^[init^]^: Composer Install and db-reset
	echo ^[full-update^]^: git pull and init
	goto :eof
)
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
	php artisan migrate:fresh > NUL
	echo Running DB:seed
	php artisan db:seed > NUL
	php artisan passport:install & php artisan key:generate
	php artisan serve
	goto :eof
)
if [%1] == [init] (
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