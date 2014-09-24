@echo off
echo.
echo.
echo             ***************************************************** 
echo             ************** Populating Table from DB ************* 
echo             ***************************************************** 
echo.
echo.
j:
cd j:\Horizon_sftp\
python pyHorizon.py "assessment.AspireExportFormat" 2>&1

mv -f assessment.AspireExportFormat.csv TEST_ASSIGNMENTS_%date:~-7,2%%date:~-10,2%%date:~-4,4%.txt 2>&1
if errorlevel == 1 goto :rename

mv -f TEST_ASSIGNMENTS_*.txt j:\Horizon_sftp\sftp_out\ 2>&1
pause
goto :EOF

:rename
echo File was not avail. for renaming!


:EOF



