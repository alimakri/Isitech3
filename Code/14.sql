use BD1;
GO
ALTER PROC OperationXML(@xml xml)
AS
SELECT  
	T.N.value('@op[1]', 'nvarchar(MAX)') id,  
	T.N.value('@nom[1]', 'nvarchar(MAX)') nom,  
	T.N.value('@prenom[1]', 'nvarchar(MAX)') prenom
INTO #t1
FROM   
	@xml.nodes('/operations/doublon') T(N)  

select 
	ROW_NUMBER() OVER(PARTITION BY nom, prenom ORDER BY nom ASC) n,
	id, 
	nom, 
	prenom 
into #t2
from Personne 

delete Personne where id in 
	(
	select 
		#t2.id
	from #t1 
		inner join #t2 on 
						#t1.nom = #t2.nom and 
						#t1.prenom = #t2.prenom and 
						#t1.id='delete' and
						#t2.n > 1
	)
GO
Exec OperationXML '
	<operations>
		<doublon op="delete" nom="Dupont" prenom="Pierre" />
		<doublon op="delete" nom="Zola" prenom="Emile" />
	</operations>'

select * from Personne
--delete PersonneVille
--delete ville




