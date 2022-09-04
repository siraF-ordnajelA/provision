alter procedure medallia_guardado_4

@id_cas int,
@accion tinyint,
@resp_clooper varchar(1000)

as

update medallia_encuestas
set fecha_cierre3 = cast(getdate() as smalldatetime),
	accion_ejecutada = 4,
	estado = 3,
	accion_clooper = @accion,
	respuesta_clooper = @resp_clooper
where id_caso = @id_cas