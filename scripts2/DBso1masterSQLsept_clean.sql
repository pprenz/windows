--Restoring DB so1masterSQL_sept_clean

DECLARE @BackupLocation NVARCHAR(100);

Set @BackupLocation = 'c:\DB\dbBackups\so1masterSQL_sept_clean_' +
CONVERT(NVARCHAR(10),GETDATE(),110)+ '.bak';

ALTER DATABASE [so1masterSQL_sept_clean]
SET SINGLE_USER WITH
ROLLBACK IMMEDIATE


RESTORE DATABASE [so1masterSQL_sept_clean] 
FROM DISK = @BackupLocation
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
GO

ALTER DATABASE [so1masterSQL_sept_clean] SET MULTI_USER
GO
