select a.Empresa as [Empresa asignada],
		a.Técnico as [Tecnico asignado],
		a.[Subtipo de Actividad],
		a.[Número de Petición],
		a.[Número de Orden],
		a.[Access ID],
		a.Síntoma,
		a.[Diagnóstico Inicial],
		a.[Diagnóstico Actual],
		a.[Bucket Inicial],
		datediff (day, a.[Fecha creación TOA], cast(getdate() as date)) as antiguedad,
		b.[Fecha gestion cita],
		b.[Fecha Cita Manual]

from av_averias as a left join av_citas as b
on a.[Número de Petición] = b.[Número de Petición] and
	a.[Número de Orden] = b.[Número de Orden]
order by a.[Fecha creación TOA]