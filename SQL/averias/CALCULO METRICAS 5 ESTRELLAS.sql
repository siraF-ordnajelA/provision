-- 1ro se debe importar efectividad de cita desde:
-- exec [TE101104\PROVISIONSERVER].CPP.importa_efectividad_cita

declare @fecha1 varchar(8)
declare @tecno varchar(8)

set @fecha1 = '20210801'
set @tecno = 'cobre'

-- OBJETIVOS
declare @objetivo_productividad tinyint,
		--@objetivo_informados decimal(3,2),
		@objetivo_cumplidos decimal(3,2),
		@objetivo_garantias decimal(3,2),
		@objetivo_monitoreos decimal(3,2),
		@objetivo_citas decimal(4,3)

set @objetivo_productividad = 2 -- Objetivo 2 por día
--set @objetivo_informados = 0.4 -- Objetivo Menos del 40% de informes
set @objetivo_cumplidos = 0.6 -- Objetivo Más del 60% cumplidos
set @objetivo_garantias = 1 - 0.04 -- Objetivo Menos del 4% (Debe ser la inversa para el cálculo)
set @objetivo_monitoreos = 0.95 -- Objetivo Más del 95% monitoreados
set @objetivo_citas = 0.995 -- Objetivo Más del 99,5% citados

-- PESOS (Mismo peso para todas las métricas)
declare @peso_productividad decimal(3,2),
		--@peso_informados decimal(3,2),
		@peso_cumplidos decimal(3,2),
		@peso_garantias decimal(3,2),
		@peso_monitoreos decimal(3,2),
		@peso_efectividad_cita decimal(3,2),
		@total_metricas_sin_monitoreos tinyint

set @peso_productividad = 0.2
--set @peso_informados = 0.17
set @peso_cumplidos = 0.2
set @peso_garantias = 0.2
set @peso_monitoreos = 0.2
set @peso_efectividad_cita = 0.2
set @total_metricas_sin_monitoreos = 4


-- SUMA TOTALES POR CONTRATISTA
create table #totales(id_contrata smallint, cant_cumplidas int, cant_informadas int, cant_garantias int, cant_citados smallint, cant_no_cumplidos smallint, cant_cumplidos smallint, porc_monitoreos decimal(8,6), promd_diarias decimal(8,6))


insert into #totales(id_contrata, cant_cumplidas, cant_informadas, cant_garantias, porc_monitoreos, promd_diarias)

select id_contrata,
		sum(Instalaciones) as tot_instalaciones,
		sum([No Realizado]) + sum(Suspendido) as tot_informadas,
		sum(Garantias) as tot_garantias,
		--sum([Monitoreos]) as Monitoreos,
		--sum([Monitoreos Apto]) as Aptos,
		case when sum(Monitoreos) = 0 then 0
				else round(cast(sum([Monitoreos Apto]) as float) / cast(sum(Monitoreos) as float), 6) end as metrica_monitoreos,
		round(avg(prom_diarias), 6) as promedio_diarias

from Q4s_30d
where fecha = @fecha1 and
		tecnologia <> @tecno
group by id_contrata

-- Citas
merge into #totales as destino
using (select b.id_contrata,
				sum(a.citado) as citado,
				sum(a.no_cumplido) as no_cumplido,
				sum(a.cumplido) as cumplido

		from efectividad_cita as a left join contratas as b
		on a.ctta = b.descripcion_contrata
		where a.Fecha = @fecha1 and
				a.ctta is not null and
				a.tecnologia <> @tecno
		group by b.id_contrata) as origen

on destino.id_contrata = origen.id_contrata

when matched then update set
destino.cant_citados = origen.citado,
destino.cant_no_cumplidos = origen.no_cumplido,
destino.cant_cumplidos = origen.cumplido;


-- CALCULO METRICAS SEGUN OBJETIVOS
create table #metricas(id_contrata smallint,
						metrica_cumplidas decimal(7,6),
						--metrica_informadas decimal(7,6),
						metrica_garantias decimal(7,6),
						metrica_monitoreos decimal(7,6),
						metrica_diarias decimal(7,6),
						metrica_citas decimal(7,6))


insert into #metricas (id_contrata, metrica_cumplidas, /*metrica_informadas,*/ metrica_garantias, metrica_monitoreos, metrica_diarias, metrica_citas)

select id_contrata,
		round((cast (cant_cumplidas as float) / cast((cant_cumplidas + cant_informadas) as float)) / @objetivo_cumplidos, 6) as cumplidas,
		--round((cast (cant_informadas as float) / cast((cant_cumplidas + cant_informadas) as float)) / @objetivo_informados, 6) as informadas,
		round((1 - (cast(cant_garantias as float) / cast(cant_cumplidas as float))) / @objetivo_garantias, 6) as garantias,
		porc_monitoreos / @objetivo_monitoreos as monitoreos,
		promd_diarias / @objetivo_productividad as productividad,
		round ((cast (cant_cumplidos as float) / cast (cant_citados as float)) / @objetivo_citas, 6) as citas

from #totales


-- CALULO METRICAS FINAL
create table #final (id_contrata smallint,
				ponderado_cumplidas decimal(7,6),
				--ponderado_informadas decimal(7,6),
				ponderado_garantias decimal(7,6),
				ponderado_monitoreos decimal(7,6),
				ponderado_diarias decimal(7,6),
				ponderado_citas decimal (7,6),
				resultado decimal(7,6))


insert into #final (id_contrata, ponderado_cumplidas, /*ponderado_informadas,*/ ponderado_garantias, ponderado_monitoreos, ponderado_diarias, ponderado_citas)

select id_contrata,
		case when metrica_monitoreos > 0 then metrica_cumplidas * @peso_cumplidos
				else metrica_cumplidas * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_cumplidos,
		--metrica_informadas * @peso_informados as pond_informados,
		case when metrica_monitoreos > 0 then metrica_garantias * @peso_garantias
				else metrica_garantias * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_garantias,
		metrica_monitoreos * @peso_monitoreos as pond_monitoreos,
		case when metrica_monitoreos > 0 then metrica_diarias * @peso_productividad
				else metrica_diarias * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_productividad,
		case when metrica_monitoreos > 0 then metrica_citas * @peso_efectividad_cita
				else metrica_citas * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_citas

from #metricas

update #final
set resultado = ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas

-- RESULTADOS
--select * from #totales
--select * from #metricas
-- PESOS (Mismo peso para todas las métricas)

select @fecha1 as fecha,
		b.descripcion_contrata,
		a.ponderado_cumplidas,
		--a.ponderado_informadas,
		a.ponderado_garantias,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.resultado,
		a.resultado * 5 as [5 Estrellas],
		'ftth' as tecno

from #final as a left join contratas as b
on a.id_contrata = b.id_contrata