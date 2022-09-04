-- PESOS (Mismo peso para todas las métricas)
declare @peso_productividad decimal(3,2),
		@peso_cumplidos decimal(3,2),
		@peso_garantias decimal(3,2),
		@peso_monitoreos decimal(3,2),
		@peso_efectividad_cita decimal(3,2),
		@total_metricas_sin_monitoreos tinyint

set @peso_productividad = 0.2
set @peso_cumplidos = 0.2
set @peso_garantias = 0.2
set @peso_monitoreos = 0.2
set @peso_efectividad_cita = 0.2
set @total_metricas_sin_monitoreos = 4

create table #final (id_ctta tinyint,
				id_tec smallint,
				metrica_cumplidas decimal(8,6),
				metrica_garantias decimal(8,6),
				metrica_monitoreos decimal(8,6),
				metrica_diarias decimal(8,6),
				metrica_citas decimal (8,6),
				ponderado_cumplidas decimal(8,6),
				ponderado_garantias decimal(8,6),
				ponderado_monitoreos decimal(8,6),
				ponderado_diarias decimal(8,6),
				ponderado_citas decimal (8,6),
				resultado decimal(8,6),
				tecno tinyint)

insert into #final (id_ctta,
		id_tec,
		metrica_cumplidas,
		metrica_garantias,
		metrica_monitoreos,
		metrica_diarias,
		metrica_citas,
		ponderado_cumplidas,
		ponderado_garantias,
		ponderado_monitoreos,
		ponderado_diarias,
		ponderado_citas,
		tecno)

select id_ctta,
		id_recurso,
		metrica_cumplidas,
		metrica_garantias,
		metrica_monitoreos,
		metrica_diarias,
		metrica_citas,
		case when metrica_monitoreos > 0 then metrica_cumplidas * @peso_cumplidos
				else metrica_cumplidas * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_cumplidos,
		case when metrica_monitoreos > 0 then metrica_garantias * @peso_garantias
				else metrica_garantias * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_garantias,
		metrica_monitoreos * @peso_monitoreos as pond_monitoreos,
		case when metrica_monitoreos > 0 then metrica_diarias * @peso_productividad
				else metrica_diarias * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_productividad,
		case when metrica_monitoreos > 0 then metrica_citas * @peso_efectividad_cita
				else metrica_citas * (cast(1 as float)/@total_metricas_sin_monitoreos) end as pond_citas,
		tecnologia

from metricas_tecnico

update #final
set resultado = ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas

-- RESULTADOS
select c.descripcion_contrata as EMPRESA,
		b.nombre as TECNICO,
		LEFT(ROUND(a.metrica_cumplidas, 2), 4) as Metrica_Cumplidas,
		LEFT(ROUND(a.metrica_garantias, 2), 4) as Metrica_Garantias,
		LEFT(ROUND(a.metrica_monitoreos, 2), 4) as Metrica_Monitoreos,
		LEFT(ROUND(a.metrica_diarias, 2), 4) as Metrica_Diarias,
		LEFT(ROUND(a.metrica_citas, 2), 4) as Metrica_Citas,
		--a.ponderado_garantias,
		--a.ponderado_monitoreos,
		--a.ponderado_diarias,
		--a.ponderado_citas,
		LEFT(ROUND(a.resultado, 2), 4) as Resultado,
		LEFT(ROUND(a.resultado * 5, 2), 4) as [5 Estrellas],
		case when tecno = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join tecnicos as b
on a.id_tec = b.id_tecnico left join contratas as c
on a.id_ctta = c.id_contrata
order by c.descripcion_contrata, b.nombre


/*
select b.descripcion_contrata,
		c.nombre,
		LEFT(ROUND(a.metrica_cumplidas, 2), 4) as Metrica_Cumplidas,
		LEFT(ROUND(a.metrica_garantias, 2), 4) as Metrica_Garantias,
		LEFT(ROUND(a.metrica_monitoreos, 2), 4) as Metrica_Monitoreos,
		LEFT(ROUND(a.metrica_diarias, 2), 4) as Metrica_Diarias,
		LEFT(ROUND(a.metrica_citas, 2), 4) as Metrica_Citas,
		case when tecnologia = 1 then 'COBRE' else 'FTTH' end as Tecnologia

from metricas_tecnico as a left join contratas as b
on a.id_ctta = b.id_contrata left join tecnicos as c
on a.id_recurso = c.id_tecnico
order by b.descripcion_contrata, c.nombre
*/