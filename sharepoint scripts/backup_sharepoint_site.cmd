@echo 

rem ***********************************************************************

rem Make Directory With Name Date and Time
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set XDate=%%a-%%b-%%c

for /f "tokens=1-2 delims=: " %%a in ('time /t') do set XTime=%%a.%%b

rem ************************************************************************





cd c:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\14\BIN\
pause
STSADM.EXE -o backup -url http://wcloud02:11229 -filename c:\Sharepoint\Sof1Site.bak

cd c:\Sharepoint\

rem ************************************************************

pause
rename Sof1Site.bak Sof1Site_"%Xdate%_%XTime%".bak
pause

rem *************************************************************

xcopy Sof1Site_*.bak C:\Sharepoint\old_backups\

rem *************************************************************

C:\Users\administrator.SOF1>psexec \\wcloud01.schoolofone.org cmd -u administrat
or -p: Rack@sof1clouD