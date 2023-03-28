CREATE PROC AjoutPersonneXML(@xml xml)
AS
SELECT  
	T.N.value('@id[1]', 'int') id,  
	T.N.value('nom[1]', 'nvarchar(MAX)') nom,  
	T.N.value('prenom[1]', 'nvarchar(MAX)') prenom
INTO #t
FROM   
	@xml.nodes('/personnes/personne') T(N)  

insert BD1.dbo.Personne (nom, prenom) select  Nom, Prenom from #t
GO
Exec AjoutPersonneXML '<personnes>
  <personne id="1">
      <nom>Dupont</nom>
      <prenom>Pierre</prenom>
  </personne>
  <personne id="2">
      <nom>Zola</nom>
      <prenom>Emile</prenom>
  </personne>
</personnes>'

select * from bd1.dbo.Personne 
