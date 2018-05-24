@echo off 
if %1 == v-ads (
	workon v-ads
	jump v-ads
) else (
	echo Error. Open not set for [ %1 ]
)