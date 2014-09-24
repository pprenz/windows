@echo on 
echo > files.txt
path1 = "C:\DB\DBbackups\oldDBbackups\"
echo %path%
FOR %%i IN (%path%\*.bak) DO echo %%i >>files.txt

pause

