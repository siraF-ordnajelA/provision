alter view garantia_lista_descargos

as

select a.id_descargo,
		(select apellido + ', ' + nombre from usuarios where id_usr = a.id_usuario) as usuario,
		case when b.nombre is null then 'No Programado' else b.nombre end as tecnico,
		case when c.descripcion_contrata is null then 'No Programado' else c.descripcion_contrata end as descripcion_contrata,
		a.nro_peticion,
		a.access_id,
		a.estado,
		case when e.DISTRITO_ATC is null then e.DISTRITO_PROV else e.DISTRITO_ATC end as Distrito,
		case when e.GERENCIA is null then e.GAUDI_CIUDAD else e.GERENCIA end as Gerencia,
		e.CENT_DESCRIP_COTA as central,
		a.subtipo_actividad,
		a.sintoma,
		a.fecha_ingreso,
		a.fecha_cierre,
		a.fecha_descargo,
		a.fecha_gestor,
		a.segmento,
		a.tecnologia,
		a.comentarios_ctta,
		f.motivo,
		g.submotivo,
		(select apellido + ', ' + nombre from usuarios where id_usr = a.id_gestor) as gestor,
		a.comentarios_gestor,
		h.motivo as motivo_gestor,
		i.submotivo as submotivo_gestor,
		a.sn_anterior,
		a.sn_actual,
		a.trabajado_gestor

from garantias_descargo as a left join tecnicos as b
on a.id_recurso = b.id_tecnico left join contratas as c
on a.id_empresa = c.id_contrata left join centrales2 as e
on a.id_central = e.cent_id left join garantias_cbo_motivo as f
on a.cbo1_ctta = f.id_motivo left join garantias_cbo_submotivo as g
on a.cbo2_ctta = g.id_submotivo left join garantias_cbo_motivo_gestor as h
on a.cbo1_gestor = h.id_motivo left join garantias_cbo_submotivo_gestor as i
on a.cbo2_gestor = i.id_submotivo