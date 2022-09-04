select a.Empresa,
		a.[Subtipo de Actividad],
		a.[C�digo de actuaci�n],
		a.[Estado de la orden],
		a.[N�mero de Petici�n],
		a.[N�mero de Orden],
		a.Programacion,
		a.[Access ID],
		b.Empresa,
		b.[Subtipo de Actividad],
		b.[C�digo de actuaci�n],
		b.[Estado de la orden],
		b.[N�mero de Petici�n],
		b.[N�mero de Orden],
		b.[Tecnologia Banda Ancha],
		b.[Tecnologia TV],
		b.[Tecnologia Voz],
		b.Multiproducto,
		b.Tecnologia,
		b.[Razon de Suspension Instalacion],
		b.[Motivo no realizado instalaci�n],
		b.[Access ID],
		a.[Fecha de Emisi�n/Reclamo],
		b.TIMESTAMP as [Fecha instalado/cancelado],
		DATEDIFF(day, cast (b.timestamp as DATE), a.[Fecha de Emisi�n/Reclamo]) as Diferencia

from av_averias as a left join ATC.dbo.toa_pm as b
on a.[Access ID] <> '' and
	a.[Access ID] = b.[Access ID] and
	b.[Estado de la orden] in ('Completado', null) and
	DATEDIFF(day, cast (b.timestamp as DATE), a.[Fecha de Emisi�n/Reclamo]) between 0 and 31
	
--select top 1 * from ATC.dbo.toa_pm