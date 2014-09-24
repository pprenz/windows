@echo on

j:

cd j:\Horizon_sftp\RosterUpdate\
rm *
cd j:\Horizon_sftp\

echo --- Uploading files to Horizon SFTP server. ---

psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec_roster_upload.txt
echo.
echo.


:EOF



