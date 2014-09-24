DECLARE @BackupLocation NVARCHAR(100);

Set @BackupLocation = 'C:\DB\dbBackups\prod_only_backups\so1masterSQL_sept_clean_' +
CONVERT(NVARCHAR(10),GETDATE(),110)+ '.bak';

BACKUP DATABASE so1mastersql_sept_clean
to disk = @BackupLocation
WITH INIT;