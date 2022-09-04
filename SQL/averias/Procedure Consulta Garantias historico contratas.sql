alter procedure av_consulta_historico_garantias_contratas
@empresa varchar (50),
@fecha1 varchar (8),
@fecha2 varchar (8)

as

if (@empresa = 'TASA')
select Empresa,
		count (*) as Cant

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
	[Subtipo de actividad] like 'Reparación%' and
	tecnologia <> 'cobre' and
	Garantía <> 'no' and
	[Estado de la orden] = 'Completado'
	
group by Empresa
order by Empresa

if (@empresa <> 'TASA')
select Empresa,
		count (*) as Cant

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
	[Subtipo de actividad] like 'Reparación%' and
	tecnologia <> 'cobre' and
	Garantía <> 'no' and
	[Estado de la orden] = 'Completado' and
	Empresa = @empresa
	
group by Empresa
order by Empresa