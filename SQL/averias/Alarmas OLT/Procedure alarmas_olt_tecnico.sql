alter procedure alarmas_olt_tecnico
@empresa varchar(150)
as
/*
IF (@empresa = 'TASA')
select Empresa,
		T�cnico,
		COUNT(*) as Cant

from alarmas_olt
where actuaci�n in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL')
group by Empresa, T�cnico
order by Empresa, T�cnico

ELSE*/
select Empresa,
		T�cnico,
		COUNT(*) as Cant

from alarmas_olt
where actuaci�n in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		Empresa = @empresa and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38
group by Empresa, T�cnico
order by Empresa, T�cnico