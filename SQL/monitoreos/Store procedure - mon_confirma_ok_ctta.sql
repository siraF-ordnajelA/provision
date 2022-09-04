alter procedure mon_confirma_ok_ctta
@id_gestion int,
@comentario varchar(500)

as

update mon_gestionados2
set visto_ctta = 1,
	nombre_tec = @comentario,
	fecha_visto_ctta = cast(getdate() as smalldatetime)
where id_gestion = @id_gestion