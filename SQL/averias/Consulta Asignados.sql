select count(*) as [Total Garantias]
from av_averias

select asignacion, count(*) as Cant
from av_averias
group by asignacion
order by asignacion

select Empresa,
		T�cnico,
		[C�digo de actuaci�n],
		[N�mero de Petici�n],
		[N�mero de Orden],
		[Access ID],
		[Bucket Inicial],
		[Subtipo de cliente]
		
from av_averias
where asignacion is null or asignacion = 'NO ASIGNADO'