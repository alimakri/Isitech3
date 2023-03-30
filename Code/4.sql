use master;
IF EXISTS(select * from sys.sysdatabases where name='Stock') 
	DROP DATABASE Stock
GO
CREATE DATABASE Stock ON  PRIMARY 
( 
	NAME = N'Stock', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Stock.mdf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB )
	LOG ON 
	( 
	NAME = N'Stock_log', 
	FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Stock_log.ldf' , 
	SIZE = 8192KB , 
	FILEGROWTH = 65536KB
)
use Stock;
CREATE TABLE dbo.Produit
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Nom] [nvarchar](50) NOT NULL,
	Prix decimal(18,2) NOT NULL,
	CONSTRAINT [PK_Produit] PRIMARY KEY CLUSTERED ([Id] ASC)
) 
go
CREATE TABLE dbo.Commande
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	DateCommande Datetime NOT NULL,
	CONSTRAINT [PK_Commande] PRIMARY KEY CLUSTERED ([Id] ASC)
) 
go
CREATE TABLE dbo.DetailCommande
(
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	Commande bigint NOT NULL,
	Produit bigint NOT NULL,
	Quantite int NOT NULL,
	PrixUnitaire decimal(18,2) NOT NULL,
	CONSTRAINT PK_DetailCommande PRIMARY KEY CLUSTERED ([Id] ASC)
) 
USE [Stock]
GO


ALTER TABLE [dbo].[DetailCommande]  WITH CHECK ADD  CONSTRAINT [FK_DetailCommande_Commande] FOREIGN KEY([Commande]) REFERENCES [dbo].[Commande] ([Id])
ALTER TABLE [dbo].[DetailCommande] CHECK CONSTRAINT [FK_DetailCommande_Commande]
GO

ALTER TABLE [dbo].[DetailCommande]  WITH CHECK ADD  CONSTRAINT [FK_DetailCommande_Produit] FOREIGN KEY([Produit]) REFERENCES [dbo].[Produit] ([Id])
ALTER TABLE [dbo].[DetailCommande] CHECK CONSTRAINT [FK_DetailCommande_Produit]
GO

insert into Produit (Nom, Prix)
	select Name, ListPrice from AdventureWorks2017.Production.Product 
	where ProductNumber like 'BK%'

select * from Produit

insert Commande (DateCommande) values(GETDATE())

select * from Commande

insert DetailCommande (Commande, Produit, Quantite, PrixUnitaire) values
	(1, 2, 3, 3578.27),	
	(1, 18, 2, 782.99)

select SUM(Quantite * PrixUnitaire) from DetailCommande where Commande=1

