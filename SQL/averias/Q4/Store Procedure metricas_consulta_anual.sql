alter procedure metricas_consulta_anual
@fecha smallint,
@tecnologia tinyint, --1: CU / 2: FTTH
@empresa varchar(150)

as

-- VARIABLES
declare @id_contrata tinyint

create table #anual (Empresa varchar(50),
						Enero decimal(8,6),
						Febrero decimal(8,6),
						Marzo decimal(8,6),
						Abril decimal(8,6),
						Mayo decimal(8,6),
						Junio decimal(8,6),
						Julio decimal(8,6),
						Agosto decimal(8,6),
						Septiembre decimal(8,6),
						Octubre decimal(8,6),
						Noviembre decimal(8,6),
						Diciembre decimal(8,6))

create table #final (Fecha date,
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
				resultado decimal(8,6))


insert into #final (Fecha,
					id,
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

select Fecha,
		id_ctta,
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
where central = 0 and
		id_ctta <> 21 and
		id_ctta <> 5 and
		tecnologia = @tecnologia

update #final
set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_garantias_7d + ponderado_diarias + ponderado_citas + ponderado_presentismo) / 6
--set resultado = (ponderado_cumplidas + ponderado_garantias + ponderado_monitoreos + ponderado_diarias + ponderado_citas) / 5




IF (@fecha = '' or @fecha = 0)
BEGIN
set @fecha = DATEPART(year,getdate())
END

-- ENERO
insert into #anual (Empresa, Enero)

select b.descripcion_contrata,
		a.resultado * 5

from #final as a left join contratas as b
on a.id = b.id_contrata
where DATEPART(year, Fecha) = @fecha and
		DATEPART(month, Fecha) = 1
order by b.descripcion_contrata

-- FEBRERO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 2) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Febrero = origen.resultado * 5;

-- MARZO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 3) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Marzo = origen.resultado * 5;

-- ABRIL
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 4) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Abril = origen.resultado * 5;

-- MAYO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 5) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Mayo = origen.resultado * 5;

-- JUNIO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 6) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Junio = origen.resultado * 5;

-- JULIO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 7) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Julio = origen.resultado * 5;

-- AGOSTO
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 8) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Agosto = origen.resultado * 5;

-- SEPTIEMBRE
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 9) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Septiembre = origen.resultado * 5;

-- OCTUBRE
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 10) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Octubre = origen.resultado * 5;

-- NOVIEMBRE
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 11) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Noviembre = origen.resultado * 5;

-- DICIEMBRE
merge into #anual as destino
using (select b.descripcion_contrata,
				a.resultado

		from #final as a left join contratas as b
		on a.id = b.id_contrata
		where DATEPART(year, Fecha) = @fecha and
				DATEPART(month, Fecha) = 12) as origen
		
on origen.descripcion_contrata = destino.Empresa

when matched then update set
destino.Diciembre = origen.resultado * 5;

update #anual
set Enero = 0 where Enero is null
update #anual
set Febrero = 0 where Febrero is null
update #anual
set Marzo = 0 where Marzo is null
update #anual
set Abril = 0 where Abril is null
update #anual
set Mayo = 0 where Mayo is null
update #anual
set Junio = 0 where Junio is null
update #anual
set Julio = 0 where Julio is null
update #anual
set Agosto = 0 where Agosto is null
update #anual
set Septiembre = 0 where Septiembre is null
update #anual
set Octubre = 0 where Octubre is null
update #anual
set Noviembre = 0 where Noviembre is null
update #anual
set Diciembre = 0 where Diciembre is null




-- RESULTADOS TASA
IF (@empresa = 'TASA')
BEGIN
select *, case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno
from #anual
order by Empresa
END

ELSE IF (@empresa <> 'TASA')
BEGIN
select *, case when @tecnologia = 1 then 'COBRE' else 'FTTH' end as tecno
from #anual
where Empresa = @empresa
END