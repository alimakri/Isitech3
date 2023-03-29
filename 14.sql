CREATE PROC OperationXML(@xml xml)
AS
SELECT  
	T.N.value('@op[1]', 'nvarchar(MAX)') id,  
	T.N.value('@nom[1]', 'nvarchar(MAX)') nom,  
	T.N.value('@prenom[1]', 'nvarchar(MAX)') prenom
INTO #t
FROM   
	@xml.nodes('/operations/doublon') T(N)  

--insert BD1.dbo.Personne (nom, prenom) select  Nom, Prenom from #t
GO
Exec OperationXML '
	<operations>
		<doublon op="delete" nom="Dupont" prenom="Pierre" />
		<doublon op="delete" nom="Zola" prenom="Emile" />
	</operations>'