echo Cleaning NPM Cache
start npm cache clean --force

echo Cleaning Yarn Cache
start yarn cache clean

echo Clean Gradle cache
rm -r %USERPROFILE%\.gradle\caches

echo Done