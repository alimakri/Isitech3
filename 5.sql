use Stock;

BACKUP DATABASE Stock TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock_20230328_1109.bak' 
GO

select * from Commande

insert Commande (DateCommande) values(GETDATE())

USE [master]
ALTER DATABASE Stock SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

BACKUP LOG [Stock] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock_LogBackup_2023-03-28_11-13-31.bak' WITH NOFORMAT, NOINIT,  NAME = N'Stock_LogBackup_2023-03-28_11-13-31', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Stock] FROM  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock_20230328_1109.bak' WITH  FILE = 1

select * from DetailCommande
delete DetailCommande where commande=1
GO


