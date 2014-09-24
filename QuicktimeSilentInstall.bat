@ECHO OFF

"C:\Documents and Settings\Administrator\Desktop\pc\QuickTimeInstaller.exe" /quiet /norestart

XCOPY /S /E /I /Y QuickTime.qtp "C:\Documents and Settings\All Users\Application Data\Apple Computer\QuickTime"
XCOPY /S /E /I /Y com.apple.QuickTime.plist "C:\Documents and Settings\All Users\Application Data\Apple Computer\QuickTime"
XCOPY /S /E /I /Y QTPlayerSession.xml "%userprofile%\Application Data\Apple Computer\QuickTime\"

DEL "c:\Documents and Settings\All Users\Start Menu\Programs\QuickTime\PictureViewer.lnk"
DEL "c:\Documents and Settings\All Users\Start Menu\Programs\QuickTime\QuickTime Read Me.lnk"
DEL "c:\Documents and Settings\All Users\Start Menu\Programs\QuickTime\Uninstall QuickTime.lnk"
DEL "c:\Documents and Settings\All Users\Desktop\QuickTime Player.lnk"
DEL "%userprofile%\Application Data\Microsoft\Internet Explorer\Quick Launch\QuickTime Player.lnk"

taskkill /F /IM qttask.exe

EXIT