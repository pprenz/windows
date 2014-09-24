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