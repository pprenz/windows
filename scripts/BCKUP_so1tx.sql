DECLARE @BackupLocation NVARCHAR(100);

Set @BackupLocation = 'C:\DB\So1txbackups\so1tx_' +
CONVERT(NVARCHAR(10),GETDATE(),110)+ '.bak';

BACKUP DATABASE so1tx
to disk = @BackupLocation
WITH INIT;