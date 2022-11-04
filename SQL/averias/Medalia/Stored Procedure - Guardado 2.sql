alter procedure medallia_guardado_2

@id_cas int,
@resp_sup varchar(2000),
@cbo_resp_sup tinyint,
@sn_anterior varchar(80),
@sn_actual varchar(80)

as

declare @obs varchar(2000)
set @obs = (select respuesta_supervisor from medallia_encuestas where id_caso = @id_cas)


IF (@obs is null)
BEGIN
update medallia_encuestas
set fecha_cierre1 = cast(getdate() as smalldatetime),
	estado = 3,
	respuesta_supervisor = @resp_sup,
	cbo_resp_supervisor = @cbo_resp_sup,
	sn_anterior = @sn_anterior,
	sn_actual = @sn_actual
where id_caso = @id_cas
END

ELSE
BEGIN
update medallia_encuestas
set fecha_cierre1 = cast(getdate() as smalldatetime),
	estado = 3,
	respuesta_supervisor = @obs + ' // ' + @resp_sup,
	cbo_resp_supervisor = @cbo_resp_sup,
	sn_anterior = @sn_anterior,
	sn_actual = @sn_actual
where id_caso = @id_cas
END