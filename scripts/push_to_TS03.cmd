@echo off

echo                        **************************************************** 
echo                        ***************** DB PUSH LOG FILE ***************** 
echo                        **************************************************** 
echo                                START TIME: %DATE% - %TIME%                    
echo                        ---------------------------------------------------- 

rem ********************************************************************************
rem Make Directory With Name Date and Time
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set XDate=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set XTime=%%a.%%b
rem ********************************************************************************

For /f "delims=:,. tokens=1-3" %%a in ("%TIME%") do SET HOURS=%%a&SET MINUTES=%%b&SET SECONDS=%%c
SET /A STARTTIME=%HOURS%*3600+%MINUTES%*60+SECONDS
echo %STARTTIME%

REM  *********************************************************************************
ECHO ---- Verifying connection to Production Server. ---- 

:pingA
ping db.schoolofone.net -n 1 -w 20000 > NUL 
if ERRORLEVEL 1 goto IPERRORA  
goto :process

:IPERRORA
echo Sever is down at %time%. 
echo Prod. Server is NOT RESPONDING. 
echo Verify Connection.  
goto :erroconnect

:process
echo.  
rem echo --- Moving previous DB backups into "olddbBackups" ---- 
rem MOVE /Y C:\DB\dbBackups\*.* C:\DB\dbBackups\oldDBbackups\
rem echo ............................
echo.  
rem echo -------- Backing up local DB -----------------------  
rem sqlcmd -S localhost -U sof1 -P dbAdmin@so1 -i "C:\DB\Scripts\backup_SQL_Sept_clean.sql"
rem sqlcmd -E -i "C:\DB\Scripts\backup_SQL_Sept_clean.sql"
echo ............................ 
echo.

:zip
rem echo --- Compressing DB backup ---
rem cd C:\DB\dbBackups\
rem gzip -1 so1masterSQL*
rem if errorlevel 1 goto :ziperror
rem echo ............................
rem echo.

:backprod
rem echo ---Moving previous DB backups into oldDBbackup [Prod] ---
rem ssh -i ~/.ssh/prod_key Administrator@db.schoolofone.net "cd /cygdrive/c/DB/DBbackups/ && mv *.bak /cygdrive/c/DB/DBbackups/oldDBbackups/"
rem if errorlevel 1 goto :backuperror_prod
rem echo ............................
rem echo.

:transfer
rem echo --- Transferring DB to Prod. server ---
rem cd c:\DB\dbBackups\
rem scp *.bak.gz Administrator@10.1.215.105:/cygdrive/c/DB/dbBackups/
rem if errorlevel 1 goto :transferror
rem echo ............................
rem echo.

:unzip
echo --- Decompressing DB on prod. server ---
ssh Administrator@10.1.215.105 "cd /cygdrive/c/DB/dbBackups/ && gzip -dv *.bak.gz"
if errorlevel 1 goto :unziperror
echo ............................
echo.

rem echo --------- Restoring DB on Prod. Server -------  
rem sqlcmd -S db.schoolofone.net -U sof1 -P dbAdmin@so1 -i "\\db.schoolofone.net\c$\DB\scripts\DBso1masterSQLsept_clean.sql"  
rem echo DB was Restored On Production.
rem echo ............................  
echo.  

rem echo --------- Re-creating Portal user on Prod DB Server -------  
rem sqlcmd -S 184.106.39.60 -U sof1 -P dbAdmin@so1 -i "\\184.106.39.60\c$\DB\scripts\create_portal_user.sql"  
rem echo Portal user was re-created On Production.
rem echo ............................   
echo.
rem echo --------- Re-creating Sof1_ro user on Prod DB Server -------  
rem sqlcmd -S 184.106.39.60 -U sof1 -P dbAdmin@so1 -i "\\184.106.39.60\c$\DB\scripts\create_sof1_ro_user.sql"
rem sqlcmd -S 184.106.39.60 -U Administrator -P Rack@sof1clouD -i "\\184.106.39.60\c$\DB\scripts\create_sof1_ro_user.sql" 
rem echo Portal user was re-created On Production.
rem echo ............................

rem echo ---------------Restarting the portal------------------------ 
rem ssh -i root_so1cloud_rsa root@util0.schoolofone.net "cd /opt/so1/release && fab -i ~/.ssh/so1web_so1cloud_rsa -R prod post_db_push" 
rem echo ............................
rem echo.
goto :EOF

rem *********************************************************

:erroconnect
echo No connection to Prod.
exit 1

:backuperror
echo Moving previous DB backups into oldDBbackup in DEV failed!
exit 1

:ziperror
echo No File available for compression!
exit 1

:backuperror_prod
echo Moving previous DB backups into oldDBbackup in Prod. failed!
goto :transfer

:transferror
echo Error while tranferring DB backup from Dev. to Prod.!
exit 1

:unziperror
echo Error while Decompressing file in Prod.!
exit 1

:EOF

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



