
RAISERROR ('sdfsjflm sl Ali MAKRI lqdjlsq', 16, 1) WITH LOG

select * from TableMessage

insert TableMessage (DateMessage, Message)
values (GETDATE(), 'Test pour compteur')

WHILE (1=1)
BEGIN
    update TableMessage set Message=Message
	WAITFOR DELAY '00:00:00.001'; 
END

BACKUP LOG [BD1] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\BD1.bak' WITH NOFORMAT, NOINIT,  NAME = N'BD1-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
insert TableMessage (DateMessage, Message) values(Getdate(), 'Journal sauvegardé')
insert TableMessage (DateMessage, Message) values (GETDATE(), 'Hello')