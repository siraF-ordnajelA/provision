alter procedure metricas_consulta
@fecha varchar(10),
@opc tinyint, --1: CTTA / 2: TECNICO
@tecnologia tinyint, --1: CU / 2: FTTH
@empresa varchar(150)

as

-- VARIABLES
declare @fecha_actual date,
		@id_contrata tinyint

set @fecha_actual = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--MES AL MES ACTUAL

create table #final (id smallint,
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




-- METRICAS POR CONTRATA (GLOBAL SIN FECHA)
IF (@opc = 1 and @empresa = 'TASA' and @fecha = '')
BEGIN
insert into #final (id,
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

select id_ctta,
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

from metricas_ctta
where fecha = @fecha_actual and
		central = 0 and
		tecnologia = @tecnologia

update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5

-- RESULTADOS
select @fecha_actual as fecha,
		b.descripcion_contrata,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_garantias_7d,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join contratas as b
on a.id = b.id_contrata
order by a.resultado desc
END




-- METRICAS POR CONTRATA (GLOBAL CON FECHA)
IF (@opc = 1 and @empresa = 'TASA' and @fecha <> '')
BEGIN
insert into #final (id,
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

select id_ctta,
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

from metricas_ctta
where fecha = @fecha and
		central = 0 and
		tecnologia = @tecnologia

IF (datediff(month,@fecha, @fecha_actual) >= 2)
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5
END
ELSE
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
END

-- RESULTADOS
select @fecha as fecha,
		b.descripcion_contrata,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_garantias_7d,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		--a.resultado * 5 as [5 Estrellas],
		case when c.valor is null then a.resultado * 5
			else (a.resultado * 5) + c.valor end as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join contratas as b
on a.id = b.id_contrata left join metricas_manuales as c
on a.id = c.id_contrata and
	c.Fecha = @fecha
order by a.resultado desc
END




-- METRICAS POR CONTRATA (EMPRESA SIN FECHA)
ELSE IF (@opc = 1 and @empresa <> 'TASA'  and @fecha = '')
BEGIN
insert into #final (id,
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

select id_ctta,
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

from metricas_ctta
where fecha = @fecha_actual and
		central = 0 and
		tecnologia = @tecnologia


update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5


-- RESULTADOS
select @fecha_actual as fecha,
		b.descripcion_contrata,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_garantias_7d,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join contratas as b
on a.id = b.id_contrata
where b.descripcion_contrata = @empresa
END




-- METRICAS POR CONTRATA (EMPRESA CON FECHA)
ELSE IF (@opc = 1 and @empresa <> 'TASA'  and @fecha <> '')
BEGIN
insert into #final (id,
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

select id_ctta,
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

from metricas_ctta
where fecha = @fecha and
		central = 0 and
		tecnologia = @tecnologia

IF (datediff(month,@fecha, @fecha_actual) >= 2)
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5
END
ELSE
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
END

-- RESULTADOS
select @fecha as fecha,
		b.descripcion_contrata,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_garantias_7d,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		--a.resultado * 5 as [5 Estrellas],
		case when c.valor is null then a.resultado * 5
			else (a.resultado * 5) + c.valor end as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join contratas as b
on a.id = b.id_contrata left join metricas_manuales as c
on a.id = c.id_contrata and
	c.Fecha = @fecha
where b.descripcion_contrata = @empresa
END



--------------------------------------------------------------------------------------

-- METRICAS POR TECNICO (SIN FECHA)
ELSE IF (@opc = 2 and @fecha = '')
BEGIN
set @id_contrata = (select id_contrata from contratas where descripcion_contrata = @empresa)

insert into #final (id,
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
where fecha = @fecha_actual and
		central = 0 and
		tecnologia = @tecnologia and
		id_ctta = @id_contrata

update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5

-- RESULTADOS
select @fecha_actual as fecha,
		b.nombre,
		case when metrica_cumplidas is null then 0 else metrica_cumplidas end as metrica_cumplidas,
		case when metrica_garantias is null then 0 else metrica_garantias end as metrica_garantias,
		case when metrica_garantias_7d is null then 0 else metrica_garantias_7d end as metrica_garantias_7d,
		case when metrica_monitoreos is null then 0 else metrica_monitoreos end as metrica_monitoreos,
		case when metrica_diarias is null then 0 else metrica_diarias end as metrica_diarias,
		case when metrica_citas is null then 0 else metrica_citas end as metrica_citas,
		case when metrica_presentismo is null then 0 else metrica_presentismo end as metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join tecnicos as b
on a.id = b.id_tecnico
order by a.resultado desc
END

-- METRICAS POR TECNICO (CON FECHA)
ELSE IF (@opc = 2 and @fecha <> '')
BEGIN
set @id_contrata = (select id_contrata from contratas where descripcion_contrata = @empresa)

insert into #final (id,
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
		id_ctta = @id_contrata

IF (datediff(month,@fecha, @fecha_actual) >= 2)
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6 "A PEDIDO DE GERMAN SE QUITA DEL POLINOMIO LAS GARANTIAS A 30 DIAS SI EL MES NO EST� COMPLETO" (18 DE ABRIL)
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5
END
ELSE
BEGIN
update #final
set resultado = (ponderado_cumplidas + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 5
END

-- RESULTADOS
select @fecha as fecha,
		b.nombre,
		case when metrica_cumplidas is null then 0 else metrica_cumplidas end as metrica_cumplidas,
		case when metrica_garantias is null then 0 else metrica_garantias end as metrica_garantias,
		case when metrica_garantias_7d is null then 0 else metrica_garantias_7d end as metrica_garantias_7d,
		case when metrica_monitoreos is null then 0 else metrica_monitoreos end as metrica_monitoreos,
		case when metrica_diarias is null then 0 else metrica_diarias end as metrica_diarias,
		case when metrica_citas is null then 0 else metrica_citas end as metrica_citas,
		case when metrica_presentismo is null then 0 else metrica_presentismo end as metrica_presentismo,
		a.ponderado_cumplidas,
		a.ponderado_garantias,
		a.ponderado_garantias_7d,
		a.ponderado_monitoreos,
		a.ponderado_diarias,
		a.ponderado_citas,
		a.ponderado_presentismo,
		a.resultado * 5 as [5 Estrellas],
		case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno

from #final as a left join tecnicos as b
on a.id = b.id_tecnico
order by a.resultado desc
END