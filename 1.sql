use master
Go
IF EXISTS(select * from sys.sysdatabases where name='BD1') DROP DATABASE [BD1]
GO
CREATE DATABASE BD1 ON PRIMARY
	( 
	NAME = 'BD1', 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BD1.mdf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
	)
	LOG ON 
	( 
	NAME = 'BD1_log', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\BD1_log.ldf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB 
	)
GO
USE [BD1]
go
CREATE TABLE dbo.Personne
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	[Prenom] [nvarchar](50) NOT NULL,
	[DateNaissance] [datetime] NULL,
	CONSTRAINT [PK_Personne] PRIMARY KEY CLUSTERED ([Id] ASC)
) 
GO
CREATE TABLE dbo.Ville
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	CONSTRAINT [PK_Ville] PRIMARY KEY CLUSTERED ([Id] ASC)
) 
GO
CREATE TABLE [dbo].[PersonneVille]
(
	[Personne] [bigint] NOT NULL,
	[Ville] [bigint] NOT NULL
) 
GO  

ALTER TABLE [dbo].[PersonneVille]  WITH CHECK ADD  CONSTRAINT [FK_PersonneVille_Personne] FOREIGN KEY([Personne]) REFERENCES [dbo].[Personne] ([Id])
ALTER TABLE [dbo].[PersonneVille] CHECK CONSTRAINT [FK_PersonneVille_Personne]
GO

ALTER TABLE [dbo].[PersonneVille]  WITH CHECK ADD  CONSTRAINT [FK_PersonneVille_Ville] FOREIGN KEY([Ville]) REFERENCES [dbo].[Ville] ([Id])
ALTER TABLE [dbo].[PersonneVille] CHECK CONSTRAINT [FK_PersonneVille_Ville]
GO
insert Personne (Nom, Prenom) values
	('Dupont', 'Pierre'),
	('Zola', 'Emile'),
	('Poquelin', 'Jean-Baptiste')
insert Ville (Nom) values('Paris'),('Lyon'), ('Marseille')

insert PersonneVille (Personne, Ville) values
	(1, 1),
	(2, 1),
	(2, 2)

SELECT 
	Personne.Prenom  AS prenom, 
	Personne.Nom AS Nom, 
	Ville.Nom AS Ville
FROM     
	Personne 
	FULL OUTER JOIN PersonneVille ON Personne.Id = PersonneVille.Personne 
	FULL OUTER JOIN Ville ON PersonneVille.Ville = Ville.Id


