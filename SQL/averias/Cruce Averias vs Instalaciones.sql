select a.Empresa,
		a.[Subtipo de Actividad],
		a.[Código de actuación],
		a.[Estado de la orden],
		a.[Número de Petición],
		a.[Número de Orden],
		a.Programacion,
		a.[Access ID],
		b.Empresa,
		b.[Subtipo de Actividad],
		b.[Código de actuación],
		b.[Estado de la orden],
		b.[Número de Petición],
		b.[Número de Orden],
		b.[Tecnologia Banda Ancha],
		b.[Tecnologia TV],
		b.[Tecnologia Voz],
		b.Multiproducto,
		b.Tecnologia,
		b.[Razon de Suspension Instalacion],
		b.[Motivo no realizado instalación],
		b.[Access ID],
		a.[Fecha de Emisión/Reclamo],
		b.TIMESTAMP as [Fecha instalado/cancelado],
		DATEDIFF(day, cast (b.timestamp as DATE), a.[Fecha de Emisión/Reclamo]) as Diferencia

from av_averias as a left join ATC.dbo.toa_pm as b
on a.[Access ID] <> '' and
	a.[Access ID] = b.[Access ID] and
	b.[Estado de la orden] in ('Completado', null) and
	DATEDIFF(day, cast (b.timestamp as DATE), a.[Fecha de Emisión/Reclamo]) between 0 and 31
	
--select top 1 * from ATC.dbo.toa_pm