-- Proc stoc Filtrer par ville, par initial de nom
ALTER PROC ListePersonne(@ville nvarchar(50)=null, @initiale char=null)
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
WHERE
	(@ville is null or a.City=@ville) and
	--(@initiale is null or p.LastName like @initiale + '%')
	(@initiale is null or LEFT(p.LastName,1)=@initiale)
GO
EXEC ListePersonne
Exec ListePersonne 'Seattle'
Exec ListePersonne 'Seattle', 'A'
Exec ListePersonne @initiale = 'B'
