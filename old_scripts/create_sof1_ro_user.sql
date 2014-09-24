use so1masterSQL_sept_clean
go

exec sp_addrolemember 'db_datareader', 'sof1_ro'
go

alter user sof1_ro with login = sof1_ro
go


use so1tx
exec sp_addrolemember 'db_datareader', 'sof1_ro'
alter user sof1_ro with default_schema = dbo
alter user sof1_ro with login = sof1_ro
go

use so1masterSQL_sept_clean
exec sp_addrolemember 'db_datareader', 'sof1_ro'
alter user sof1_ro with default_schema = dbo
alter user sof1_ro with login = sof1_ro
go