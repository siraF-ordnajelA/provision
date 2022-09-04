alter procedure consulta_alarmas_olt

as

select * from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38