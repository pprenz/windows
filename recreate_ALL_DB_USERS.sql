-- ****recreate ALL Users****

-- ... Recreating sof1 ...

use so1masterSQL_sept_clean
go

exec sp_addrolemember 'db_datareader', 'sof1'
go

exec sp_addrolemember 'db_datawriter', 'sof1'
go

alter user sof1 with default_schema = dbo
go

alter user sof1 with login = sof1
go

use so1masterSQL_sept_clean
exec sp_addrolemember 'db_datareader', 'sof1'
exec sp_addrolemember 'db_datawriter', 'sof1'
alter user sof1 with default_schema = dbo
alter user sof1 with login = sof1
go

-- ...Recreating portal...

use so1masterSQL_sept_clean
go

exec sp_addrolemember 'db_datareader', 'portal'
go

exec sp_addrolemember 'db_datawriter', 'portal'
go

alter user portal with default_schema = portal
go

alter user portal with login = portal
go


-- ...Recreating sof1_ro...
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

