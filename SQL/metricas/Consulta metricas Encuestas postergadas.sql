declare @fecha date
declare @casos int

set @fecha = '20220501'
set @casos = (select count(*) from medallia_encuestas where datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha))

-- ENCUESTAS POSTERGADAS POR CONTRATA
select descripcion_contrata,
		Reagenda,
		count(*) as Casos

from lista_medallia_casos
where datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha) --and
		--Reagenda = 'SI'
group by descripcion_contrata, reagenda
order by count(*) desc

-- ENCUESTAS POSTERGADAS POR REGION
select b.Empresa,
		b.region_mop,
		count(*) as casos_postergados,
		@casos as casos_total,
		round((cast(count(*) as float) / cast(@casos as float)*100), 2) as Porcentaje

from medallia_encuestas as a left join ATC.dbo.toa_pm as b
on a.nro_orden = b.[Número de Orden] and
	b.alta = 1 and
	(b.[Estado de la orden] = 'Completado' or b.[Estado de la orden] = 'COMPLETADO2')
where datepart(year, a.fecha_mail) = datepart(year, @fecha) and
		datepart(month, a.fecha_mail) = datepart(month, @fecha) and
		a.reagenda = 1
group by b.Empresa, b.region_mop
order by count(*) desc