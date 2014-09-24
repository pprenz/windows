echo ================================================
echo   Map Print Drive
echo ================================================
net use x: C:\Documents and Settings\Rxveil\Desktop\perlone /persistent:no

net use
pause
IF EXIST x (
echo x already exist and being deleted
net use
pause
net use x: /delete
net use
pause
echo Adding New Printer
net use x: \\scfprint\MathLAB /persistent:no
net use
pause
) ELSE (
echo x is not here, new dir is added
mkdir hello
pause
)
net use
echo adding x again 
net use x: C:\Documents and Settings\Rxveil\Desktop\perlone /persistent:no
net use x: C:\Documents and Settings\Rxveil\Desktop\perlone /persistent:no

net use


echo ================================================
echo   WELCOME SUTDENTS
echo ================================================

:end