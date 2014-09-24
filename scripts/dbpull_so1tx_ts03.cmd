@echo off

echo                        **************************************************** 
echo                        ***************** DB PUSH LOG FILE ***************** 
echo                        **************************************************** 
echo                                END TIME: %DATE% - %TIME%                    
echo                        ---------------------------------------------------- 

Echo Please be PATIENT and don't close the window. You will get a notification email when the script has been completed. 

rem ********************************************************************************
rem Make Directory With Name Date and Time
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set XDate=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set XTime=%%a.%%b
rem ********************************************************************************

For /f "delims=:,. tokens=1-3" %%a in ("%TIME%") do SET HOURS=%%a&SET MINUTES=%%b&SET SECONDS=%%c
SET /A STARTTIME=%HOURS%*3600+%MINUTES%*60+SECONDS
echo %STARTTIME%


REM *********************************************************************************

ECHO ---- Verifying connection to TS03 Server. ---- 

:pingA
ping 5.123.88.42 -n 1 -w 20000 > NUL 
if ERRORLEVEL 1 goto :IPERRORA  
goto :process

:IPERRORA
echo Sever is down at %time%. 
echo Prod. Server is NOT RESPONDING. 
echo Verify Connection.  

rem **********************************************************************************

:process   
echo.  
echo --- Moving previous DB backups into "oldbBackups" ----  
MOVE /Y C:\DB\So1txbackups\*.bak C:\DB\So1txbackups\oldbackups\  

echo The move was completed.  
echo -------------------------------------------------------  

echo.  

echo -------- Backing up local DB -----------------------  
echo PLEASE BE PATIENT  
echo Starting the backup  
sqlcmd -E -i "C:\DB\Scripts\BCKUP_so1tx.sql"
echo DB finished backing up!  
echo ----------------------------------------------------  
echo.
rem echo --- Compressing DB backup ---
rem cd C:\DB\So1txbackups\
rem gzip -1 so1tx_*
rem if errorlevel 1 goto :ziperror
echo ............................  
echo.
echo ----- Transferring DB to TS03. -----
rem psftp Administrator@5.123.88.42 -pw Tweed@3m -b dbpull_so1tx_ts01_ts03.txt
scp 
echo -----------------------------------------------------

echo.
echo                        **************************************************** 
echo                        *****************  END OF LOG FILE ***************** 
echo                        **************************************************** 
echo                                END TIME: %DATE% - %TIME%                    
echo                        ---------------------------------------------------- 


rem ***********************************************************************************
For /f "delims=:,. tokens=1-3" %%a in ("%TIME%") do SET HOURS=%%a&SET MINUTES=%%b&SET SECONDS=%%c
SET /A ENDTIME=%HOURS%*3600+%MINUTES%*60+SECONDS
echo %ENDTIME%
If %ENDTIME% LSS %STARTTIME% SET /A ENDTIME=%ENDTIME%+86400
SET /A RUNTIME=%ENDTIME%-%STARTTIME%
echo Run time %RUNTIME% seconds
rem ***********************************************************************************

