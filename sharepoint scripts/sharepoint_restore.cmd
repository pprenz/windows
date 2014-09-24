@echo off

echo
echo ************************************************
echo ***Welcome to the Sharepoint Restore Script. ***
echo ************************************************
echo.
echo.
rem **************************************
echo Enter Url to restore to for example: http://wcloud02:8081/

set web=
set /P web= Type url: %=%
echo.
echo The url is: %web% 
echo.
rem **************************************
echo Enter the backup file name example: sharepoint_backup.bak
set filename=
set /P filename=Type exact file name: %=%
echo.
echo The file name: %filename%

rem *************************************

cd "c:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\14\BIN\"

stsadm -o restore -url %web% -filename c:\sharepoint\%filename% -overwrite

pause
