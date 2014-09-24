@echo on
echo ================================================
echo   The drive is being created
echo ================================================


net use x: /delete /y
net use
rem pause
echo Adding drive
net use x: \\tap7a\Profiles\%username% /user:%username%@tap.com /persistent:no
net use
rem pause



:end