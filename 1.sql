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

