@ECHO OFF
:: set path to save backup files e.g. D:\backup
set BACKUPPATH=C:\test

:: set name of the server and instance
set SERVERNAME=YourServerName

:: set database name
set DATABASENAME=YourDbName

:: filename format Name-Date
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a%%b)

set DATESTAMP=%mydate%_%mytime%
set BACKUPFILENAME=%BACKUPPATH%\%DATABASENAME%-%DATESTAMP%.bak
set BACKUPFILE=%BACKUPPATH%\%DATABASENAME%-%DATESTAMP%

SqlCmd -E -S %SERVERNAME% -d master -Q "BACKUP DATABASE [%DATABASENAME%] TO DISK = N'%BACKUPFILENAME%' WITH INIT, NOUNLOAD, NAME = N'%DATABASENAME% backup', NOSKIP, STATS = 10, NOFORMAT"
ECHO.

ENDLOCAL
exit
