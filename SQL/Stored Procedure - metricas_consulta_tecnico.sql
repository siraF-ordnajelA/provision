alter procedure metricas_consulta_tecnico
@fecha varchar(10),
@tecnologia tinyint, --1: CU / 2: FTTH
@id_tecnico smallint

as

declare @fecha_actual date
set @fecha_actual = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--MES AL MES ACTUAL


create table #final_1 (id smallint,
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
				resultado decimal(8,6))

create table #final_2 (id_contrata tinyint,
						id_recurso smallint,
						instalaciones smallint,
						no_realizado smallint,
						suspendido smallint,
						garantias smallint,
						garantias_7d smallint,
						medallias smallint,
						monitoreos smallint,
						dias_trabajados tinyint,
						prom_inst_diarias decimal(4,2),
						metrica_cumplidas decimal(8,6),
						metrica_garantias decimal(8,6),
						metrica_garantias_7d decimal(8,6),
						metrica_monitoreos decimal(8,6),
						metrica_diarias decimal(8,6),
						metrica_citas decimal(8,6),
						metrica_presentismo decimal(8,6),
						resultado decimal(8,6))

create table #g7 (id_contrata tinyint,
					id_recurso smallint,
					garantias_7d smallint)

create table #medallias (id_recurso smallint,
							casos smallint)
											

---------------------- COMIENZO METRICAS ----------------------
insert into #final_1 (id,
					metrica_cumplidas,
					metrica_garantias,
					metrica_garantias_7d,
					metrica_monitoreos,
					metrica_diarias,
					metrica_citas,
					metrica_presentismo,
					ponderado_cumplidas,
					ponderado_garantias,
					ponderado_garantias_7d,
					ponderado_monitoreos,
					ponderado_diarias,
					ponderado_citas,
					ponderado_presentismo)

select id_recurso,
		metrica_cumplidas,
		metrica_garantias,
		metrica_garantias_7d,
		metrica_monitoreos,
		metrica_diarias,
		metrica_citas,
		metrica_presentismo,
		case when metrica_cumplidas >= 1.0833 then 1
				when metrica_cumplidas > 1.0 and metrica_cumplidas < 1.0833 then 0.8
				when metrica_cumplidas >= 0.9833 and metrica_cumplidas <= 1.0 then 0.6
				when metrica_cumplidas >= 0.9167 and metrica_cumplidas < 0.9833 then 0.4
				when metrica_cumplidas < 0.9167 then 0.2 else 0 end as pond_cumplidos,
		case when metrica_garantias >= 1.0104 then 1
				when metrica_garantias >= 1.0031 and metrica_garantias < 1.0104 then 0.8
				when metrica_garantias >= 1.0 and metrica_garantias < 1.0031 then 0.6
				when metrica_garantias >= 0.9896 and metrica_garantias < 1.0 then 0.4
				when metrica_garantias >= 0.9688 and metrica_garantias < 0.9896 then 0.2 else 0 end as pond_garantias,
		case when metrica_garantias_7d > 1.0025 then 1
				when metrica_garantias_7d > 1.0 and metrica_garantias_7d <= 1.0025 then 0.8
				when metrica_garantias_7d > 0.9949 and metrica_garantias_7d <= 1 then 0.6
				when metrica_garantias_7d > 0.9899 and metrica_garantias_7d <= 0.9949 then 0.4
				when metrica_garantias_7d > 0.9798 and metrica_garantias_7d <= 0.9899 then 0.2 else 0 end as pond_garantias_7d,
		case when metrica_monitoreos >= 1.0105 then 1
				when metrica_monitoreos >= 0.9789 and metrica_monitoreos < 1.0105 then 0.8
				when metrica_monitoreos >= 0.9474 and metrica_monitoreos < 0.9789 then 0.6
				when metrica_monitoreos >= 0.8947 and metrica_monitoreos < 0.9474 then 0.4
				when metrica_monitoreos >= 0.8421 and metrica_monitoreos < 0.8947 then 0.2 else 0 end as pond_monitoreos,
		case when metrica_diarias >= 1.15 then 1
				when metrica_diarias >= 1.05 and metrica_diarias < 1.15 then 0.8
				when metrica_diarias >= 0.85 and metrica_diarias < 1.05 then 0.6
				when metrica_diarias >= 0.65 and metrica_diarias < 0.85 then 0.4
				when metrica_diarias >= 0.6 and metrica_diarias < 0.65 then 0.2 else 0 end as pond_productividad,
		case when metrica_citas >= 0.995 then 1
				when metrica_citas >= 0.9648 and metrica_citas < 0.995 then 0.8
				when metrica_citas >= 0.9146 and metrica_citas < 0.9648 then 0.6
				when metrica_citas >= 0.8543 and metrica_citas < 0.9146 then 0.4
				when metrica_citas >= 0.8040 and metrica_citas < 0.8543 then 0.2 else 0 end as pond_citas,
		case when metrica_presentismo >= 1.0556 then 1
				when metrica_presentismo >= 1.0001 and metrica_presentismo < 1.0556 then 0.8
				when metrica_presentismo >= 0.9779 and metrica_presentismo < 1.0001 then 0.6
				when metrica_presentismo >= 0.9223 and metrica_presentismo < 0.9779 then 0.4
				when metrica_presentismo >= 0.8889 and metrica_presentismo < 0.9223 then 0.2 else 0 end as pond_presentismo

from metricas_tecnico
where fecha = @fecha and
		central = 0 and
		tecnologia = @tecnologia and
		id_recurso = @id_tecnico
		
		
IF (datediff(month,@fecha, @fecha_actual) >= 2)
BEGIN
update #final_1
set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO ESTÁ COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5
END

ELSE
BEGIN
update #final_1
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
END


---------------------- COMIENZO DETALLE ----------------------
-- INSERTO DATOS DESDE Q4S_30D
IF (@tecnologia = 2)
BEGIN
insert into #final_2 (id_contrata,
					id_recurso,
					instalaciones,
					no_realizado,
					suspendido,
					garantias,
					monitoreos,
					dias_trabajados,
					prom_inst_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as Instalaciones,
		sum([No Realizado]) as [No realizado],
		sum(Suspendido) as Suspendido,
		sum(garantias) as [Garantías 30D],
		Monitoreos as Monitoreos,
		dias_trabajo as [Días trabajados],
		prom_diarias as [Producción]

from Q4s_30d
where Fecha = @fecha and
		tecnologia <> 'cobre' and
		id_tecnico = @id_tecnico
group by id_contrata,
			id_tecnico,
			Monitoreos,
			dias_trabajo,
			prom_diarias
END

ELSE
BEGIN
insert into #final_2 (id_contrata,
					id_recurso,
					instalaciones,
					no_realizado,
					suspendido,
					garantias,
					monitoreos,
					dias_trabajados,
					prom_inst_diarias)

select id_contrata,
		id_tecnico,
		sum(Instalaciones) as Instalaciones,
		sum([No Realizado]) as [No realizado],
		sum(Suspendido) as Suspendido,
		sum(garantias) as [Garantías 30D],
		Monitoreos as Monitoreos,
		dias_trabajo as [Días trabajados],
		prom_diarias as [Producción]

from Q4s_30d
where Fecha = @fecha and
		tecnologia = 'cobre' and
		id_tecnico = @id_tecnico
group by id_contrata,
			id_tecnico,
			Monitoreos,
			dias_trabajo,
			prom_diarias
END

-- INSERTO GARANTIAS A 7 DIAS
IF (@tecnologia = 2)
BEGIN
insert into #g7(id_contrata,
				id_recurso,
				garantias_7d)

select id_contrata,
		id_tecnico,
		sum(Garantias) as g7

from Q4s_7d
where Fecha = @fecha and
		tecnologia <> 'cobre' and
		id_tecnico = @id_tecnico
group by id_contrata, id_tecnico
END

ELSE
BEGIN
insert into #g7(id_contrata,
				id_recurso,
				garantias_7d)

select id_contrata,
		id_tecnico,
		sum(Garantias) as g7

from Q4s_7d
where Fecha = @fecha and
		tecnologia = 'cobre' and
		id_tecnico = @id_tecnico
group by id_contrata, id_tecnico
END

merge into #final_2 as destino
using (select * from #g7) as origen
on origen.id_contrata = destino.id_contrata and
	origen.id_recurso = destino.id_recurso
	
when matched then update
set destino.garantias_7d = origen.garantias_7d;

--INSERTO MEDALLIAS
insert into #medallias (id_recurso, casos)

select id_recurso,
		count(*) as casos
from lista_medallia_casos
where cast (fecha_mail as date) between @fecha and dateadd(month, 1, @fecha)
group by id_recurso

merge into #final_2 as destino
using (select * from #medallias) as origen
on origen.id_recurso = destino.id_recurso
	
when matched then update
set destino.medallias = origen.casos;

update #final_2
set medallias = 0
where medallias is null

-- MERGE FINAL
merge into #final_2 as destino
using (select * from #final_1) as origen
on destino.id_recurso = origen.id
when matched then
update set
destino.metrica_cumplidas = origen.metrica_cumplidas,
destino.metrica_garantias = origen.metrica_garantias,
destino.metrica_garantias_7d = origen.metrica_garantias_7d,
destino.metrica_monitoreos = origen.metrica_monitoreos,
destino.metrica_diarias = origen.metrica_diarias,
destino.metrica_citas = origen.metrica_citas,
destino.metrica_presentismo = origen.metrica_presentismo,
destino.resultado = origen.resultado;


-- RESULTADOS
select @fecha as fecha,
		b.nombre,
		a.id_recurso,
		b.ctta,
		b.activo,
		instalaciones,
		no_realizado,
		suspendido,
		garantias,
		garantias_7d,
		medallias,
		monitoreos,
		dias_trabajados,
		prom_inst_diarias,
		case when metrica_cumplidas is null then 0 else metrica_cumplidas end as metrica_cumplidas,
		case when metrica_garantias is null then 0 else metrica_garantias end as metrica_garantias,
		case when metrica_garantias_7d is null then 0 else metrica_garantias_7d end as metrica_garantias_7d,
		case when metrica_monitoreos is null then 0 else metrica_monitoreos end as metrica_monitoreos,
		case when metrica_diarias is null then 0 else metrica_diarias end as metrica_diarias,
		case when metrica_citas is null then 0 else metrica_citas end as metrica_citas,
		case when metrica_presentismo is null then 0 else metrica_presentismo end as metrica_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final_2 as a left join tecnicos as b
on a.id_recurso = b.id_tecnico