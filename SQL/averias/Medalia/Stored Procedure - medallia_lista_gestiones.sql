alter procedure medallia_lista_gestiones
@id_caso int,
@opc tinyint

as

select a.id_caso,
		a.motivo,
		a.contexto,
		a.id_clooper,
		b.apellido + ', ' + b.nombre as usuario,
		a.id_cliente,
		a.id_encuesta,
		left (a.fecha_encuesta,10) as fecha_encuesta,
		left (cast(a.fecha_mail as date),10) as fecha_mail,
		case when a.fecha_cierre3 is null and a.fecha_cierre2 is null then left (cast(a.fecha_cierre1 as date),10)
				when a.fecha_cierre3 is null and a.fecha_cierre2 is not null then left (cast(a.fecha_cierre2 as date),10)
				when a.fecha_cierre3 is not null then left (cast(a.fecha_cierre3 as date),10) end as fecha_fin,
		a.id_recurso,
		g.nombre as nombre_tecnico,
		replace(g.dni,'DNI-','') as dni,
		a.nombre as nombre_cliente,
		a.direccion,
		a.localidad,
		a.contacto,
		a.segmento,
		a.nro_orden,
		a.access_id,
		a.bucket,
		c.descripcion_contrata,
		a.nps,
		a.tecnico,
		a.puntualidad,
		a.profesionalidad,
		a.conocimiento,
		a.calidad,
		a.comunicacion,
		a.motivo_detractor,
		a.concepto as id_concepto,
		d.concepto,
		a.subconcepto as id_sub_concepto,
		case when e.sub_concepto is null then '-' else e.sub_concepto end as subconcepto,
		a.detalle as id_detalle,
		case when f.detalle is null then '-' else f.detalle end as detalle,
		a.accion_ejecutada,
		a.estado,
		a.id_gest_clooper,
		a.comentarios_cliente,
		a.respuesta_cliente,
		a.resp_final_cliente,
		case when a.respuesta_supervisor is null then '' else a.respuesta_supervisor end as resp_supervisor,
		case when a.cbo_resp_supervisor is null then 0 else a.cbo_resp_supervisor end as id_resp_supervisor,
		a.sn_anterior,
		a.sn_actual,
		a.reiteros,
		a.accion_clooper,
		a.respuesta_clooper,
		a.reagenda,
		a.id_central,
		h.GERENCIA,
		h.DISTRITO_ATC,
		h.CENT_DESCRIP_COTA,
		a.tecnologia

from medallia_encuestas as a join usuarios as b
on a.id_clooper = b.id_usr join contratas as c
on a.id_empresa = c.id_contrata left join medallia_cbo_conceptos as d
on a.concepto = d.id_concepto left join medallia_cbo_sub_conceptos as e
on a.subconcepto = e.id_subconcepto left join medallia_cbo_detalle as f
on a.detalle = f.id_detalle left join tecnicos as g
on a.id_recurso = g.id_tecnico left join centrales2 as h
on a.id_central = h.CENT_ID
where a.id_caso = @id_caso