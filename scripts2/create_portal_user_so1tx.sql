use so1tx
go

exec sp_addrolemember 'db_datareader', 'portal'
go

exec sp_addrolemember 'db_datawriter', 'portal'
go

alter user portal with default_schema = portal
go

alter user portal with login = portal
go



exec sp_addrolemember 'db_datareader', 'scheduler'
go

exec sp_addrolemember 'db_datawriter', 'scheduler'
go

alter user scheduler with default_schema = scheduler
go

alter user scheduler with login = scheduler
go



exec sp_addrolemember 'db_datareader', 'sof1_ro'
go

alter user sof1_ro with default_schema = dbo
go

alter user sof1_ro with login = sof1_ro
go
