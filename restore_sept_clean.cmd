@echo on

echo DB so1masterSQL_sept_clean is being restored!
sqlcmd -E -i "C:\DB\scripts\DBso1masterSQLsept_clean.sql"
echo %errorlevel%
echo DB Restore is completed!
echo ----------------------------------------------
echo.
echo Recreating Users
sqlcmd -E -i "C:\DB\scripts\recreate_ALL_DB_USERS.sql"
echo %errorlevel%
echo DB users were recreated!
