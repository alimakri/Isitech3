-- Proc stoc Filtrer par ville, par initial de nom
CREATE PROC ListePersonne(@ville nvarchar(50), @initiale char)
AS
SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName, Person.Address.City
FROM     Person.Address INNER JOIN
                  Person.BusinessEntityAddress ON Person.Address.AddressID = Person.BusinessEntityAddress.AddressID INNER JOIN
                  Person.Person ON Person.BusinessEntityAddress.BusinessEntityID = Person.Person.BusinessEntityID
GO
EXEC ListePersonne
Exec ListePersonne 'Seattle'
Exec ListePersonne 'Seattle', 'A'
Exec ListePersonne @initiale = 'B'
