@echo off

net use \\10.67.68.85 /user:student Abcd1234

xcopy \\10.67.68.85\maptest\MAP228.lnk /y "%userprofile%\Desktop\"


:exit