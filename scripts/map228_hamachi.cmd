@echo off

net use \\5.192.6.59 /user:student Abcd1234

xcopy \\5.192.6.59\maptest\MAP228.lnk /y "%userprofile%\Desktop\"


:exit