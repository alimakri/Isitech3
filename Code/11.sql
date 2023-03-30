use AdventureWorks2017;
GO
ALTER PROC LesProduits(@cat nvarchar(50)=null, @seuilBas decimal(18,2)=null, @seuilHaut decimal(18,2)=null)
AS
	Select 
		ProductID, p.[Name], ProductNumber, ListPrice, c.Name cat 
	from 
		Production.Product p
		inner join Production.ProductSubcategory sc on p.ProductSubcategoryID = sc.ProductSubcategoryID
		inner join Production.ProductCategory c on sc.ProductCategoryID = c.ProductCategoryID
	Where
		(@cat IS NULL or c.Name = @cat)
		and 
		(@seuilBas is Null or ListPrice > @seuilBas)
		and 
		(@seuilHaut is Null or ListPrice < @seuilHaut)
GO
Exec LesProduits 
Exec LesProduits 'Bikes'
Exec LesProduits 'Bikes', 3000
Exec LesProduits @seuilBas= 100
Exec LesProduits @seuilBas= 100, @seuilHaut=200, @cat='Components'

IF NULL IS NULL PRINT 'Oui' ELSE PRINT 'NON'