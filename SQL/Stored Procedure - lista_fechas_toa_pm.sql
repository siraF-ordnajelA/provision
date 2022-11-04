create procedure lista_fechas_toa_pm

as

select top 13 periodo
from ATC.dbo.toa_pm
group by periodo
order by periodo desc