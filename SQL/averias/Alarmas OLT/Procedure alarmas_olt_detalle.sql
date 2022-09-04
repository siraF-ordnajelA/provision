alter procedure alarmas_olt_detalle
@tecnico varchar(150)
as

select * from alarmas_olt
where actuación in ('PRO_CHANGE_TECHNOLOGY','PRO_INSTALL') and
		Técnico = @tecnico and
		Celula <> 'ACCESO_NORTE_ATC' --A PEDIDO DE KITY CORREO DEL 14-04 9:38