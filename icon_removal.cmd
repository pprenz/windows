@echo off

echo Creating Portal url on Desktop
copy "%userprofile%\Desktop\icon fix\PnkBIcon.ico"  "C:\Documents and Settings\All Users\Documents\My Pictures"
copy "%userprofile%\Desktop\icon fix\Portal.url" "c:\Documents and Settings\All users\Desktop" 
echo Portal url created on Desktop
echo.

del "%userprofile%\Desktop\Play DimensionM Evolver SP Missions 1-20.lnk"
del "c:\Documents and Settings\All Users\Desktop\Play DimensionM Evolver SP Missions 1-20.lnk"

del "%userprofile%\Desktop\Play Dimenxian.lnk"
del "c:\Documents and Settings\All Users\Desktop\Play Dimenxian.lnk"

del "%userprofile%\Desktop\Educate Online Learning Environment.lnk"
del "c:\Documents and Settings\All Users\Desktop\Educate Online Learning Environment.lnk"


echo Desktop shortcuts have beend deleted.