use so1masterSQL_sept_clean
go

exec sp_addrolemember 'db_datareader', 'sof1'
go

exec sp_addrolemember 'db_datawriter', 'sof1'
go

alter user sof1 with login = sof1
go

use so1tx
exec sp_addrolemember 'db_datareader', 'sof1'
alter user sof1 with default_schema = dbo
alter user sof1 with login = sof1
go

use so1masterSQL_sept_clean
exec sp_addrolemember 'db_datareader', 'sof1'
alter user sof1 with default_schema = dbo
alter user sof1 with login = sof1
go