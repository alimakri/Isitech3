CREATE DATABASE BD1
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
