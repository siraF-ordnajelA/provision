alter procedure av_exporta_historico_garantias
@empresa varchar (50),
@fecha1 varchar (8),
@fecha2 varchar (8)
as

if (@empresa = 'TASA')
select b.Empresa as [Empresa Alta],
		b.T�cnico as [Tecnico Alta],
		b.[Subtipo de Actividad] as [Subtivo Alta],
		b.[C�digo de actuaci�n] as [C�digo actuaci�n Alta],
		a.[Subtipo de Actividad] as [Subtivo Averia],
		a.[C�digo de actuaci�n] as [C�digo actuaci�n Averia],
		b.[N�mero de Petici�n] as [Petici�n Alta],
		b.[N�mero de Orden] as [Orden Alta],
		a.[N�mero de Petici�n] as [Petici�n Averia],
		a.[N�mero de Orden] as [Orden Averia],
		b.[Fecha de Emisi�n Reclamo] as [Fecha emisi�n Alta],
		b.[TIMESTAMP] as [Fecha cumplimiento instalaci�n],
		b.[Bucket Inicial],
		min (a.[fecha ingreso TOA]) as [Fecha ingreso Averia TOA]

from ATC.dbo.toa_pm as a join ATC.dbo.toa_pm as b
on (a.timestamp between @fecha1 and @fecha2) and
	a.[Access ID] = b.[Access ID] and
	a.[Subtipo de actividad] like 'Reparaci�n%' and
	a.tecnologia <> 'cobre' and
	a.Garant�a <> 'no' and
	b.[Estado de la orden] = 'Completado'
	
where b.alta = 1
group by b.Empresa,
		b.T�cnico,
		b.[Subtipo de Actividad],
		b.[C�digo de actuaci�n],
		a.[Subtipo de Actividad],
		a.[C�digo de actuaci�n],
		b.[N�mero de Petici�n],
		b.[N�mero de Orden],
		a.[N�mero de Petici�n],
		a.[N�mero de Orden],
		b.[Fecha de Emisi�n Reclamo],
		b.[Bucket Inicial],
		b.[TIMESTAMP]
order by b.Empresa, b.T�cnico

if (@empresa <> 'TASA')
select b.Empresa as [Empresa Alta],
		b.T�cnico as [Tecnico Alta],
		b.[Subtipo de Actividad] as [Subtivo Alta],
		b.[C�digo de actuaci�n] as [C�digo actuaci�n Alta],
		a.[Subtipo de Actividad] as [Subtivo Averia],
		a.[C�digo de actuaci�n] as [C�digo actuaci�n Averia],
		b.[N�mero de Petici�n] as [Petici�n Alta],
		b.[N�mero de Orden] as [Orden Alta],
		a.[N�mero de Petici�n] as [Petici�n Averia],
		a.[N�mero de Orden] as [Orden Averia],
		b.[Fecha de Emisi�n Reclamo] as [Fecha emisi�n Alta],
		b.[TIMESTAMP] as [Fecha cumplimiento instalaci�n],
		b.[Bucket Inicial],
		min (a.[fecha ingreso TOA]) as [Fecha ingreso Averia TOA]

from ATC.dbo.toa_pm as a join ATC.dbo.toa_pm as b
on (a.timestamp between @fecha1 and @fecha2) and
	a.[Access ID] = b.[Access ID] and
	a.[Subtipo de actividad] like 'Reparaci�n%' and
	a.tecnologia <> 'cobre' and
	a.Garant�a <> 'no' and
	b.[Estado de la orden] = 'Completado'
	
where b.alta = 1 and b.Empresa = @empresa
group by b.Empresa,
		b.T�cnico,
		b.[Subtipo de Actividad],
		b.[C�digo de actuaci�n],
		a.[Subtipo de Actividad],
		a.[C�digo de actuaci�n],
		b.[N�mero de Petici�n],
		b.[N�mero de Orden],
		a.[N�mero de Petici�n],
		a.[N�mero de Orden],
		b.[Fecha de Emisi�n Reclamo],
		b.[Bucket Inicial],
		b.[TIMESTAMP]
order by b.Empresa, b.T�cnico