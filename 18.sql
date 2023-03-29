-- Créer une BD avec une table avec 2 champs un Guid et un décimal (valeur boursière)
use master
go
CREATE DATABASE [CAC40]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CAC40', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CAC40.mdf' , 
	SIZE = 512KB , FILEGROWTH = 100KB )
 LOG ON 
( NAME = N'CAC40_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CAC40_log.ldf' , SIZE = 512KB , FILEGROWTH = 100KB )
GO
USE [CAC40]
GO
CREATE TABLE [dbo].[Cotation](
	[Id] [uniqueidentifier] NOT NULL,
	[Valeur] [decimal](18, 4) NOT NULL,
 CONSTRAINT [PK_Cotation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cotation] ADD  CONSTRAINT [DF_Cotation_Id]  DEFAULT (newid()) FOR [Id]
GO

-- Faire une boucle qui remplit cette table avec valeur alea pour le décimal
-- avec une pause de 10 ms
delete Cotation
DECLARE @i int = 1
WHILE @i < 400000
BEGIN
	insert into Cotation (Valeur) values(RAND()*100)
	SET @i=@i +1 
	WAITFOR DELAY '00:00:00.001'
END
select * from Cotation

-- Mettre la BD en mode de récupération simple
-- Afficher dans Perf le compteur taille occupée de la BD
-- Exécuter la boucle
--USE [master]
--GO
--ALTER DATABASE [CAC40] SET RECOVERY SIMPLE WITH NO_WAIT
--GO

-- Créer une alerte qui lorsque la BD dépasse 1 Go 
-- rédéfinit la taille de la BD à 3 Go

ALTER DATABASE CAC40 MODIFY FILE (NAME = 'CAC40', SIZE = 3GB, FILEGROWTH = 1GB)
