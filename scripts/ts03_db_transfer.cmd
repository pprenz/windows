@echo off


echo --- Transferring DB to TS03. ---

psftp Administrator@10.1.215.103 -pw Tweed@3m -b ts03_db_transfer_exec.txt
echo.
echo.
pause
