alter procedure medallia_detalle_motivos
@centro varchar(150),
@fecha1 varchar(8),
@fecha2 varchar(8),
@subconcepto varchar (80),
@detalle varchar(80),
@opcion tinyint

as

declare @inicio date, @fin date
set @inicio = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO DEL MES ACTUAL
set @fin = cast (getdate() as date)

IF (@opcion = 1)
BEGIN
	-- DETALLE TASA SIN FECHA
	IF (@centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.concepto = @subconcepto and
			a.subconcepto = @detalle and
			a.fecha_mail between @inicio and @fin;
	END

	-- DETALLE TASA CON FECHA
	IF (@centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.concepto = @subconcepto and
			a.subconcepto = @detalle and
			a.fecha_mail between @fecha1 and @fecha2;
	END

	-- DETALLE CONTRATA SIN FECHA
	IF (@centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.concepto = @subconcepto and
			a.subconcepto = @detalle and
			a.fecha_mail between @inicio and @fin and
			b.ctta = @centro;
	END

	-- DETALLE CONTRATA CON FECHA
	IF (@centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.concepto = @subconcepto and
			a.subconcepto = @detalle and
			a.fecha_mail between @fecha1 and @fecha2 and
			b.ctta = @centro;
	END
END

IF (@opcion = 2)
BEGIN
	-- DETALLE TASA SIN FECHA
	IF (@centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.subconcepto = @subconcepto and a.detalle = @detalle and
			a.fecha_mail between @inicio and @fin;
	END

	-- DETALLE TASA CON FECHA
	IF (@centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.subconcepto = @subconcepto and
			a.detalle = @detalle and
			a.fecha_mail between @fecha1 and @fecha2;
	END

	-- DETALLE CONTRATA SIN FECHA
	IF (@centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.subconcepto = @subconcepto and
			a.detalle = @detalle and
			a.fecha_mail between @inicio and @fin and
			b.ctta = @centro;
	END

	-- DETALLE CONTRATA CON FECHA
	IF (@centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
	BEGIN
	select a.id_caso,
			a.usuario as clooper,
			b.nombre,
			b.ctta,
			b.activo,
			a.fecha_encuesta,
			a.fecha_mail,
			a.fecha_fin,
			a.comentarios_cliente,
			a.resp_supervisor,
			a.subconcepto,
			a.detalle,
			a.[Acción ejecutada]

	from lista_medallia_casos as a left join tecnicos as b
	on a.id_recurso = b.id_tecnico
	where a.subconcepto = @subconcepto and
			a.detalle = @detalle and
			a.fecha_mail between @fecha1 and @fecha2 and
			b.ctta = @centro;
	END
END