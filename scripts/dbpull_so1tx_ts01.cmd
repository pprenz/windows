@echo off

echo                        **************************************************** 
echo                        ***************** DB PUSH LOG FILE ***************** 
echo                        **************************************************** 
echo                                END TIME: %DATE% - %TIME%                    
echo                        ---------------------------------------------------- 

rem ********************************************************************************
rem Make Directory With Name Date and Time
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set XDate=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set XTime=%%a.%%b
rem ********************************************************************************

For /f "delims=:,. tokens=1-3" %%a in ("%TIME%") do SET HOURS=%%a&SET MINUTES=%%b&SET SECONDS=%%c
SET /A STARTTIME=%HOURS%*3600+%MINUTES%*60+SECONDS
echo %STARTTIME%


REM *********************************************************************************

ECHO ---- Verifying connection to DB01 Server. ---- 

:pingA
ping db01.schoolofone.net -n 2 -w 20000 > NUL 
if ERRORLEVEL 1 goto :IPERRORA  
goto :process

:IPERRORA
echo Sever is down at %time%. 
echo DB01. Server is NOT RESPONDING. 
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

echo ----- Transferring DB to TS01. -----
rem psftp Administrator@localhost -p 14789 -pw Tweed@3m -b dbpull_so1tx_ts01_ts03.txt
echo -----------------------------------------------------
pause
goto :EOF

rem *****************************************************************

:ziperror
echo File was not available for zip.
exit 1

rem *****************************************************************
pause
:EOF

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

