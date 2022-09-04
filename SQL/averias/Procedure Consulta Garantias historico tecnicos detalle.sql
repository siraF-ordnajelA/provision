alter procedure av_consulta_historico_garantias_tecnicos_detalle
@fecha1 varchar (8),
@fecha2 varchar (8),
@tecnico varchar (50)
as

select Técnico,
		[Subtipo de Actividad],
		[Código de actuación],
		[Número de Petición],
		[Número de Orden],
		[Access ID],
		cast ([fecha ingreso TOA] as date) as [Fecha ingreso TOA],
		cast (timestamp as date) as [Fecha Cumplimiento]
		
	
from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
	Técnico = @tecnico and
	[Subtipo de actividad] like 'Reparación%' and
	tecnologia <> 'cobre' and
	Garantía <> 'no' and
	[Estado de la orden] = 'Completado'
