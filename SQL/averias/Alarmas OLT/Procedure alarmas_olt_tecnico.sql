alter procedure alarmas_olt_tecnico
@empresa varchar(150)
as
/*
IF (@empresa = 'TASA')
select Empresa,
		Técnico,
		COUNT(*) as Cant

from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL')
group by Empresa, Técnico
order by Empresa, Técnico

ELSE*/
select Empresa,
		Técnico,
		COUNT(*) as Cant

from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		Empresa = @empresa and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38
group by Empresa, Técnico
order by Empresa, Técnico