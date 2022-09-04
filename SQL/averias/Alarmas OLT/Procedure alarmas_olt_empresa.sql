alter procedure alarmas_olt_empresa
@empresa varchar(150)
as

IF (@empresa = 'TASA')
select Empresa,
		COUNT(*) as Cant

from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38
group by Empresa
order by Empresa

ELSE
select Empresa,
		COUNT(*) as Cant

from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		empresa = @empresa and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38
group by Empresa
order by Empresa