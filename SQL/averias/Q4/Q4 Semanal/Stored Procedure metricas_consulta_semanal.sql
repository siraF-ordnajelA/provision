alter procedure metricas_consulta_semanal
@fecha varchar(8),
@empresa varchar(150),
@tecnologia tinyint --1: CU / 2: FTTH

as

create table #final (semana tinyint,
				id smallint,
				metrica_cumplidas decimal(8,6),
				metrica_garantias decimal(8,6),
				metrica_garantias_7d decimal(8,6),
				metrica_monitoreos decimal(8,6),
				metrica_diarias decimal(8,6),
				metrica_citas decimal(8,6),
				metrica_presentismo decimal(8,6),
				ponderado_cumplidas decimal(2,1),
				ponderado_garantias decimal(2,1),
				ponderado_garantias_7d decimal(2,1),
				ponderado_monitoreos decimal(2,1),
				ponderado_diarias decimal(2,1),
				ponderado_citas decimal (2,1),
				ponderado_presentismo decimal (2,1),
				resultado decimal(8,6),
				fecha date)


IF (@fecha = '' or @fecha = 0)
BEGIN
insert into #final (semana,
					id,
					metrica_cumplidas,
					--metrica_garantias,
					metrica_garantias_7d,
					--metrica_monitoreos,
					metrica_diarias,
					metrica_citas,
					metrica_presentismo,
					ponderado_cumplidas,
					--ponderado_garantias,
					ponderado_garantias_7d,
					--ponderado_monitoreos,
					ponderado_diarias,
					ponderado_citas,
					ponderado_presentismo,
					fecha)

select Semana,
		id_ctta,
		avg(metrica_cumplidas) as cumplidas,
		avg(metrica_garantias_7d) as garantias_7d,
		avg(metrica_diarias) as diarias,
		avg(metrica_citas) as citas,
		avg(metrica_presentismo) as presentismo,
		
		case when avg(metrica_cumplidas) >= 1.0833 then 1
				when avg(metrica_cumplidas) > 1.0 and avg(metrica_cumplidas) < 1.0833 then 0.8
				when avg(metrica_cumplidas) >= 0.9833 and avg(metrica_cumplidas) <= 1.0 then 0.6
				when avg(metrica_cumplidas) >= 0.9167 and avg(metrica_cumplidas) < 0.9833 then 0.4
				when avg(metrica_cumplidas) < 0.9167 then 0.2 else 0 end as pond_cumplidos,
		/*
		case when metrica_garantias >= 0.9896 then 1
				when metrica_garantias >= 0.9792 and metrica_garantias < 0.9896 then 0.8
				when metrica_garantias >= 0.9688 and metrica_garantias < 0.9792 then 0.6
				when metrica_garantias >= 0.9583 and metrica_garantias < 0.9688 then 0.4
				when metrica_garantias >= 0.9375 and metrica_garantias < 0.9583 then 0.2 else 0 end as pond_garantias,
		*/
		case when avg(metrica_garantias_7d) > 1.0025 then 1
				when avg(metrica_garantias_7d) > 1.0 and avg(metrica_garantias_7d) <= 1.0025 then 0.8
				when avg(metrica_garantias_7d) > 0.9949 and avg(metrica_garantias_7d) <= 1.0 then 0.6
				when avg(metrica_garantias_7d) > 0.9899 and avg(metrica_garantias_7d) <= 0.9949 then 0.4
				when avg(metrica_garantias_7d) > 0.9798 and avg(metrica_garantias_7d) <= 0.9899 then 0.2 else 0 end as pond_garantias_7d,
		/*
		case when metrica_monitoreos >= 1.0105 then 1
				when metrica_monitoreos >= 0.9789 and metrica_monitoreos < 1.0105 then 0.8
				when metrica_monitoreos >= 0.9474 and metrica_monitoreos < 0.9789 then 0.6
				when metrica_monitoreos >= 0.8947 and metrica_monitoreos < 0.9474 then 0.4
				when metrica_monitoreos >= 0.8421 and metrica_monitoreos < 0.8947 then 0.2 else 0 end as pond_monitoreos,
		*/
		case when avg(metrica_diarias) >= 1.15 then 1
				when avg(metrica_diarias) >= 1.05 and avg(metrica_diarias) < 1.15 then 0.8
				when avg(metrica_diarias) >= 0.85 and avg(metrica_diarias) < 1.05 then 0.6
				when avg(metrica_diarias) >= 0.65 and avg(metrica_diarias) < 0.85 then 0.4
				when avg(metrica_diarias) >= 0.6 and avg(metrica_diarias) < 0.65 then 0.2 else 0 end as pond_productividad,
		case when avg(metrica_citas) >= 0.995 then 1
				when avg(metrica_citas) >= 0.9648 and avg(metrica_citas) < 0.995 then 0.8
				when avg(metrica_citas) >= 0.9146 and avg(metrica_citas) < 0.9648 then 0.6
				when avg(metrica_citas) >= 0.8543 and avg(metrica_citas) < 0.9146 then 0.4
				when avg(metrica_citas) >= 0.8040 and avg(metrica_citas) < 0.8543 then 0.2 else 0 end as pond_citas,
		case when avg(metrica_presentismo) >= 1.0556 then 1
				when avg(metrica_presentismo) >= 1.0001 and avg(metrica_presentismo) < 1.0556 then 0.8
				when avg(metrica_presentismo) >= 0.9779 and avg(metrica_presentismo) < 1.0001 then 0.6
				when avg(metrica_presentismo) >= 0.9223 and avg(metrica_presentismo) < 0.9779 then 0.4
				when avg(metrica_presentismo) >= 0.8889 and avg(metrica_presentismo) < 0.9223then 0.2 else 0 end as pond_presentismo,
		fecha1

from metricas_ctta_semanal
where tecnologia = @tecnologia
group by Semana,
			id_ctta,
			fecha1
END

ELSE
BEGIN
insert into #final (semana,
					id,
					metrica_cumplidas,
					--metrica_garantias,
					metrica_garantias_7d,
					--metrica_monitoreos,
					metrica_diarias,
					metrica_citas,
					metrica_presentismo,
					ponderado_cumplidas,
					--ponderado_garantias,
					ponderado_garantias_7d,
					--ponderado_monitoreos,
					ponderado_diarias,
					ponderado_citas,
					ponderado_presentismo,
					fecha)

select Semana,
		id_ctta,
		avg(metrica_cumplidas) as cumplidas,
		avg(metrica_garantias_7d) as garantias_7d,
		avg(metrica_diarias) as diarias,
		avg(metrica_citas) as citas,
		avg(metrica_presentismo) as presentismo,
		
		case when avg(metrica_cumplidas) >= 1.0833 then 1
				when avg(metrica_cumplidas) > 1.0 and avg(metrica_cumplidas) < 1.0833 then 0.8
				when avg(metrica_cumplidas) >= 0.9833 and avg(metrica_cumplidas) <= 1.0 then 0.6
				when avg(metrica_cumplidas) >= 0.9167 and avg(metrica_cumplidas) < 0.9833 then 0.4
				when avg(metrica_cumplidas) < 0.9167 then 0.2 else 0 end as pond_cumplidos,
		/*
		case when metrica_garantias >= 0.9896 then 1
				when metrica_garantias >= 0.9792 and metrica_garantias < 0.9896 then 0.8
				when metrica_garantias >= 0.9688 and metrica_garantias < 0.9792 then 0.6
				when metrica_garantias >= 0.9583 and metrica_garantias < 0.9688 then 0.4
				when metrica_garantias >= 0.9375 and metrica_garantias < 0.9583 then 0.2 else 0 end as pond_garantias,
		*/
		case when avg(metrica_garantias_7d) > 1.0025 then 1
				when avg(metrica_garantias_7d) > 1.0 and avg(metrica_garantias_7d) <= 1.0025 then 0.8
				when avg(metrica_garantias_7d) > 0.9949 and avg(metrica_garantias_7d) <= 1.0 then 0.6
				when avg(metrica_garantias_7d) > 0.9899 and avg(metrica_garantias_7d) <= 0.9949 then 0.4
				when avg(metrica_garantias_7d) > 0.9798 and avg(metrica_garantias_7d) <= 0.9899 then 0.2 else 0 end as pond_garantias_7d,
		/*
		case when metrica_monitoreos >= 1.0105 then 1
				when metrica_monitoreos >= 0.9789 and metrica_monitoreos < 1.0105 then 0.8
				when metrica_monitoreos >= 0.9474 and metrica_monitoreos < 0.9789 then 0.6
				when metrica_monitoreos >= 0.8947 and metrica_monitoreos < 0.9474 then 0.4
				when metrica_monitoreos >= 0.8421 and metrica_monitoreos < 0.8947 then 0.2 else 0 end as pond_monitoreos,
		*/
		case when avg(metrica_diarias) >= 1.15 then 1
				when avg(metrica_diarias) >= 1.05 and avg(metrica_diarias) < 1.15 then 0.8
				when avg(metrica_diarias) >= 0.85 and avg(metrica_diarias) < 1.05 then 0.6
				when avg(metrica_diarias) >= 0.65 and avg(metrica_diarias) < 0.85 then 0.4
				when avg(metrica_diarias) >= 0.6 and avg(metrica_diarias) < 0.65 then 0.2 else 0 end as pond_productividad,
		case when avg(metrica_citas) >= 0.995 then 1
				when avg(metrica_citas) >= 0.9648 and avg(metrica_citas) < 0.995 then 0.8
				when avg(metrica_citas) >= 0.9146 and avg(metrica_citas) < 0.9648 then 0.6
				when avg(metrica_citas) >= 0.8543 and avg(metrica_citas) < 0.9146 then 0.4
				when avg(metrica_citas) >= 0.8040 and avg(metrica_citas) < 0.8543 then 0.2 else 0 end as pond_citas,
		case when avg(metrica_presentismo) >= 1.0556 then 1
				when avg(metrica_presentismo) >= 1.0001 and avg(metrica_presentismo) < 1.0556 then 0.8
				when avg(metrica_presentismo) >= 0.9779 and avg(metrica_presentismo) < 1.0001 then 0.6
				when avg(metrica_presentismo) >= 0.9223 and avg(metrica_presentismo) < 0.9779 then 0.4
				when avg(metrica_presentismo) >= 0.8889 and avg(metrica_presentismo) < 0.9223then 0.2 else 0 end as pond_presentismo,
		fecha

from metricas_ctta_semanal_his
where DATEPART(month, fecha) = DATEPART(month, @fecha) and
		DATEPART(year, fecha) = DATEPART(year, @fecha) and
		tecnologia = @tecnologia
group by Semana,
			id_ctta,
			fecha
END

update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5

-- RESULTADOS
select 'Semana ' + cast(a.semana as varchar(1)) as semana,
		b.descripcion_contrata,
		a.metrica_cumplidas,
		--a.metrica_garantias,
		a.metrica_garantias_7d,
		--a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.metrica_presentismo,
		a.ponderado_cumplidas,
		--a.ponderado_garantias,
		a.ponderado_garantias_7d,
		--a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno,
		cast(a.fecha as varchar(11)) as fecha,
		b.color

from #final as a left join contratas as b
on a.id = b.id_contrata
where b.descripcion_contrata = @empresa
order by a.Semana, b.descripcion_contrata
--END