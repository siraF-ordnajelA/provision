alter procedure obtener_tecnico  
@id_recu varchar (10)  
as
/*
select top 1 CTTA, ID_TOA  
from BOU.dbo.Tecnicos  
where ID_RECURSO = @id_recu
*/
select CTTA, dni as ID_TOA
from tecnicos
where id_tecnico = @id_recu