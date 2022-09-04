alter procedure medallia_lista_pendiente
@opc tinyint,
@centro varchar(150),
@fecha1 varchar(11),
@fecha2 varchar(11)

as

declare @inicio date, @fin date, @fecha3 date
set @inicio = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO DEL MES ACTUAL
set @fin = cast (getdate() as date)
set @fecha3 = dateadd(day, 1, cast(@fecha2 as date))


--------------------------------- TOP 10 TECNICOS --------------------------------------
-- Top 10 TASA
IF (@opc = 1 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select top 10 nombre_tecnico as nombre,
		descripcion_contrata,
		count(*) as Cant

from lista_medallia_casos
where fecha_mail between @inicio and @fin
group by nombre_tecnico, descripcion_contrata
order by count(*) desc, nombre_tecnico;
END

IF (@opc = 1 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select top 10 nombre_tecnico as nombre,
		descripcion_contrata,
		count(*) as Cant

from lista_medallia_casos
where fecha_mail between @fecha1 and @fecha2
group by nombre_tecnico, descripcion_contrata
order by count(*) desc, nombre_tecnico;
END

-- Top 10 CTTA
IF (@opc = 1 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select top 10 nombre_tecnico as nombre,
		descripcion_contrata,
		count(*) as Cant

from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro
group by nombre_tecnico, descripcion_contrata
order by count(*) desc, nombre_tecnico;
END

IF (@opc = 1 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select top 10 nombre_tecnico as nombre,
		descripcion_contrata,
		count(*) as Cant

from lista_medallia_casos
where fecha_mail between @fecha1 and @fecha2 and
		descripcion_contrata = @centro
group by nombre_tecnico, descripcion_contrata
order by count(*) desc, nombre_tecnico;
END

--------------------------------- PENDIENTE ENCUESTAS ----------------------------------
-- Pendientes TASA
IF (@opc = 2 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select descripcion_contrata,
		count(*) as Cant,
		max(datediff(day, fecha_mail, getdate())) as Diff

from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		[Acción ejecutada] = 'Derivado a la contratista' and
		(Estado = 'Escalado / Refuerzo' or
		Estado = 'Escalado')
		
group by descripcion_contrata
order by count(*) desc;
END

IF (@opc = 2 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select descripcion_contrata,
		count(*) as Cant,
		max(datediff(day, fecha_mail, getdate())) as Diff

from lista_medallia_casos
where fecha_mail between @fecha1 and @fecha2 and
		[Acción ejecutada] = 'Derivado a la contratista' and
		(Estado = 'Escalado / Refuerzo' or
		Estado = 'Escalado')
		
group by descripcion_contrata
order by count(*) desc;
END

-- Pendientes CTTA
IF (@opc = 2 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select descripcion_contrata,
		count(*) as Cant,
		max(datediff(day, fecha_mail, getdate())) as Diff

from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro and
		[Acción ejecutada] = 'Derivado a la contratista' and
		(Estado = 'Escalado / Refuerzo' or
		Estado = 'Escalado')
		
group by descripcion_contrata
order by count(*) desc;
END

IF (@opc = 2 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select descripcion_contrata,
		count(*) as Cant,
		max(datediff(day, fecha_mail, getdate())) as Diff

from lista_medallia_casos
where fecha_mail between @fecha1 and @fecha2 and
		descripcion_contrata = @centro and
		[Acción ejecutada] = 'Derivado a la contratista' and
		(Estado = 'Escalado / Refuerzo' or
		Estado = 'Escalado')
		
group by descripcion_contrata
order by count(*) desc;
END