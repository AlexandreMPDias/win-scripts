@echo off
if [%1] == [] (
	echo Need first argument. Valid args [ html ].
	goto :eof
)
if [%2] == [] (
	robocopy C:\\Alexandre\\Script\\samples\\%1 . /s /e > NUL
) else (
	robocopy C:\\Alexandre\\Script\\samples\\%1 %2 /s /e > NUL
)
echo Sample for [ %1 ] created

