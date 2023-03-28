-- 

SELECT Person.Person.BusinessEntityID, Person.Person.FirstName, Person.Person.LastName, Person.Address.City
FROM     Person.Address INNER JOIN
                  Person.BusinessEntityAddress ON Person.Address.AddressID = Person.BusinessEntityAddress.AddressID INNER JOIN
                  Person.Person ON Person.BusinessEntityAddress.BusinessEntityID = Person.Person.BusinessEntityID