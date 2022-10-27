use ATC

declare @periodo varchar(6)
declare @empresa varchar(80)
declare @region_mop varchar(25)
declare @tecno tinyint
declare @total int

set @periodo = '202205'

create table #altas_empresa(Empresa varchar(120), Instalados int)
create table #altas_segmento(Segmento varchar(11), Instalados int)
create table #altas_region(region_mop varchar(40), Instalados int)
create table #altas_localidad(localidad varchar(150), Instalados int)
/*
select * from #altas_empresa order by Empresa
select * from #altas_segmento where Segmento <> '' and Segmento is not null order by Segmento
select * from #altas_region order by region_mop
select top 10 * from #altas_localidad order by Instalados desc
*/

-- ALTAS POR EMPRESA
insert into #altas_empresa (Empresa, Instalados)

select Empresa,
		count(*) as Instalados
		
from toa_pm
where periodo = @periodo and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by Empresa
order by Empresa

-- ALTAS POR SEGMENTO
insert into #altas_segmento (Segmento, Instalados)

select [Segmento del cliente],
		count(*) as Instalados
		
from toa_pm
where periodo = @periodo and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by [Segmento del cliente]
order by [Segmento del cliente]

-- ALTAS POR REGION
insert into #altas_region (region_mop, Instalados)

select region_mop,
		count(*) as Instalados
		
from toa_pm
where periodo = @periodo and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by region_mop
order by region_mop

-- ALTAS POR LOCALIDAD
insert into #altas_localidad (localidad, Instalados)

select distrito_op_atc,
		count(*) as Instalados
		
from toa_pm
where periodo = @periodo and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by distrito_op_atc
order by distrito_op_atc


set @total = (select sum(Instalados) from #altas_empresa)


----------------------------------------------------
-- SELECT ALTAS POR EMPRESA
select Empresa,
		Instalados,
		@total as Total,
		round((cast(Instalados as float) / cast(@total as float)) * 100, 1) as Porcentaje
from #altas_empresa order by Instalados desc