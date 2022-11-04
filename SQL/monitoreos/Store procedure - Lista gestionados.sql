ALTER PROCEDURE lista_gestionados

as

SET LANGUAGE Spanish;

declare @fecha as date
set @fecha = dateadd(month, -12, cast(getdate() as date)) -- Resta 1 año

select datename(month,[Fecha de carga]) + ' ' + cast(datepart(year,[Fecha de carga]) as varchar(4)) as [Mes Carga],
		*
from mon_lista_gestionados_tecnico
where [Fecha de carga] >= @fecha
order by [Fecha de carga] desc