# if you want to filter: run [ getpath | Select-String PATTERN ]
[System.Environment]::GetEnvironmentVariable('PATH') -split ";"