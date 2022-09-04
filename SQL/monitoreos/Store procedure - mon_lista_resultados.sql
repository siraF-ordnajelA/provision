alter procedure mon_lista_resultados
@opc tinyint,
@empresa varchar(50)

as

/*
1 Apto
2 Provisorio
3 No Apto
*/

IF (@empresa = 'TASA' and @opc <> 1)
BEGIN
select mon_gestionados2.id_gestion,
		mon_gestionados2.fyhgestion,
		mon_gestionados2.fyhmonitoreo,
		mon_gestionados2.id_recurso,
		usuarios.apellido + ' ' + usuarios.nombre as [Usuario Auditor],
		case when mon_gestionados2.id_recurso = 0 then mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec
			 when mon_gestionados2.flag_ingresante = 1 then (select Apellido + ' ' + Nombre from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.nombre end as [Nombre del Tecnico],
		tecnicos.dni,
		mon_gestionados2.flag_ingresante as Ingresante,
		case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end as Contratista,
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_cita) as [Motivo Calibración]

from mon_gestionados2 left join usuarios
on mon_gestionados2.usuario = usuarios.id_usr left join tecnicos
on mon_gestionados2.id_recurso = tecnicos.id_tecnico
where mon_gestionados2.calificacion = @opc and
		trabajado = 0 and
		visto_ctta is null and
		mon_gestionados2.flag_ingresante = 0 and
		mon_gestionados2.fyhmonitoreo > '20210516'
order by mon_gestionados2.fyhmonitoreo desc
END

IF (@empresa = 'TASA' and @opc = 1)
BEGIN
select mon_gestionados2.id_gestion,
		mon_gestionados2.fyhgestion,
		mon_gestionados2.fyhmonitoreo,
		mon_gestionados2.id_recurso,
		usuarios.apellido + ' ' + usuarios.nombre as [Usuario Auditor],
		case when mon_gestionados2.id_recurso = 0 then mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec
			 when mon_gestionados2.flag_ingresante = 1 then (select Apellido + ' ' + Nombre from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.nombre end as [Nombre del Tecnico],
		tecnicos.dni,
		mon_gestionados2.flag_ingresante as Ingresante,
		case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end as Contratista,
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_cita) as [Motivo Calibración]

from mon_gestionados2 left join usuarios
on mon_gestionados2.usuario = usuarios.id_usr left join tecnicos
on mon_gestionados2.id_recurso = tecnicos.id_tecnico
where mon_gestionados2.calificacion = @opc and
		mon_gestionados2.fyhmonitoreo > '20210516'
order by mon_gestionados2.fyhmonitoreo desc
END

IF (@empresa <> 'TASA' and @opc <> 1)
BEGIN
select mon_gestionados2.id_gestion,
		mon_gestionados2.fyhgestion,
		mon_gestionados2.fyhmonitoreo,
		mon_gestionados2.id_recurso,
		usuarios.apellido + ' ' + usuarios.nombre as [Usuario Auditor],
		case when mon_gestionados2.id_recurso = 0 then mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec
			 when mon_gestionados2.flag_ingresante = 1 then (select Apellido + ' ' + Nombre from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.nombre end as [Nombre del Tecnico],
		tecnicos.dni,
		mon_gestionados2.flag_ingresante as Ingresante,
		case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end as Contratista,
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_cita) as [Motivo Calibración]

from mon_gestionados2 left join usuarios
on mon_gestionados2.usuario = usuarios.id_usr left join tecnicos
on mon_gestionados2.id_recurso = tecnicos.id_tecnico
where case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end = @empresa and
		mon_gestionados2.calificacion = @opc and
		trabajado = 0 and
		visto_ctta is null and
		mon_gestionados2.flag_ingresante = 0 and
		mon_gestionados2.fyhmonitoreo > '20210516'
order by mon_gestionados2.fyhmonitoreo desc
END

IF (@empresa <> 'TASA' and @opc = 1)
BEGIN
select mon_gestionados2.id_gestion,
		mon_gestionados2.fyhgestion,
		mon_gestionados2.fyhmonitoreo,
		mon_gestionados2.id_recurso,
		usuarios.apellido + ' ' + usuarios.nombre as [Usuario Auditor],
		case when mon_gestionados2.id_recurso = 0 then mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec
			 when mon_gestionados2.flag_ingresante = 1 then (select Apellido + ' ' + Nombre from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.nombre end as [Nombre del Tecnico],
		tecnicos.dni,
		mon_gestionados2.flag_ingresante as Ingresante,
		case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end as Contratista,
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_cita) as [Motivo Calibración]

from mon_gestionados2 left join usuarios
on mon_gestionados2.usuario = usuarios.id_usr left join tecnicos
on mon_gestionados2.id_recurso = tecnicos.id_tecnico
where case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end = @empresa and
		mon_gestionados2.calificacion = @opc and
		mon_gestionados2.fyhmonitoreo > '20210516'
order by mon_gestionados2.fyhmonitoreo desc
END