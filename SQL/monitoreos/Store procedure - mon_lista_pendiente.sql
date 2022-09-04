alter procedure mon_lista_pendiente
@opc tinyint

as

-- PENDIENTES MONITOREO
IF (@opc = 1)
BEGIN
select a.id_pendiente,
		case when a.id_medallia is null then 0 else a.id_medallia end as id_medallia,
		case when d.id_encuesta is null then '' else d.id_encuesta end as id_encuesta,
		a.id_usuario,
		c.apellido + ' ' + c.nombre as clooper,
		a.id_recurso,
		b.nombre,
		b.ctta,
		b.dni,
		a.fyhingreso,
		case when a.observaciones is null then '' else a.observaciones end as observaciones,
		'' as obs_ctta,
		case when id_medallia is not null then 'imagenes/medallia_logo.PNG' else '<i class="nav-icon fa fa-edit" style="font-size: 20px;"></i>' end as bandera

from mon_medallia_lista as a left join tecnicos as b
on a.id_recurso = b.id_tecnico left join usuarios as c
on a.id_usuario = c.id_usr left join medallia_encuestas as d
on a.id_medallia = d.id_caso
where a.monitoreado = 0 and
		b.activo = 1 and
		cast (a.fyhingreso as date) > '20210516'
order by a.fyhingreso desc
END

-- PENDIENTES GESTOR
IF (@opc = 2)
BEGIN
select a.id_gestion as id_pendiente,
		--case when a.id_medallia is null then 0 else a.id_medallia end as id_medallia,
		case when d.id_medallia is null then 0 else d.id_medallia end as id_medallia,
		0 as id_encuesta,
		a.usuario as id_usuario,
		c.apellido + ' ' + c.nombre as clooper,
		a.id_recurso,
		b.nombre,
		b.ctta,
		b.dni,
		a.fyhgestion as fyhingreso,
		a.fecha_visto_ctta as observaciones,
		a.nombre_tec as obs_ctta,
		'' as bandera

from mon_gestionados2 as a left join tecnicos as b
on a.id_recurso = b.id_tecnico left join usuarios as c
on a.usuario = c.id_usr left join mon_medallia_lista as d
on a.id_medallia = d.id_pendiente
where a.trabajado = 0 and a.visto_ctta = 1 and
		a.flag_ingresante = 0 and
		cast (a.fyhgestion as date) > '20210516'
order by a.fyhgestion desc
END