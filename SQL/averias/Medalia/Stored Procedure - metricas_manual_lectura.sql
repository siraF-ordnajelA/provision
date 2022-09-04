alter procedure metricas_manual_lectura
@empresa tinyint

as

select top 3 Fecha,
		valor
from metricas_manuales
where Fecha < dateadd(month, -1, (select max(Fecha) from metricas_ctta)) and
		id_contrata = @empresa
order by Fecha desc