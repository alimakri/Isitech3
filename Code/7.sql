SP_CONFIGURE 'show advanced options', 1; 
RECONFIGURE; 

GO 
SP_CONFIGURE 'Ad Hoc Distributed Queries', 1; 
RECONFIGURE;
GO 
 

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 
EXEC master.[sys].[sp_MSset_oledb_prop] N'Microsoft.ACE.OLEDB.12.0', N'DisallowAdHocAccess', 1
EXEC master.[sys].[sp_MSset_oledb_prop] N'Microsoft.ACE.OLEDB.16.0', N'AllowInProcess', 1

SELECT * 
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
   'Excel 12.0 Xml;Database=D:\Classeur1.xlsx;', Personnes$);
