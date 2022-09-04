alter procedure av_consulta_historico_garantias_tecnicos
@fecha1 varchar (8),
@fecha2 varchar (8),
@empresa varchar (50)
as

select T�cnico as Tecnico,
		count (*) as cant
		
from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
	Empresa = @empresa and
	[Subtipo de actividad] like 'Reparaci�n%' and
	tecnologia <> 'cobre' and
	Garant�a <> 'no' and
	[Estado de la orden] = 'Completado'

group by T�cnico
order by T�cnico