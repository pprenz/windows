@echo off

echo ==============================================================
echo           Please wait while connecting to your network drive 
echo           you may be prompted for a password...
echo ===============================================================

    
net use X: \\tap7a.tap.com\Profiles\%username% /user:%username%@tap.com /persistent:yes

pause
:end