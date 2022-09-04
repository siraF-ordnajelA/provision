alter procedure medallia_motivos_detractores
@opc tinyint,
@centro varchar(150),
@fecha1 varchar(8),
@fecha2 varchar(8),
@motivo varchar(80),
@concepto varchar(80),
@subconcepto varchar (80)

as
/*
select [Motivo detractor],
		Concepto,
		Subconcepto,
		Detalle,
		count(*) as Cant

from lista_medallia_casos
group by [Motivo detractor],
		Concepto,
		Subconcepto,
		Detalle
order by [Motivo detractor],
		Concepto,
		Subconcepto,
		Detalle
*/
declare @inicio date, @fin date
--set @inicio = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MESES AL MES ACTUAL
set @inicio = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO DEL MES ACTUAL
set @fin = cast (getdate() as date)

--------------------------------- MOTIVO DETRACTOR-------------------------------------------
-- MOTIVO DETRACTOR INICIO TASA
IF (@opc = 0 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select [Motivo detractor] as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin
group by [Motivo detractor]
order by [Motivo detractor];
END

-- MOTIVO DETRACTOR POR FECHA TASA
IF (@opc = 0 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select [Motivo detractor] as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date))
group by [Motivo detractor]
order by [Motivo detractor];
END

-- MOTIVO DETRACTOR CTTA INICIO
IF (@opc = 0 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select [Motivo detractor] as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro
group by [Motivo detractor]
order by [Motivo detractor];
END

-- MOTIVO DETRACTOR CTTA POR FECHA
IF (@opc = 0 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select [Motivo detractor] as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		descripcion_contrata = @centro
group by [Motivo detractor]
order by [Motivo detractor];
END

---------------------------------- MOTIVO CONCEPTO-------------------------------------------
-- MOTIVO CONCEPTO INICIO TASA
IF (@opc = 1 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Concepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		[Motivo detractor] = @motivo
group by Concepto
order by count(*) desc;
END

-- MOTIVO CONCEPTO POR FECHA TASA
IF (@opc = 1 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Concepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		[Motivo detractor] = @motivo
group by Concepto
order by count(*) desc;
END

-- MOTIVO CONCEPTO CTTA INICIO
IF (@opc = 1 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Concepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro and
		[Motivo detractor] = @motivo
group by Concepto
order by count(*) desc;
END

-- MOTIVO CONCEPTO CTTA POR FECHA
IF (@opc = 1 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Concepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		descripcion_contrata = @centro and
		[Motivo detractor] = @motivo
group by Concepto
order by count(*) desc;
END

-------------------------------- MOTIVO SUB CONCEPTO-----------------------------------------
-- MOTIVO SUBCONCEPTO INICIO TASA
IF (@opc = 2 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Subconcepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		concepto = @concepto
group by Subconcepto
order by count(*) desc;
END

-- MOTIVO SUBCONCEPTO POR FECHA TASA
IF (@opc = 2 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Subconcepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		concepto = @concepto
group by Subconcepto
order by count(*) desc;
END

-- MOTIVO SUBCONCEPTO CTTA INICIO
IF (@opc = 2 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Subconcepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro and
		concepto = @concepto
group by Subconcepto
order by count(*) desc;
END

-- MOTIVO SUBCONCEPTO CTTA POR FECHA
IF (@opc = 2 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Subconcepto as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		descripcion_contrata = @centro and
		concepto = @concepto
group by Subconcepto
order by count(*) desc;
END

---------------------------------- MOTIVO DETALLE--------------------------------------------
-- MOTIVO DETALLE INICIO TASA
IF (@opc = 3 and @centro = 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Detalle as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		subconcepto = @subconcepto
group by Detalle
order by count(*) desc;
END

-- MOTIVO DETALLE POR FECHA TASA
IF (@opc = 3 and @centro = 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Detalle as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		subconcepto = @subconcepto
group by Detalle
order by count(*) desc;
END

-- MOTIVO DETALLE CTTA INICIO
IF (@opc = 3 and @centro <> 'TASA' and @fecha1 = '' and @fecha2 = '')
BEGIN
select Detalle as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @inicio and @fin and
		descripcion_contrata = @centro and
		subconcepto = @subconcepto
group by Detalle
order by count(*) desc;
END

-- MOTIVO DETALLE CTTA POR FECHA
IF (@opc = 3 and @centro <> 'TASA' and @fecha1 <> '' and @fecha2 <> '')
BEGIN
select Detalle as motivo, count(*) as Cant
from lista_medallia_casos
where fecha_mail between @fecha1 and DATEADD(day,1,CAST(@fecha2 as date)) and
		descripcion_contrata = @centro and
		subconcepto = @subconcepto
group by Detalle
order by count(*) desc;
END