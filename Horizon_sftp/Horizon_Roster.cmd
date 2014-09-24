@echo off

j:
cd j:\Horizon_sftp\


echo ----------- Uploading files to Horizon ------------
psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec_roster_upload.txt
if errorlevel == 1 goto :rename
echo....................................................

echo.
echo ----- Backing up files -----------------------------

cd j:\Horizon_sftp\RosterUpdate\
mv *.txt J:\Horizon_sftp\RosterUpdate\oldrosterupdates\
goto :EOF


:rename
echo File was not avail. for renaming!


:EOF



