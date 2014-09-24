@echo off

psexec \\wcloud01.schoolofone.org cmd -u administrator -p: Rack@sof1clouD –d c:\sharepoint\script\backup_sharepoint_site.cmd

rem cd c:\sharepoint\script

rem start backup_sharepoint_site.cmd


pause

