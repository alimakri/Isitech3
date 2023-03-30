use AdventureWorks2017;

-- Table permanente
select 
	BusinessEntityID id, 
	FirstName Prenom, 
	LastName Nom 
into t1
from 
	Person.Person 
where 
	PersonType='EM'

-- Table temporaire
select 
	BusinessEntityID id, 
	FirstName Prenom, 
	LastName Nom 
into #t1
from 
	Person.Person 
where 
	PersonType='EM'

select * from #t1

-- Table temporaire partagée
select 
	BusinessEntityID id, 
	FirstName Prenom, 
	LastName Nom 
into ##t1
from 
	Person.Person 
where 
	PersonType='EM'

select * from ##t1

