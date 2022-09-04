alter procedure metricas_inserta_tecnico_semanal

as

declare @fecha date, @fecha1 date, @fecha2 date, @dias_habiles tinyint

set @fecha = cast(getdate() as date)

-- 2 SEMANAS
set @fecha1 = (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-8)) -- 2 SEMANAS ATRAS
set @fecha2 = dateadd(day, 1, (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-2))) -- 1 SEMANA ATRAS


-- SUMA TOTALES POR CONTRATISTA (FTTH)
create table #totales(id_ctta smallint, id_tecnico int, cant_cumplidas int, cant_informadas int, cant_garantias int, cant_garantias_7d int, ef_cita decimal(8,6), porc_monitoreos decimal(8,6), promd_diarias decimal(9,6), dias_trabajados tinyint)


insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_informadas, cant_garantias, cant_garantias_7d, porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias_30d) as tot_garantias,
		sum(Garantias_7d) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_semanal
where fecha1 = @fecha1 and
		tecnologia <> 'cobre'
group by id_contrata, id_tecnico

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.dia between @fecha1 and @fecha2 and
				a.empresa <> '' and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;
/*
merge into #totales as destino
using (select b.id_tecnico,
				sum(a.citado) as citado,
				sum(a.no_cumplido) as no_cumplido,
				sum(a.cumplido) as cumplido

		from efectividad_cita as a left join tecnicos as b
		on a.tecnico = b.nombre
		where a.Fecha = @fecha1 and
				a.tecnico is not null and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_citados = origen.citado,
destino.cant_no_cumplidos = origen.no_cumplido,
destino.cant_cumplidos = origen.cumplido;
*/

-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)
insert into metricas_tecnico_semanal (Semana, fecha1, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, tecnologia)

select (select top 1 Semana from Q4s_semanal where fecha1 = @fecha1),
		@fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6)end as citas,
		2 --FTTH

from #totales

-----------------------------------------------------------------------------------

-- SUMA TOTALES POR CONTRATISTA (CU)
truncate table #totales


insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_informadas, cant_garantias, cant_garantias_7d, porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias_30d) as tot_garantias,
		sum(Garantias_7d) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_semanal
where fecha1 = @fecha1 and
		tecnologia = 'cobre'
group by id_contrata, id_tecnico

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.dia between @fecha1 and @fecha2 and
				a.empresa <> '' and
				a.tecnologia = 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;
/*
merge into #totales as destino
using (select b.id_tecnico,
				sum(a.citado) as citado,
				sum(a.no_cumplido) as no_cumplido,
				sum(a.cumplido) as cumplido

		from efectividad_cita as a left join tecnicos as b
		on a.tecnico = b.nombre
		where a.Fecha = @fecha1 and
				a.tecnico is not null and
				a.tecnologia = 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_citados = origen.citado,
destino.cant_no_cumplidos = origen.no_cumplido,
destino.cant_cumplidos = origen.cumplido;
*/

-- INSERTA METRICAS SEGUN OBJETIVOS (CU)
insert into metricas_tecnico_semanal (Semana, fecha1, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, tecnologia)

select (select top 1 Semana from Q4s_semanal where fecha1 = @fecha1),
		@fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) end as citas,
		1 --CU

from #totales


-- INSERTA PRESENTISMO (COBRE/FIBRA)
create table #dias_habiles (dias date)

insert into #dias_habiles (dias)

select cast(dia as date) from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
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
from Q4s_semanal
where fecha1 = @fecha1
group by id_tecnico, dias_trabajo

-- Inserta metrica para COBRE
merge into metricas_tecnico_semanal as destino
using (select * from #totales) as origen

on destino.fecha1 = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 1

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');

-- Inserta metrica para FIBRA
merge into metricas_tecnico_semanal as destino
using (select * from #totales) as origen

on destino.fecha1 = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 2

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');




-- 1 SEMANA
set @fecha1 = DATEADD(day,7,@fecha1)
set @fecha2 = DATEADD(day,7,@fecha2)

truncate table #totales
truncate table #dias_habiles

-- SUMA TOTALES POR CONTRATISTA (FTTH)
insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_informadas, cant_garantias, cant_garantias_7d, porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias_30d) as tot_garantias,
		sum(Garantias_7d) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_semanal
where fecha1 = @fecha1 and
		tecnologia <> 'cobre'
group by id_contrata, id_tecnico

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.dia between @fecha1 and @fecha2 and
				a.empresa <> '' and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;
/*
merge into #totales as destino
using (select b.id_tecnico,
				sum(a.citado) as citado,
				sum(a.no_cumplido) as no_cumplido,
				sum(a.cumplido) as cumplido

		from efectividad_cita as a left join tecnicos as b
		on a.tecnico = b.nombre
		where a.Fecha = @fecha1 and
				a.tecnico is not null and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_citados = origen.citado,
destino.cant_no_cumplidos = origen.no_cumplido,
destino.cant_cumplidos = origen.cumplido;
*/

-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)
insert into metricas_tecnico_semanal (Semana, fecha1, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, tecnologia)

select (select top 1 Semana from Q4s_semanal where fecha1 = @fecha1),
		@fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6)end as citas,
		2 --FTTH

from #totales

-----------------------------------------------------------------------------------

-- SUMA TOTALES POR CONTRATISTA (CU)
truncate table #totales


insert into #totales(id_ctta, id_tecnico, cant_cumplidas, cant_informadas, cant_garantias, cant_garantias_7d, porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias_30d) as tot_garantias,
		sum(Garantias_7d) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_semanal
where fecha1 = @fecha1 and
		tecnologia = 'cobre'
group by id_contrata, id_tecnico

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.dia between @fecha1 and @fecha2 and
				a.empresa <> '' and
				a.tecnologia = 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;
/*
merge into #totales as destino
using (select b.id_tecnico,
				sum(a.citado) as citado,
				sum(a.no_cumplido) as no_cumplido,
				sum(a.cumplido) as cumplido

		from efectividad_cita as a left join tecnicos as b
		on a.tecnico = b.nombre
		where a.Fecha = @fecha1 and
				a.tecnico is not null and
				a.tecnologia = 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_citados = origen.citado,
destino.cant_no_cumplidos = origen.no_cumplido,
destino.cant_cumplidos = origen.cumplido;
*/

-- INSERTA METRICAS SEGUN OBJETIVOS (CU)
insert into metricas_tecnico_semanal (Semana, fecha1, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, tecnologia)

select (select top 1 Semana from Q4s_semanal where fecha1 = @fecha1),
		@fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) end as citas,
		1 --CU

from #totales


-- INSERTA PRESENTISMO (COBRE/FIBRA)
insert into #dias_habiles (dias)

select cast(dia as date) from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
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
from Q4s_semanal
where fecha1 = @fecha1
group by id_tecnico, dias_trabajo

-- Inserta metrica para COBRE
merge into metricas_tecnico_semanal as destino
using (select * from #totales) as origen

on destino.fecha1 = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 1

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');

-- Inserta metrica para FIBRA
merge into metricas_tecnico_semanal as destino
using (select * from #totales) as origen

on destino.fecha1 = @fecha1 and
	destino.id_recurso = origen.id_tecnico and
	destino.tecnologia = 2

when matched then update set
destino.metrica_presentismo = (origen.dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001');