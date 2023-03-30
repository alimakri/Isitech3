-- Materiel
USE [master] ;  
ALTER DATABASE [Stock2] SET RECOVERY FULL ; 

-- Ecran
use Stock2;
insert Materiel (Libelle) values('Ecran')

-- backup1
BACKUP DATABASE [Stock2] TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' WITH NOFORMAT, NOINIT,  NAME = N'Stock2-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- Crayon
insert Materiel (Libelle) values('Crayon')

BACKUP LOG [Stock2] TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak'
GO

-- Souris
insert Materiel (Libelle) values('Souris')

BACKUP LOG [Stock2] TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak'
GO

-- Clavier
insert Materiel (Libelle) values('Clavier')

BACKUP DATABASE [Stock2] TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'Stock2-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

-- Cable
insert Materiel (Libelle) values('Cable')

BACKUP LOG [Stock2] TO  
	DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak'
GO

-- Restauration complète
USE [master]
BACKUP LOG [Stock2] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_LogBackup_2023-03-28_11-47-41.bak' WITH NOFORMAT, NOINIT,  NAME = N'Stock2_LogBackup_2023-03-28_11-47-41', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' WITH  FILE = 5,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' WITH  FILE = 6,  NOUNLOAD,  STATS = 5

GO
-- Restauration ecran, crayon, souris
USE [master]
BACKUP LOG [Stock2] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_LogBackup_2023-03-28_11-54-48.bak' WITH NOFORMAT, NOINIT,  NAME = N'Stock2_LogBackup_2023-03-28_11-54-48', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 3,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 4,  RECOVERY

GO
-- Restauration complète sans la diff
USE [master]
BACKUP LOG [Stock2] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_LogBackup_2023-03-28_11-54-48.bak' WITH NOFORMAT, NOINIT,  NAME = N'Stock2_LogBackup_2023-03-28_11-54-48', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 3,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 4,  NORECOVERY
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 6,  RECOVERY

-- Tv
insert Materiel (Libelle) values('tv')

-- Restauration jusqu'à 12:14
USE [master]
BACKUP LOG [Stock2] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_LogBackup_2023-03-28_12-15-36.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'Stock2_LogBackup_2023-03-28_12-15-36', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 2,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 5,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_backup1.bak' 
	WITH  FILE = 6,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [Stock2] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\Stock2_LogBackup_2023-03-28_11-47-41.bak' 
	WITH  FILE = 3, RECOVERY, NOUNLOAD,  STATS = 5

GO

USE [master]
GO
EXEC master.dbo.sp_addumpdevice  
	@devtype = N'disk', 
	@logicalname = N'saveStock2', 
	@physicalname = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\saveStock2.bak'
GO
EXEC master.dbo.sp_addumpdevice  
	@devtype = N'disk', 
	@logicalname = N'save2Stock2', 
	@physicalname = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\save2Stock2.bak'
GO

BACKUP DATABASE [Stock2] 
	TO  
		[saveStock2],  
		[save2Stock2],  
		DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\Backup\stock2.bak' 
	WITH NOFORMAT, NOINIT,  NAME = N'Stock2-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

use Stock2;
select * from Materiel
delete Materiel
