
@echo off
if [%1] == [] (
	echo Error: Missing Parameters
	echo Usage^: begin react
	echo Options^: [ react ][ nuxt ][ artisan ][ vue ]
	goto :eof
)

if %1 == react (
	if not [%2] == [skip] (
		echo Initializing React with [ yarn start ]
		yarn start
		goto :eof
	) else (
		echo Initializing React with [ yarn install ] and [ yarn start ]
		yarn install
		yarn start
		goto :eof
	)
)
if %1 == nuxt (
	if not [%2] == [skip] (
		echo Initializing Nuxt with [ yarn nuxt ]
		yarn nuxt
		goto :eof
	) else (
		echo Initializing Nuxt with [ yarn install ] and [ yarn nuxt ]
		yarn install
		yarn nuxt
		goto :eof
	)
)
if %1 == vue (
	if not [%2] == [skip] (
		echo Initializing Vue with [ yarn run dev ]
		yarn run dev
		goto :eof
	) else (
		echo Initializing Vue with [ yarn install ] and [ yarn run dev ]
		yarn install
		yarn run dev
		goto :eof
	)
)
if %1 == artisan (
	if not [%2] == [skip] (
		echo Initializing Artisan with [ php artisan serve ]
		php artisan serve
		goto :eof
	) else (
		echo Initializing Artisan with [ composer install ] and [ php artisan serve ]
		composer install
		php artisan serve
		goto :eof
	)
)
echo Error: invalid field [ %1 ]
echo Terminating Session