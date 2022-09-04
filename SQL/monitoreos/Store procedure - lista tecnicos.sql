alter procedure lista_tecnicos 
as

--select * from BOU.dbo.tecnicos
select CTTA,
		Nombre,
		dni as ID_TOA,
		id_tecnico as ID_RECURSO

from tecnicos
where id_tecnico <> 0 and id_tecnico <> 1--and activo = 1
order by nombre