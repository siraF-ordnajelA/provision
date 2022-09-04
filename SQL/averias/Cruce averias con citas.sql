select a.Empresa as [Empresa asignada],
		a.T�cnico as [Tecnico asignado],
		a.[Subtipo de Actividad],
		a.[N�mero de Petici�n],
		a.[N�mero de Orden],
		a.[Access ID],
		a.S�ntoma,
		a.[Diagn�stico Inicial],
		a.[Diagn�stico Actual],
		a.[Bucket Inicial],
		datediff (day, a.[Fecha creaci�n TOA], cast(getdate() as date)) as antiguedad,
		b.[Fecha gestion cita],
		b.[Fecha Cita Manual]

from av_averias as a left join av_citas as b
on a.[N�mero de Petici�n] = b.[N�mero de Petici�n] and
	a.[N�mero de Orden] = b.[N�mero de Orden]
order by a.[Fecha creaci�n TOA]