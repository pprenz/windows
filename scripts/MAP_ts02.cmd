@echo off

net use \\10.1.215.102 /user:student Abcd1234

xcopy \\10.1.215.102\maptest\MAPTEST02.lnk /y "%userprofile%\Desktop\"


:exit