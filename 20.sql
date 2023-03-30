use AdventureWorks2017
go
select ProductID, ProductNumber, Color, ListPrice from Production.Product

select SalesOrderDetailID, SalesOrderID, OrderQty, ProductID, UnitPrice from Sales.SalesOrderDetail
select SalesOrderID, OrderDate, CustomerID, SalesPersonID  from Sales.SalesOrderHeader

-- Total de la commande 43659
select 
	SUM(d.OrderQty * d.UnitPrice) TotalCommande
from 
	Sales.SalesOrderHeader h
	inner join Sales.SalesOrderDetail d on d.SalesOrderID = h.SalesOrderID
where 
	h.SalesOrderID=43659

-- Total de toutes les commandes
select 
	h.SalesOrderNumber , SUM(OrderQty * UnitPrice) Total 
from 
	Sales.SalesOrderHeader h
	inner join Sales.SalesOrderDetail d on d.SalesOrderID = h.SalesOrderID
group by
	h.SalesOrderNumber

-- Total de toutes les commandes par année
-- select YEAR(getdate())
select 
	Year(h.OrderDate) Annee, SUM(OrderQty * UnitPrice) Total 
from 
	Sales.SalesOrderHeader h
	inner join Sales.SalesOrderDetail d on d.SalesOrderID = h.SalesOrderID
group by
	Year(h.OrderDate)
order by 
	Annee

-- Le nom du produit le plus vendu (en quantité)
select top 1 p.Name 
from Sales.SalesOrderDetail d
	inner join Production.Product p on d.ProductID = p.ProductID
Group by p.Name
order by SUM(OrderQty) desc

-- Liste des produits avec sous cat et cat (nom produit, nom cat, nom sous cat)
select 
	p.Name Produit, c.Name Cat, s.Name SousCat
from 
	Production.Product p
	inner join Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
	inner join Production.ProductCategory c on s.ProductCategoryID = c.ProductCategoryID

-- Liste des personnes avec leurs villes
SELECT 
	p.BusinessEntityID, p.FirstName, p.LastName, a.City
FROM     
	Person.Person AS p 
	INNER JOIN Person.BusinessEntity AS be ON p.BusinessEntityID = be.BusinessEntityID 
	INNER JOIN Person.BusinessEntityAddress AS bea ON be.BusinessEntityID = bea.BusinessEntityID 
	INNER JOIN Person.Address AS a ON bea.AddressID = a.AddressID

-- --Quantité de produits vendus par les 3 meilleurs vendeurs
select 
	SUM(OrderQty), h.SalesPersonID 
from Sales.SalesOrderDetail d
	inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where SalesPersonID in 
	(
	select top 3
		h.SalesPersonID idVendeur
	from 
		Sales.SalesOrderDetail d
		inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
	where
		h.SalesPersonID IS NOT NULL
	group by
		h.SalesPersonID
	order by
		SUM(OrderQty * UnitPrice) desc
	)
Group by h.SalesPersonID

-- Table Temporaire
select top 3
	h.SalesPersonID idVendeur
into #t
from 
	Sales.SalesOrderDetail d
	inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where
	h.SalesPersonID IS NOT NULL
group by
	h.SalesPersonID
order by
	SUM(OrderQty * UnitPrice) desc

select 
	SUM(OrderQty), h.SalesPersonID 
from Sales.SalesOrderDetail d
	inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where SalesPersonID in (select idVendeur from #t)
Group by h.SalesPersonID

-- CTE Common Table Expression
WITH t(idVendeur) AS
(
	select top 3
		h.SalesPersonID 
	from 
		Sales.SalesOrderDetail d
		inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
	where
		h.SalesPersonID IS NOT NULL
	group by
		h.SalesPersonID
	order by
		SUM(OrderQty * UnitPrice) desc
)
select 
	SUM(OrderQty), h.SalesPersonID 
from Sales.SalesOrderDetail d
	inner join Sales.SalesOrderHeader h on d.SalesOrderID = h.SalesOrderID
where SalesPersonID in (select idVendeur from t)
Group by h.SalesPersonID

-- Recurisivité avec les CTE

-- Create an Employee table.
CREATE TABLE dbo.MyEmployees
(
EmployeeID SMALLINT NOT NULL,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(40) NOT NULL,
Title NVARCHAR(50) NOT NULL,
DeptID SMALLINT NOT NULL,
ManagerID SMALLINT NULL,
CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC),
CONSTRAINT FK_MyEmployees_ManagerID_EmployeeID FOREIGN KEY (ManagerID) REFERENCES dbo.MyEmployees (EmployeeID)
);
-- Populate the table with values.
INSERT INTO dbo.MyEmployees VALUES
(1, N'Ken', N'Sánchez', N'Chief Executive Officer',16, NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales', 3, 1)
,(274, N'Stephen', N'Jiang', N'North American Sales Manager', 3, 273)
,(275, N'Michael', N'Blythe', N'Sales Representative', 3, 274)
,(276, N'Linda', N'Mitchell', N'Sales Representative', 3, 274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager', 3, 273)
,(286, N'Lynn', N'Tsoflias', N'Sales Representative', 3, 285)
,(16, N'David', N'Bradley', N'Marketing Manager', 4, 273)
,(23, N'Mary', N'Gibson', N'Marketing Specialist', 4, 16);

WITH t(EmployeeID, FirstName, LastName, Niveau) AS
(
	select EmployeeID, FirstName, LastName, 1 Niveau from MyEmployees where ManagerID IS NULL
	UNION ALL
	select e.EmployeeID, e.FirstName, e.LastName, t.Niveau + 1 Niveau 
		from MyEmployees e 
		inner join t on ManagerID = t.EmployeeID
)
select * from t

