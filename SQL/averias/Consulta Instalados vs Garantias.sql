select Empresa,
		T�cnico,
		count (*) as Cant
		
FROM ATC.dbo.toa_pm
where Empresa <> '' and
		alta = 1 and
		tecnologia <> 'cobre' and
		timestamp between '20190404' and '20190405'
group by Empresa, T�cnico
order by Empresa, T�cnico



select [Access ID],
		T�cnico,
		Empresa,
		[Subtipo de Actividad],
		[C�digo de actuaci�n],
		[Estado de la orden],
		tecnologia,
		alta,
		timestamp
		
FROM ATC.dbo.toa_pm
where [Access ID] = 135010458
order by timestamp desc


--CUENTA INSTALADOS
select T�cnico, count ([Access ID]) as Instalados

FROM ATC.dbo.toa_pm
where timestamp > '20190405' and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by T�cnico
order by T�cnico

--CUENTA REPARADOS
select T�cnico, count ([Access ID]) as Reparados

FROM ATC.dbo.toa_pm
where timestamp > '20190405' and
		[Subtipo de actividad] like 'Reparaci�n%' and
		--[Estado de la orden] = 'Completado' and
		tecnologia <> 'cobre'
group by T�cnico
order by T�cnico


SELECT [Subtipo de actividad]
FROM ATC.dbo.toa_pm
group by [Subtipo de actividad]
order by [Subtipo de actividad]
--where [Access ID] = 135010458 and