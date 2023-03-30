
use Stock;
select * from Produit where Prix > 3000

BEGIN TRAN
delete Produit where Prix > 3000
ROLLBACK TRAN
COMMIT TRAN