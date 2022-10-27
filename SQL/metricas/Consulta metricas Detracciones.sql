declare @fecha date
declare @detracciones int
set @fecha = '20220601'
set @detracciones = (select count(*) from medallia_encuestas where datepart(year, fecha_mail) = datepart(year, @fecha) and datepart(month, fecha_mail) = datepart(month, @fecha))


-- DETRACCIONES X LOCALIDAD
select top 10 localidad,
		count(*) as Cant,
		@detracciones as Total,
		round((cast(count(*) as float) / cast(@detracciones as float)) * 100, 1) as Porcentaje

from medallia_encuestas
where datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha)
group by localidad
order by count(*) desc

-- DETRACCIONES X SEGMENTO
select segmento,
		count(*) as Cant,
		@detracciones as Total,
		round((cast(count(*) as float) / cast(@detracciones as float)) * 100, 1) as Porcentaje

from medallia_encuestas
where datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha)
group by segmento
order by count(*) desc

-- DETRACCIONES X TECNOLOGIA
select tecnologia,
		count(*) as Cant,
		@detracciones as Total,
		round((cast(count(*) as float) / cast(@detracciones as float)) * 100, 1) as Porcentaje

from medallia_encuestas
where datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha)
group by tecnologia
order by count(*) desc