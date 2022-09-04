alter procedure av_consulta_historico_garantias_tecnicos_detalle
@fecha1 varchar (8),
@fecha2 varchar (8),
@tecnico varchar (50)
as

select T�cnico,
		[Subtipo de Actividad],
		[C�digo de actuaci�n],
		[N�mero de Petici�n],
		[N�mero de Orden],
		[Access ID],
		cast ([fecha ingreso TOA] as date) as [Fecha ingreso TOA],
		cast (timestamp as date) as [Fecha Cumplimiento]
		
	
from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
	T�cnico = @tecnico and
	[Subtipo de actividad] like 'Reparaci�n%' and
	tecnologia <> 'cobre' and
	Garant�a <> 'no' and
	[Estado de la orden] = 'Completado'
