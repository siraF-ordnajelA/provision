alter procedure garantia_actualiza_descargo
@id_clooper smallint,
@id_descargo int,
@motivo tinyint,
@submotivo smallint,
@respuesta varchar(500)

as

update garantias_descargo
set id_gestor = @id_clooper,
	fecha_gestor = cast(getdate() as smalldatetime),
	cbo1_gestor = @motivo,
	cbo2_gestor = @submotivo,
	comentarios_gestor = @respuesta,
	trabajado_gestor = 1
where id_descargo = @id_descargo

select 'Se actualizo correctamente.' as mensaje