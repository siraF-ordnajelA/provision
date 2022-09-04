alter procedure medallia_guardado_3

@id_cas int,
@motivo tinyint,
@concepto tinyint,
@sub tinyint,
@detalle tinyint,
@accion tinyint,
@estado tinyint,
@gest_clooper tinyint,
@resp_cliente tinyint,
@resp_final_cliente tinyint,
@resp_clooper varchar(1000)

as

IF ((select motivo_detractor + concepto + subconcepto + detalle as combo1 from medallia_encuestas where id_caso = @id_cas) = @motivo + @concepto + @sub + @detalle)
BEGIN
update medallia_encuestas
set fecha_cierre2 = cast(getdate() as smalldatetime),
	motivo_detractor_2 = null,
	concepto_2 = null,
	subconcepto_2 = null,
	detalle_2 = null,
	accion_ejecutada = @accion,
	estado = @estado,
	accion_clooper = @gest_clooper,
	respuesta_cliente = @resp_cliente,
	resp_final_cliente = @resp_final_cliente,
	respuesta_clooper = @resp_clooper
where id_caso = @id_cas;
END

ELSE
BEGIN
update medallia_encuestas
set fecha_cierre2 = cast(getdate() as smalldatetime),
	motivo_detractor_2 = @motivo,
	concepto_2 = @concepto,
	subconcepto_2 = @sub,
	detalle_2 = @detalle,
	accion_ejecutada = @accion,
	estado = @estado,
	accion_clooper = @gest_clooper,
	respuesta_cliente = @resp_cliente,
	resp_final_cliente = @resp_final_cliente,
	respuesta_clooper = @resp_clooper
where id_caso = @id_cas;
END

IF (@estado = 4)
BEGIN
insert into mon_medallia_lista(id_medallia, id_recurso, monitoreado)
values (@id_cas, (select id_recurso from medallia_encuestas where id_caso = @id_cas), 0);
END