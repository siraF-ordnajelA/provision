alter procedure metricas_inserta_tecnico
@opcion tinyint

as

create table #totales(id_ctta smallint, id_tecnico int, cent_id smallint, cant_cumplidas int, cant_informadas int, cant_garantias int, cant_garantias_7d int, ef_cita decimal(8,6), porc_monitoreos decimal(8,6), promd_diarias decimal(9,6), dias_trabajados tinyint)
declare @fecha1 date, @dias_habiles tinyint

--Metrica completa
IF(@opcion = 1)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL
END
--Metrica incompleta
ELSE IF (@opcion = 2)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
END
--Metrica mes actual
ELSE IF (@opcion = 3)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--MES ACTUAL
END

--ELIMINA MES SEGUN @OPCION (1 = Mes completo - 2 = Mes anterior - 3 = Mes actual)
delete from metricas_tecnico
where Fecha = @fecha1

-- SUMA TOTALES POR CONTRATISTA (FTTH)(CENTRAL)
insert into #totales(id_ctta, id_tecnico, cent_id, cant_cumplidas, cant_informadas, cant_garantias, /*cant_garantias_7d,*/ porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		central,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias) as tot_garantias,
		--(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and Fecha = @fecha1 and tecnologia <> 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_30d
where fecha = @fecha1 and
		tecnologia <> 'cobre'
group by id_contrata, id_tecnico, central

-- Pego garantías a 7 días
merge into #totales as destino
using (select id_contrata,
			id_tecnico,
			central,
			sum(Garantias) as garantias_7d
		from Q4s_7d
		where Fecha = @fecha1 and tecnologia <> 'cobre'
		group by id_contrata, id_tecnico, central) as origen

on destino.id_ctta = origen.id_contrata and
	destino.id_tecnico = origen.id_tecnico and
	destino.cent_id = origen.central

when matched then update set
destino.cant_garantias_7d = origen.garantias_7d;

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				cent_id,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.periodo = replace(cast (@fecha1 as varchar(7)), '-', '') and
				a.empresa <> '' and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico, cent_id) as origen

on destino.id_tecnico = origen.id_tecnico and
	destino.cent_id = origen.cent_id

when matched then update set
destino.ef_cita = origen.EF_CITA;


-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)(CENTRAL)
insert into metricas_tecnico (Fecha, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, central, tecnologia)

select @fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6)end as citas,
		cent_id,
		2 --FTTH

from #totales




-- SUMA TOTALES POR CONTRATISTA (FTTH)(TOTAL)
truncate table #totales

insert into #totales(id_ctta, id_tecnico, cent_id, cant_cumplidas, cant_informadas, cant_garantias, /*cant_garantias_7d,*/ porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		0,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias) as tot_garantias,
		--(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and Fecha = @fecha1 and tecnologia <> 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_30d
where fecha = @fecha1 and
		tecnologia <> 'cobre'
group by id_contrata, id_tecnico

-- Pego garantías a 7 días
merge into #totales as destino
using (select id_contrata,
			id_tecnico,
			sum(Garantias) as garantias_7d
		from Q4s_7d
		where Fecha = @fecha1 and tecnologia <> 'cobre'
		group by id_contrata, id_tecnico) as origen

on destino.id_ctta = origen.id_contrata and
	destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_garantias_7d = origen.garantias_7d;

-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.periodo = replace(cast (@fecha1 as varchar(7)), '-', '') and
				a.empresa <> '' and
				a.tecnologia <> 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;


-- INSERTA METRICAS SEGUN OBJETIVOS (FTTH)(TOTAL)
insert into metricas_tecnico (Fecha, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, central, tecnologia)

select @fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6)end as citas,
		0,
		2 --FTTH

from #totales




-----------------------------------------------------------------------------------

-- SUMA TOTALES POR CONTRATISTA (CU)(CENTRAL)
truncate table #totales


insert into #totales(id_ctta, id_tecnico, cent_id, cant_cumplidas, cant_informadas, cant_garantias, /*cant_garantias_7d,*/ porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		central,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias) as tot_garantias,
		--(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and Fecha = @fecha1 and tecnologia = 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_30d
where fecha = @fecha1 and
		tecnologia = 'cobre'
group by id_contrata, id_tecnico, central

-- Pego garantías a 7 días
merge into #totales as destino
using (select id_contrata,
			id_tecnico,
			central,
			sum(Garantias) as garantias_7d
		from Q4s_7d
		where Fecha = @fecha1 and tecnologia = 'cobre'
		group by id_contrata, id_tecnico, central) as origen

on destino.id_ctta = origen.id_contrata and
	destino.id_tecnico = origen.id_tecnico and
	destino.cent_id = origen.central

when matched then update set
destino.cant_garantias_7d = origen.garantias_7d;


-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				cent_id,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.periodo = replace(cast (@fecha1 as varchar(7)), '-', '') and
				a.empresa <> '' and
				a.tecnologia = 'cobre'
		group by b.id_tecnico, cent_id) as origen

on destino.id_tecnico = origen.id_tecnico and
	destino.cent_id = origen.cent_id

when matched then update set
destino.ef_cita = origen.EF_CITA;


-- INSERTA METRICAS SEGUN OBJETIVOS (CU)(CENTRAL)
insert into metricas_tecnico (Fecha, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, central, tecnologia)

select @fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) end as citas,
		cent_id,
		1 --CU

from #totales




-- SUMA TOTALES POR CONTRATISTA (CU)(TOTAL)
truncate table #totales


insert into #totales(id_ctta, id_tecnico, cent_id, cant_cumplidas, cant_informadas, cant_garantias, /*cant_garantias_7d,*/ porc_monitoreos, promd_diarias)

select id_contrata,
		id_tecnico,
		0,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias) as tot_garantias,
		--(select sum(Garantias) from Q4s_7d where id_tecnico = Q4s_30d.id_tecnico and Fecha = @fecha1 and tecnologia = 'cobre' group by id_contrata, id_tecnico) as tot_garantias_7d,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_30d
where fecha = @fecha1 and
		tecnologia = 'cobre'
group by id_contrata, id_tecnico

-- Pego garantías a 7 días
merge into #totales as destino
using (select id_contrata,
			id_tecnico,
			sum(Garantias) as garantias_7d
		from Q4s_7d
		where Fecha = @fecha1 and tecnologia = 'cobre'
		group by id_contrata, id_tecnico) as origen

on destino.id_ctta = origen.id_contrata and
	destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.cant_garantias_7d = origen.garantias_7d;


-- Efectividad Citas
merge into #totales as destino
using (select b.id_tecnico,
				1-(cast (sum(Q_INC) as float) / cast (sum(T) as float)) as EF_CITA
				
		from ATC.dbo.toa_reporte_ef_citas as a left join tecnicos as b
		on a.técnico = b.nombre
		where a.periodo = replace(cast (@fecha1 as varchar(7)), '-', '') and
				a.empresa <> '' and
				a.tecnologia = 'cobre'
		group by b.id_tecnico) as origen

on destino.id_tecnico = origen.id_tecnico

when matched then update set
destino.ef_cita = origen.EF_CITA;


-- INSERTA METRICAS SEGUN OBJETIVOS (CU)(TOTAL)
insert into metricas_tecnico (Fecha, id_ctta, id_recurso, metrica_cumplidas, metrica_garantias, metrica_garantias_7d, metrica_monitoreos, metrica_diarias, metrica_citas, central, tecnologia)

select @fecha1,
		id_ctta,
		id_tecnico,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / (select objetivo_cumplidos from metricas_objetivos where fecha = '20211001'), 6) as cumplidas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias from metricas_objetivos where fecha = '20211001'), 6) as garantias,
		round((1 - (cast(cant_garantias_7d as float) / cast(cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6) as garantias_7d,
		porc_monitoreos / (select objetivo_monitoreos from metricas_objetivos where fecha = '20211001') as monitoreos,
		promd_diarias / (select objetivo_productividad from metricas_objetivos where fecha = '20211001') as productividad,
		case when round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) is null then 0
				else round (ef_cita / (select objetivo_citas from metricas_objetivos where fecha = '20211001'), 6) end as citas,
		0,
		1 --CU

from #totales




-----------------------------------------------------------------------------------

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
		round(avg(cast(dias_trabajo as float)), 2) as prom_dias_trabajados
from Q4s_30d
where Fecha = @fecha1
group by id_tecnico--, dias_trabajo


-- Inserta metrica para COBRE y FIBRA
UPDATE metricas_tecnico
SET metrica_presentismo = tabla2agregada.campo1agregado
FROM metricas_tecnico as t1 
     JOIN (SELECT id_tecnico, (dias_trabajados / cast(@dias_habiles as float)) / (select objetivo_presentismo from metricas_objetivos where fecha = '20211001') as campo1agregado
            FROM #totales
            GROUP BY id_tecnico, dias_trabajados) as  tabla2agregada
     ON t1.Fecha = @fecha1 and
		t1.id_recurso = tabla2agregada.id_tecnico