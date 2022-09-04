declare @periodo varchar(6)
declare @empresa varchar(80)
declare @tecno tinyint
set @periodo = '202205'

create table #detractores_empresa(Empresa varchar(120), Instalados int, casos int)
create table #detractores_region(region_mop varchar(40), Instalados int, casos int)
create table #detractores_segmento(Segmento varchar(11), Instalados int, casos int)
create table #detractores_tecnologia(tecnologia varchar(25), Instalados int, casos int)
create table #detractores_localidad(localidad varchar(150), Instalados int, casos int)
/*
select * from #altas_empresa order by Empresa
select * from #altas_segmento where Segmento <> '' and Segmento is not null order by Segmento
select * from #altas_region order by region_mop
select top 10 * from #altas_localidad order by Instalados desc
*/
-- DETRACTORES ALTAS POR EMPRESA
insert into #detractores_empresa (Empresa, Instalados, casos)

select a.Empresa,
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente and
	a.Empresa = b.descripcion_contrata
where a.periodo = @periodo and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.tecnologia <> 'cobre'
group by a.Empresa
order by a.Empresa

-- DETRACTORES ALTAS POR REGION
insert into #detractores_region (region_mop, Instalados, casos)

select a.region_mop,
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente
where a.periodo = @periodo and
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
where a.periodo = @periodo and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.[Segmento del cliente] <> '' and
		a.tecnologia <> 'cobre'
group by a.[Segmento del cliente]
order by a.[Segmento del cliente]

-- DETRACTORES ALTAS POR TECNOLOGIA
insert into #detractores_tecnologia (tecnologia, Instalados, casos)

select a.tecnologia,
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente
where a.periodo = @periodo and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.[Segmento del cliente] <> ''
group by a.tecnologia
order by a.tecnologia

-- DETRACTORES ALTAS POR LOCALIDAD
insert into #detractores_localidad (localidad, Instalados, casos)

select top 10 a.distrito_op_atc,
		count(*) as Instalados,
		count(b.descripcion_contrata) as Casos
		
from ATC.dbo.toa_pm as a left join lista_medallia_casos as b
on a.[Access ID] = b.access_id and
	a.[ID de Cliente] = b.id_cliente
where a.periodo = @periodo and
		a.alta = 1 and
		a.[Estado de la orden] = 'Completado' and
		a.[Segmento del cliente] <> ''
group by a.distrito_op_atc
order by count(b.descripcion_contrata) / count(*) desc