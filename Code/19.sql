select * from 
(
select 1 col1, GETDATE() col2, NEWID() col3, 'ABC' col4, CONVERT(xml, '<a/>') col5
UNION ALL
select 2, DATEADD(day, -1, GETDATE()), NEWID(), 'DEF', CONVERT(xml, '<b/>')
UNION ALL
select 3, NULL, NEWID(), 'DEF', NULL
) t

select * 
into #Personne
from
(
select 1 id, 'Pierre' nom, 1 ville
UNION ALL
select 2, 'Paul', 1
UNION ALL
select 3, 'Jacques', 2
UNION ALL
select 4, 'Sylvie', NULL
) Personne

select * 
into #ville
from
(
select 1 id, 'Paris' nom
UNION ALL
select 2, 'Lyon'
UNION ALL
select 3, 'Marseille'
) Ville

select * from #Personne, #ville where #Personne.ville=#ville.id

select * from #Personne p inner join #ville v on p.ville=v.id

select * from #Personne, #ville where #Personne.ville=#ville.id or #Personne.ville is null

select * from #Personne p left outer join #ville v on p.ville=v.id

select * from #Personne p right outer join #ville v on p.ville=v.id

select * from #Personne p full join #ville v on p.ville=v.id

select v.nom nomVille, COUNT(p.id) n
from #Personne p inner join #ville v on p.ville=v.id
GROUP BY v.nom
