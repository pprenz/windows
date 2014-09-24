@echo off

echo             **************************************************** 
echo             *************** Horizon File Upload ************** 
echo             **************************************************** 

echo.
echo.
echo ----------- Upload files to Horizon ------------
psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec_upload.txt
pause
echo.
echo.
echo.
echo.
