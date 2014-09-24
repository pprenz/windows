@echo off

echo             **************************************************** 
echo             *************** Horizon File Download ************** 
echo             **************************************************** 

echo.
echo.
echo -------------------Backing up old files----------------
rem mv -f -i ./sftp_testlist/*/ ./sftp_testlist/oldfiles/
mv -f ./sftp_testlist/*.csv ./sftp_testlist/oldfiles/
echo.
echo.
echo -----------Downloading files from Horizon------------
psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec_testlist.txt
echo.
echo.
echo ---renaming "Master file and copying to j:/aspire.---
cd ./sftp_testlist/
rename "Add_IDs*.csv" add_results.csv
rem converted to unicode to ascii to wipe formatting.
rem type add_results.csv.orig > add_results.csv
xcopy /Y /R add_results.csv J:\aspire\
rem if errorlevel 4 goto :error1
echo.
echo.
goto :EOF

rem ***********************************
rem :error1
rem echo No file avail. for download!
rem exit 1

rem ***********************************


:EOF