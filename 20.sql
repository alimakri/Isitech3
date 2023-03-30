use AdventureWorks2017
go
select ProductID, ProductNumber, Color, ListPrice from Production.Product

select SalesOrderID, OrderQty, ProductID, UnitPrice from Sales.SalesOrderDetail
select SalesOrderID, OrderDate, CustomerID, SalesPersonID  from Sales.SalesOrderHeader

