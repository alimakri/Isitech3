use BD1
go
select * from AdventureWorks2017.Person.Person

select * from Personne

insert into Personne (Nom, Prenom) 
	select FirstName, LastName from AdventureWorks2017.Person.Person 
		where PersonType = 'EM'
select * from Personne

insert into Ville (Nom)
 select distinct city from AdventureWorks2017.Person.Address order by city

select * from Ville

