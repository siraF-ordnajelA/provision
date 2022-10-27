use TELEGESTION

declare @fecha1 varchar(6)
declare @fecha2 varchar(6)
declare @empresa varchar(80)
declare @tecno tinyint
declare @totales int
set @fecha1 = '202206'
set @fecha2 = '202207'

create table #instalados_empresa(Empresa varchar(120), Instalados int, casos int)
create table #detractores_empresa(Empresa varchar(120), motivo varchar(50), casos int)
create table #detractores_region(region_mop varchar(40), Instalados int, casos int)
create table #detractores_segmento(Segmento varchar(11), Instalados int, casos int)
create table #detractores_tecnologia(tecnologia varchar(25), casos int)
create table #detractores_localidad(localidad varchar(150), casos int)

-- ALTAS POR EMPRESA
insert into #instalados_empresa (Empresa, Instalados)

select b.descripcion_contrata,
		sum(a.Instalaciones) as Inst
from q4s_30d as a left join contratas as b
on a.id_contrata = b.id_contrata
where a.Fecha between @fecha1 and @fecha2 and
		a.tecnologia <> 'cobre'
group by b.descripcion_contrata

-- DETRACTORES POR EMPRESA
insert into #detractores_empresa (Empresa, motivo, casos)

select descripcion_contrata,
		[Motivo detractor],
		count(*)
from lista_medallia_casos
where fecha_mail between @fecha1 and @fecha2
group by descripcion_contrata, [Motivo detractor]

-- DETRACTORES ALTAS POR REGION
insert into #detractores_region (region_mop, Instalados, casos)

select a.region_mop,
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente
where a.periodo between @fecha1 and @fecha2 and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.tecnologia <> 'cobre'
group by a.region_mop
order by a.region_mop

-- DETRACTORES ALTAS POR SEGMENTO
insert into #detractores_segmento (Segmento, Instalados, casos)

select a.[Segmento del cliente],
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente
where a.periodo between @fecha1 and @fecha2 and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.[Segmento del cliente] <> '' and
		a.tecnologia <> 'cobre'
group by a.[Segmento del cliente]
order by a.[Segmento del cliente]

-- DETRACTORES ALTAS POR TECNOLOGIA
insert into #detractores_tecnologia (tecnologia, casos)

select tecnologia,
		count(*) as cant

from medallia_encuestas
where fecha_mail between '20220601' and '20220701'
group by tecnologia
select * from #detractores_tecnologia
-- DETRACTORES ALTAS POR LOCALIDAD
insert into #detractores_localidad (localidad, casos)

select localidad,
		count(*) as cant
from medallia_encuestas
where fecha_mail between '20220601' and '20220701' and
		localidad <> ''
group by localidad






------------------------------------------------
--SELECCION DETRACTORES ALTAS POR EMPRESA
merge into #instalados_empresa as origen
using (select Empresa, sum(casos) as cant
		from #detractores_empresa
		group by Empresa) as destino
		
on origen.Empresa = destino.Empresa
when matched then
update set origen.casos = destino.cant;

select *,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje
from #instalados_empresa
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc


--SELECCION DETRACTORES POR REGION
--declare @totales int
set @totales = (select sum(casos) from #detractores_region)

select region_mop,
		casos,
		round((cast(casos as float) / cast(@totales as float)) * 100, 2) as Porcentaje

from #detractores_region
order by (cast(casos as float) / cast(@totales as float)) * 100 desc

--SELECCION DETRACTORES POR SEGMENTO
--declare @totales int
set @totales = (select sum(casos) from #detractores_segmento)

select Segmento,
		casos,
		round((cast(casos as float) / cast(@totales as float)) * 100, 2) as Porcentaje

from #detractores_segmento
order by (cast(casos as float) / cast(@totales as float)) * 100 desc

-- DETRACTORES ALTAS POR TECNOLOGIA
declare @totales int
set @totales = (select sum(casos) from #detractores_tecnologia)

select tecnologia,
		casos,
		round((cast(casos as float) / cast(@totales as float)) * 100, 2) as Porcentaje

from #detractores_tecnologia
order by (cast(casos as float) / cast(@totales as float)) * 100 desc

-- DETRACTORES ALTAS POR LOCALIDAD
--declare @totales int
set @totales = (select sum(casos) from #detractores_localidad)

select top 10 localidad,
		casos,
		round((cast(casos as float) / cast(@totales as float)) * 100, 2) as Porcentaje

from #detractores_localidad
order by (cast(casos as float) / cast(@totales as float)) * 100 desc