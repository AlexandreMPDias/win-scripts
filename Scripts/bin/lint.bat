@echo off
echo   ^> formatting with Ruff
ruff format %1
echo   ^> checking with Ruff
ruff check %*
echo   ^> done