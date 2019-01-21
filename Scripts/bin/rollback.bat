@echo off 
if [%1] == [] (
	php artisan migrate:rollback
	goto :eof
)
if [%1] == [all] (
	php artisan migrate:fresh
	goto :eof
)
php artisan migrate:rollback --step=%1