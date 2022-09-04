alter procedure medallia_busca_2

@id_encuesta int,
@id_cliente bigint,
@dni_tecnico varchar(255),
@ctta varchar(150),
@fecha1 varchar(8),
@fecha2 varchar(8)

as

IF (@dni_tecnico = '' and @ctta = '-- TODAS --')
BEGIN
select * from lista_medallia_casos
where id_cliente = @id_cliente or
		id_encuesta = @id_encuesta or
		(fecha_mail between @fecha1 and @fecha2)
order by nombre_tecnico, fecha_mail desc
END

IF (@dni_tecnico = '' and @ctta <> '-- TODAS --')
BEGIN
select * from lista_medallia_casos
where id_cliente = @id_cliente or
		id_encuesta = @id_encuesta or
		((fecha_mail between @fecha1 and @fecha2) and
		descripcion_contrata = @ctta)
order by nombre_tecnico, fecha_mail desc
END

IF (@dni_tecnico <> '')
BEGIN
select * from lista_medallia_casos
where id_cliente = @id_cliente or
		id_encuesta = @id_encuesta or
		nombre_tecnico like '%' + @dni_tecnico + '%' or
		(fecha_mail between @fecha1 and @fecha2)
order by nombre_tecnico, fecha_mail desc
END


