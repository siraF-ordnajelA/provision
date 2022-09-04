alter procedure av_exporta_historico_garantias
@empresa varchar (50),
@fecha1 varchar (8),
@fecha2 varchar (8)
as

if (@empresa = 'TASA')
select b.Empresa as [Empresa Alta],
		b.Técnico as [Tecnico Alta],
		b.[Subtipo de Actividad] as [Subtivo Alta],
		b.[Código de actuación] as [Código actuación Alta],
		a.[Subtipo de Actividad] as [Subtivo Averia],
		a.[Código de actuación] as [Código actuación Averia],
		b.[Número de Petición] as [Petición Alta],
		b.[Número de Orden] as [Orden Alta],
		a.[Número de Petición] as [Petición Averia],
		a.[Número de Orden] as [Orden Averia],
		b.[Fecha de Emisión Reclamo] as [Fecha emisión Alta],
		b.[TIMESTAMP] as [Fecha cumplimiento instalación],
		b.[Bucket Inicial],
		min (a.[fecha ingreso TOA]) as [Fecha ingreso Averia TOA]

from ATC.dbo.toa_pm as a join ATC.dbo.toa_pm as b
on (a.timestamp between @fecha1 and @fecha2) and
	a.[Access ID] = b.[Access ID] and
	a.[Subtipo de actividad] like 'Reparación%' and
	a.tecnologia <> 'cobre' and
	a.Garantía <> 'no' and
	b.[Estado de la orden] = 'Completado'
	
where b.alta = 1
group by b.Empresa,
		b.Técnico,
		b.[Subtipo de Actividad],
		b.[Código de actuación],
		a.[Subtipo de Actividad],
		a.[Código de actuación],
		b.[Número de Petición],
		b.[Número de Orden],
		a.[Número de Petición],
		a.[Número de Orden],
		b.[Fecha de Emisión Reclamo],
		b.[Bucket Inicial],
		b.[TIMESTAMP]
order by b.Empresa, b.Técnico

if (@empresa <> 'TASA')
select b.Empresa as [Empresa Alta],
		b.Técnico as [Tecnico Alta],
		b.[Subtipo de Actividad] as [Subtivo Alta],
		b.[Código de actuación] as [Código actuación Alta],
		a.[Subtipo de Actividad] as [Subtivo Averia],
		a.[Código de actuación] as [Código actuación Averia],
		b.[Número de Petición] as [Petición Alta],
		b.[Número de Orden] as [Orden Alta],
		a.[Número de Petición] as [Petición Averia],
		a.[Número de Orden] as [Orden Averia],
		b.[Fecha de Emisión Reclamo] as [Fecha emisión Alta],
		b.[TIMESTAMP] as [Fecha cumplimiento instalación],
		b.[Bucket Inicial],
		min (a.[fecha ingreso TOA]) as [Fecha ingreso Averia TOA]

from ATC.dbo.toa_pm as a join ATC.dbo.toa_pm as b
on (a.timestamp between @fecha1 and @fecha2) and
	a.[Access ID] = b.[Access ID] and
	a.[Subtipo de actividad] like 'Reparación%' and
	a.tecnologia <> 'cobre' and
	a.Garantía <> 'no' and
	b.[Estado de la orden] = 'Completado'
	
where b.alta = 1 and b.Empresa = @empresa
group by b.Empresa,
		b.Técnico,
		b.[Subtipo de Actividad],
		b.[Código de actuación],
		a.[Subtipo de Actividad],
		a.[Código de actuación],
		b.[Número de Petición],
		b.[Número de Orden],
		a.[Número de Petición],
		a.[Número de Orden],
		b.[Fecha de Emisión Reclamo],
		b.[Bucket Inicial],
		b.[TIMESTAMP]
order by b.Empresa, b.Técnico