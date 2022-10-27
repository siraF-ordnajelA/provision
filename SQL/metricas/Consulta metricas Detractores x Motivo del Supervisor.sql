use TELEGESTION

declare @periodo varchar(8)
declare @empresa varchar(80)
declare @region_mop varchar(25)
declare @tecno tinyint
declare @totales int
set @periodo = '20220501'


select top 5 [Motivo supervisor],
		count(*) as Casos

from lista_medallia_casos
where datepart(year, fecha_mail) = datepart(year, @periodo) and
		datepart(month, fecha_mail) = datepart(month, @periodo) and
		[Motivo supervisor] <> ''
group by [Motivo supervisor]
order by count(*) desc