@echo off

net use \\10.1.215.101 /user:student Abcd1234

xcopy \\10.1.215.101\maptest\test2.lnk /y "%userprofile%\Desktop\"


:exit