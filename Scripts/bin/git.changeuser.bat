@echo off
git config --global user.name "Alexandre Dias"
if [%1] == [liber] (
    git config --global user.email "alexandre.dias@liberedu.com"
    goto :eof
)
if [%1] == [icloud] (
    git config --global user.email "alexandrempdias@icloud.com"
    goto :eof
)