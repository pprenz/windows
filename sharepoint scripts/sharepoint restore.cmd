@echo on

Echo Welcome to the Sharepoint Restore Script.

set filename=
set /P INPUT=Type exact file name: %=%
echo The file name: %filename%

pause
cd c:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\14\BIN>

rem stsadm -o restore -url "http://wcloud02:11229/" -filename c:\sharepoint\Sof1Site_Thu-09-30_07.40.bak -overwrite


stsadm -o restore -url "http://wcloud00:8000/" -filename c:\sharepoint\%filename% -overwrite
pause