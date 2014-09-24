@echo off

echo                        **************************************************** 
echo                        ***************** DB PUSH LOG FILE ***************** 
echo                        **************************************************** 
echo                                Start TIME: %DATE% - %TIME%                    
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

REM  *********************************************************************************
rem ECHO ---- Verifying connection to Production Server. ---- 
rem :STEP0A
rem IF EXIST Z: GOTO :Step1A
rem IF NOT EXIST Z: GOTO :pingA

rem :pingA
rem ping db.schoolofone.net -n 1 -w 20000 > NUL 
rem if ERRORLEVEL 1 goto IPERRORA  
rem goto STEP1A

rem :STEP1A
rem NET USE Z: /Delete /Yes  

rem NET USE Z: \\184.106.39.60\DB$ /USER:admin s3rv3r@sof1clouD /persistent:yes  


rem GOTO STEP0A

rem :IPERRORA
rem echo Sever is down at %time%. 
rem echo Prod. Server is NOT RESPONDING. 
rem echo Verify Connection.  

rem ***********************************************************************************
rem ECHO ---- Verifying connection to TS03. ----  

rem :STEP1
rem IF EXIST Y: GOTO :Process
rem IF NOT EXIST Y: GOTO :pingB

rem :pingB
rem ping 10.1.215.103 -n 1 -w 20000 > NUL
rem if ERRORLEVEL 1 goto IPERRORB  
rem goto STEPB

rem :STEPB
rem NET USE Y: /Delete /Yes  
rem NET USE Y: \\10.1.215.103\c$\DB\ /user:administrator Tweed@3m /persistent:yes  
rem Echo Z drive is available.  
rem GOTO STEP1

rem :IPERRORB
rem echo Sever is down at %time%.  
rem echo Prod. Server is NOT RESPONDING.  
rem echo Verify Connection.  
rem pause
rem ***********************************************************************************

:Process
echo.  
rem echo --- Moving previous DB backups into "olddbBackups" ----  
rem MOVE /Y C:\DB\dbBackups\*.bak C:\DB\dbBackups\oldDBbackups\  
rem MOVE /Y Z:\DBbackups\*.bak Z:\DBbackups\oldDBbackups\  
MOVE /Y Y:\DBbackups\*.bak Y:\dbBackups\oldDBbackups\  
rem echo Transfer Completed.  
rem echo -------------------------------------------------------  

echo.  

rem echo -------- Backing up local DB -----------------------  
rem echo PLEASE BE PATIENT THIS PROCESS TAKES APPROX. 5 MINS.  
rem echo Starting the backup  
rem sqlcmd.exe -S localhost -U sof1 -P dbAdmin@so1 -i "C:\DB\Scripts\backup_SQL_Sept_clean.sql"

rem echo DB finished backing up!  
rem echo ----------------------------------------------------  

echo.  
 
echo Transferring files to TS03.  
xcopy /Y /R C:\DB\dbBackups\*.bak Y:\DBbackups\  
echo DB tranfer completed!  
echo -----------------------------------------------------

echo.  

echo --------- Restoring DB on Prod. Server -------  
sqlcmd.exe -S 10.1.215.105 -U sof1 -P dbAdmin@so1 -i "\\10.1.215.105\c$\DB\scripts\DBso1masterSQLsept_clean.sql"  
echo DB was Restored On Production.
echo ----------------------------------------------------   

echo.  

echo --------- Re-creating All users on TS03 Server -------  
sqlcmd.exe -S 10.1.215.105 -U sof1 -P dbAdmin@so1 -i "\\10.1.215.105\c$\DB\scripts\recreate_ALL_DB_USERS.sql"  
echo Portal user was re-created On Production.
echo ----------------------------------------------------   
  
echo.  

echo ---------------------------------------------------- 
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



