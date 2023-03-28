-- Proc stoc Filtrer par ville, par initial de nom
CREATE PROC ListePersonne(@ville nvarchar(50), @initiale char)
AS
SELECT 
	p.BusinessEntityID id, 
	p.FirstName prenom, 
	p.LastName nom, 
	a.City ville
FROM     
	Person.Address a
	INNER JOIN Person.BusinessEntityAddress bea ON a.AddressID = bea.AddressID 
	INNER JOIN Person.Person p ON bea.BusinessEntityID = p.BusinessEntityID
GO
EXEC ListePersonne
Exec ListePersonne 'Seattle'
Exec ListePersonne 'Seattle', 'A'
Exec ListePersonne @initiale = 'B'
