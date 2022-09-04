declare @fecha1 date, @dias_habiles tinyint
set @fecha1 = '20210601'--select cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL


-- SUMA TOTALES POR CONTRATISTA (FTTH)
create table #totales(id_ctta smallint, id_tecnico int, cant_cumplidas int, cant_informadas int, cant_garantias int, cant_garantias_7d int, cant_citados smallint, cant_no_cumplidos smallint, cant_cumplidos smallint, porc_monitoreos decimal(8,6), promd_diarias decimal(8,6), dias_trabajados tinyint)


insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_garantias_7d)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and Fecha = '20210601' and id_contrata = Q4s_30d.id_contrata and tecnologia <> 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d

from Q4s_30d
where fecha = '20210601' and
		tecnologia <> 'cobre'
group by id_contrata, id_tecnico


-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)
merge into metricas_tecnico as destino
using (select id_ctta,
				id_tecnico,
				round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d
		from #totales) as origen
		
on destino.Fecha = @fecha1 and
	destino.tecnologia = 2 and
	destino.id_ctta = origen.id_ctta and
	destino.id_recurso = origen.id_tecnico

when matched then update set
destino.metrica_garantias_7d = origen.garantias_7d;

-----------------------------------------------------------------------------------

-- SUMA TOTALES POR CONTRATISTA (CU)
truncate table #totales


insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_garantias_7d)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and id_contrata = Q4s_30d.id_contrata and Fecha = @fecha1 and tecnologia = 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d

from Q4s_30d
where fecha = @fecha1 and
		tecnologia = 'cobre'
group by id_contrata, id_tecnico


-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)
merge into metricas_tecnico as destino
using (select id_ctta,
				id_tecnico,
				round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d
		from #totales) as origen
		
on destino.Fecha = @fecha1 and
	destino.tecnologia = 1 and
	destino.id_ctta = origen.id_ctta and
	destino.id_recurso = origen.id_tecnico

when matched then update set
destino.metrica_garantias_7d = origen.garantias_7d;


-- INSERTA PRESENTISMO (COBRE/FIBRA)
create table #dias_habiles (dias date)

insert into #dias_habiles (dias)

select cast(dia as date) from ATC.dbo.toa_pm
where periodo = (select replace(cast(@fecha1 as varchar(7)),'-','')) and
		alta = 1 and
		--tecnologia like 'fibra%' and
		[ESTADO DE LA ORDEN] in ('Completado','No Realizada', 'Suspendido')
group by dia having sum(1) > 100 --Me setea que se hayan trabajado más de 100 órdenes por día

set @dias_habiles = (select count(dias) from #dias_habiles)

-- Promedio días trabajados
truncate table #totales

insert into #totales (id_tecnico, dias_trabajados)

select id_tecnico,
		dias_trabajo
from Q4s_30d
where Fecha = @fecha1
group by id_tecnico, dias_trabajo

-- Inserta metrica para COBRE
merge into metricas_tecnico as destino
using (select * from #totales) as origen

on destino.Fecha = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 1

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');

-- Inserta metrica para FIBRA
merge into metricas_tecnico as destino
using (select * from #totales) as origen

on destino.Fecha = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 2

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');