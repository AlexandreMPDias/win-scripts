@echo off
git config --global user.name "Alexandre Dias"
if [%1] == [] (
    git config --global user.email "alexandre.dias@cyberlabs.com.br"
    goto :eof
)
if [%1] == [cyberlabs] (
    git config --global user.email "alexandre.dias@cyberlabs.com.br"
    goto :eof
)
if [%1] == [icloud] (
    git config --global user.email "alexandrempdias@icloud.com"
    goto :eof
)