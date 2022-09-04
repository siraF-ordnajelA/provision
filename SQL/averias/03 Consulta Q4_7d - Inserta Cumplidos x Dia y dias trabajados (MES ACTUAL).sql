create table #cumplidas_raw (Fecha date, recurso smallint, cumplidas smallint)

declare @fecha1 date

-- MES ACTUAL (Metrica incompleta)
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO MES ACTUAL


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


-- CONSULTA FINAL 1
merge into q4s_7d as destino
using (select recurso,
			--COUNT (Fecha) as [Días trabajados],
			ROUND (AVG (cast (cumplidas as float)), 2) as [Prom. cumplidas x día]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.Fecha = @fecha1

when matched then update
set --destino.dias_trabajo = origen.[Días trabajados],
	destino.prom_diarias = origen.[Prom. cumplidas x día];
	

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


-- CONSULTA FINAL 2
merge into Q4s_7d as destino
using (select recurso,
			COUNT(Fecha) as [Días trabajados]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.Fecha = @fecha1

when matched then update
set destino.dias_trabajo = origen.[Días trabajados];