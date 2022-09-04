select count(*) as [Total Garantias]
from av_averias

select asignacion, count(*) as Cant
from av_averias
group by asignacion
order by asignacion

select Empresa,
		Técnico,
		[Código de actuación],
		[Número de Petición],
		[Número de Orden],
		[Access ID],
		[Bucket Inicial],
		[Subtipo de cliente]
		
from av_averias
where asignacion is null or asignacion = 'NO ASIGNADO'