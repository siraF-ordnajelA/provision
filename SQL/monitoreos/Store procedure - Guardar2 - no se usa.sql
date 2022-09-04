alter procedure carga_monitoreo2
@id_pendiente int

as

declare @id_monitoreo int
set @id_monitoreo = (select top 1 id_gestion from mon_gestionados2 order by fyhgestion desc) 

update mon_medallia_lista
set monitoreado = 1,
	id_monitoreo = @id_monitoreo
where id_pendiente = @id_pendiente

update mon_gestionados2
set id_medallia = @id_pendiente
where id_gestion = @id_monitoreo