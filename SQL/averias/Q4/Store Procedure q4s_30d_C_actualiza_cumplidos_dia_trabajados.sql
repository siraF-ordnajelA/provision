alter procedure q4s_30d_C_actualiza_cumplidos_dia_trabajados
@opc tinyint
/*
1 = MES COMPLETO
2 = MES ANTERIOR
3 = MES ACTUAL
*/
as

create table #cumplidas_raw (Fecha date, recurso smallint, cumplidas smallint)

declare @fecha1 date

-- MES COMPLETO
IF (@opc = 1)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL
END

-- MES ANTERIOR
ELSE IF (@opc = 2)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
END

-- MES ACTUAL
ELSE IF (@opc = 3)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO MES ACTUAL
END

-- INSERTO EL CRUDO DE CUMPLIDAS POR DIA
insert into #cumplidas_raw (Fecha, recurso, cumplidas)

select cast (timestamp as date) as Fecha,
		[ID RECURSO],
		count (*) as Cumplidas

from ATC.dbo.toa_pm
where periodo = (select replace(cast(@fecha1 as varchar(7)),'-','')) and
		alta = 1 and
		[Estado de la orden] = 'Completado'
group by cast (timestamp as date), [ID RECURSO]

-- ARREGLAR FECHA PEGA EN TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- CONSULTA FINAL ACTUALIZO PROMEDIO INSTALACIONES DIARIAS POR TECNICO
UPDATE Q4s_30d
SET prom_diarias = tabla2agregada.campo1agregado
FROM Q4s_30d as t1 
     JOIN (SELECT recurso, ROUND (AVG (cast (cumplidas as float)), 2) as campo1agregado
            FROM #cumplidas_raw as t1, Q4s_30d as t2
            WHERE t1.recurso = t2.id_tecnico
            GROUP BY t1.recurso) as  tabla2agregada
     ON t1.id_tecnico = tabla2agregada.recurso
where t1.Fecha = @fecha1

-- INSERTO DIAS TRABAJADOS POR TECNICO
truncate table #cumplidas_raw

insert into #cumplidas_raw (Fecha, recurso)

select cast (timestamp as date) as Fecha,
		[ID RECURSO]

from ATC.dbo.toa_pm
where periodo = (select replace(cast(@fecha1 as varchar(7)),'-','')) and
		alta = 1 and
		[Estado de la Orden] in ('Completado','No Realizada', 'Suspendido')
group by cast (timestamp as date), [ID RECURSO]


-- CONSULTA FINAL INSERTO TOTAL DE DIAS TRABAJADOS POR TECNICO
UPDATE Q4s_30d
SET dias_trabajo = tabla2agregada.campo1agregado
FROM Q4s_30d as t1 
     JOIN (SELECT recurso, COUNT(Fecha) as campo1agregado
            FROM #cumplidas_raw
            GROUP BY recurso) as  tabla2agregada
     ON t1.id_tecnico = tabla2agregada.recurso
where t1.Fecha = @fecha1

/*
merge into Q4s_30d as destino
using (select recurso,
			COUNT(Fecha) as [Días trabajados]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.Fecha = @fecha1

when matched then update
set destino.dias_trabajo = origen.[Días trabajados];
*/