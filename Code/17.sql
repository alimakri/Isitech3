USE [master]
GO
CREATE DATABASE [Amazon]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Amazon', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Amazon.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Amazon_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\Amazon_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
USE [Amazon]
GO
CREATE TABLE [dbo].[Login](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[NumeroCB] [nvarchar](50) NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
insert Login (Id, Name, Password, NumeroCB) values(NEWID(), 'Makri', 'P@ssw0rd', '46546464')

-- ***********************
DECLARE @Name nvarchar(50)='Makri'
DECLARE @Password nvarchar(50)=''' or 1=1 or 1=''''; delete Login';

DECLARE @requete nvarchar(MAX) = 
	'select Count(*) from Login where Name=''' + 
		@Name + ''' and Password=''' + 
		@Password 
PRINT @requete
Exec(@requete)

BEGIN TRAN
select Count(*) from Login where Name='Makri' and Password='' or 1=1 or 1=''; delete Login
select * from Login
ROLLBACK TRAN
select * from Login
