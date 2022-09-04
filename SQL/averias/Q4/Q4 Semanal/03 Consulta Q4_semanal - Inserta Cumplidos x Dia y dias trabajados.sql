create procedure q4s_Semanal_C

as

create table #cumplidas_raw (Fecha date, recurso smallint, cumplidas smallint)

declare @fecha date
declare @fecha1 date
declare @fecha2 date


------------------------------------------------- 2 SEMANAS
--SETEA FECHA 2 SEMANAS ATRAS
set @fecha = cast(getdate() as date)
set @fecha1 = (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-8)) -- 2 SEMANAS ATRAS
set @fecha2 = dateadd(day, 1, (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-2))) -- 1 SEMANA ATRAS
--select @fecha1, @fecha2


-- INSERTO EL CRUDO DE CUMPLIDAS POR DIA
insert into #cumplidas_raw (Fecha, recurso, cumplidas)

select cast (timestamp as date) as Fecha,
		[ID RECURSO],
		count (*) as Cumplidas

from ATC.dbo.toa_pm
where TIMESTAMP between @fecha1 and @fecha2 and
		alta = 1 and
		[Estado de la orden] = 'Completado'
group by cast (timestamp as date), [ID RECURSO]


-- CONSULTA FINAL 1
merge into Q4s_semanal as destino
using (select recurso,
			--COUNT (Fecha) as [Días trabajados],
			ROUND (AVG (cast (cumplidas as float)), 2) as [Prom. cumplidas x día]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.fecha1 = @fecha1

when matched then update
set --destino.dias_trabajo = origen.[Días trabajados],
	destino.prom_diarias = origen.[Prom. cumplidas x día];
	

-- INSERTO DIAS TRABAJADOS POR TECNICO
truncate table #cumplidas_raw

insert into #cumplidas_raw (Fecha, recurso)

select cast (timestamp as date) as Fecha,
		[ID RECURSO]

from ATC.dbo.toa_pm
where TIMESTAMP between @fecha1 and @fecha2 and
		alta = 1 and
		[Estado de la Orden] in ('Completado','No Realizada', 'Suspendido')
group by cast (timestamp as date), [ID RECURSO]


-- CONSULTA FINAL 2
merge into Q4s_semanal as destino
using (select recurso,
			COUNT(Fecha) as [Días trabajados]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.fecha1 = @fecha1

when matched then update
set destino.dias_trabajo = origen.[Días trabajados];


------------------------------------------------- 1 SEMANA
-- SETEO FECHAS A 1 SEMANA ATRAS
set @fecha1 = DATEADD(day,7,@fecha1)
set @fecha2 = DATEADD(day,7,@fecha2)

truncate table #cumplidas_raw

-- INSERTO EL CRUDO DE CUMPLIDAS POR DIA
insert into #cumplidas_raw (Fecha, recurso, cumplidas)

select cast (timestamp as date) as Fecha,
		[ID RECURSO],
		count (*) as Cumplidas

from ATC.dbo.toa_pm
where TIMESTAMP between @fecha1 and @fecha2 and
		alta = 1 and
		[Estado de la orden] = 'Completado'
group by cast (timestamp as date), [ID RECURSO]


-- CONSULTA FINAL 1
merge into Q4s_semanal as destino
using (select recurso,
			--COUNT (Fecha) as [Días trabajados],
			ROUND (AVG (cast (cumplidas as float)), 2) as [Prom. cumplidas x día]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.fecha1 = @fecha1

when matched then update
set --destino.dias_trabajo = origen.[Días trabajados],
	destino.prom_diarias = origen.[Prom. cumplidas x día];
	

-- INSERTO DIAS TRABAJADOS POR TECNICO
truncate table #cumplidas_raw

insert into #cumplidas_raw (Fecha, recurso)

select cast (timestamp as date) as Fecha,
		[ID RECURSO]

from ATC.dbo.toa_pm
where TIMESTAMP between @fecha1 and @fecha2 and
		alta = 1 and
		[Estado de la Orden] in ('Completado','No Realizada', 'Suspendido')
group by cast (timestamp as date), [ID RECURSO]


-- CONSULTA FINAL 2
merge into Q4s_semanal as destino
using (select recurso,
			COUNT(Fecha) as [Días trabajados]

		from #cumplidas_raw
		group by recurso) as origen

on origen.recurso = destino.id_tecnico and
	destino.fecha1 = @fecha1

when matched then update
set destino.dias_trabajo = origen.[Días trabajados];