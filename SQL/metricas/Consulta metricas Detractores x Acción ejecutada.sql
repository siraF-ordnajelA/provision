declare @fecha1 varchar(8)
declare @fecha2 varchar(8)
declare @empresa varchar(80)
declare @tecno tinyint
declare @totales int
set @fecha1 = '20220901'
set @fecha2 = '20220915'



-- ACCION EJECUTADA
set @totales = (select count(*) from lista_medallia_casos where cast(fecha_mail as date) between @fecha1 and @fecha2)

select [Acción ejecutada] as accion,
		count(*) as casos,
		round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as porcentaje

from lista_medallia_casos
where cast(fecha_mail as date) between @fecha1 and @fecha2
group by [Acción ejecutada]
order by count(*) desc