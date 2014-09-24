@echo on
echo ================================================
echo   The drive is being created
echo ================================================
rem net use x: \\tap7a\Profiles\%username% /user:%username%@tap.com /persistent:no

rem net use
rem pause
IF EXIST x (
echo x already exist and being deleted
net use
rem pause
net use x: /delete /y
net use
rem pause
echo Adding drive
net use x: \\tap7a\Profiles\%username% /user:%username%@tap.com /persistent:no
net use
rem pause
) ELSE (
echo x is not here, new dir is added

pause

rem )

net use
echo adding x again 
net use x: \\tap7a\Profiles\%username% /user:%username%@tap.com /persistent:no
)


:end