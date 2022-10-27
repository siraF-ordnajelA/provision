declare @fecha varchar(8)
set @fecha = '20220701'
/*
select id_caso,
		id_encuesta,
		fecha_mail,
		fecha_fin,
		datediff(day, fecha_mail, fecha_fin) as Dias,
		[Motivo detractor],
		[Concepto],
		[Subconcepto],
		[Detalle],
		[Motivo detractor 2da gestión],
		[Acción ejecutada],
		Estado,
		resp_supervisor,
		[Motivo supervisor],
		reiteros,
		[Gestión clooper]

from lista_medallia_casos
where datediff(day, fecha_mail, fecha_fin) > 1 and
		datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha) and
		[Acción ejecutada] = 'Derivado a la contratista' and
		descripcion_contrata = 'PLANTEL'
order by fecha_mail desc
*/



select datename(month,a.fecha_encuesta) + ' ' + cast(datepart(year,a.fecha_encuesta) as varchar(4)) as [MES ENCUESTA],
		a.fecha_encuesta as [FECHA ENCUESTA],
		a.fecha_mail as [FECHA INICIO CTTA / CIERRE CLOOPER],
		a.fecha_cierre1 as [FECHA CIERRE CTTA],
		datediff (hour, a.fecha_mail, a.fecha_cierre1) as [HS.RESP.CONTRATISTA],
		a.fecha_cierre2 as [FECHA CIERRE CLOOPER],
		datediff (hour, a.fecha_cierre1, fecha_cierre2) as [HS.RESP.CLOOPER],
		a.fecha_cierre3 as [FECHA CIERRE SOPORTE],
		c.ctta as [EMPRESA]

from medallia_encuestas as a left join tecnicos as c
on a.id_recurso = c.id_tecnico left join centrales2 as g
on a.id_central = g.CENT_ID
where a.accion_ejecutada = 1 and
		datepart(year, fecha_mail) = datepart(year, @fecha) and
		datepart(month, fecha_mail) = datepart(month, @fecha) and
		c.ctta = 'PLANTEL' and
		datediff (hour, a.fecha_mail, a.fecha_cierre1) >= 48