@echo off

echo             **************************************************** 
echo             *************** Horizon File Download ************** 
echo             **************************************************** 

echo.
echo.
echo -------------------Deleting old files----------------
del /s /q .\SFTP\*

echo.
echo.
echo -----------Downloading files from Horizon------------
psftp so1@209.235.210.84 -pw so1@northgrum1 -b exec.txt

echo.
echo.
echo -------------------Unzipping files-------------------
unzip.exe -j -o ./SFTP/Results* -d ./SFTP/

echo.
echo.
echo ---renaming "Master file and copying to j:/aspire.---
cd ./SFTP
rename "Master*" master.csv
xcopy /Y /R master.csv J:\aspire\
echo.
echo.
