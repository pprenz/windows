@echo on

j:
cd j:\Horizon_sftp\Sftp_out\
rm *
cd j:\Horizon_sftp\

echo --- Creating table from DB. ---

python pyHorizon.py "assessment.AspireExportFormat"
if errorlevel == 1 goto :fail
 

mv -f assessment.AspireExportFormat.csv .\sftp_out\TEST_ASSIGNMENTS_%date:~-7,2%%date:~-10,2%%date:~-4,4%.txt 
if errorlevel == 1 goto :rename

echo ----------- Uploading files to Horizon ------------
psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec_upload.txt
echo.
echo.


goto :EOF

:fail
echo python failed!
exit 1

:rename
echo File was not avail. for renaming!
exit 1


:EOF



