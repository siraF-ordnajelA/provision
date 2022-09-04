alter view lista_medallia_casos
as

select a.id_caso,
		case when a.motivo = 1 then 'Instalación'
				when a.motivo = 2 then 'Cancelación' end as [Motivo],
		case when a.contexto = 1 then 'COVID-19'
				when a.contexto = 2 then 'Tradicional' end as Contexto,
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
		-----------------------------------------------------------------------
		case when a.motivo_detractor = 1 then 'Comercial'
				when a.motivo_detractor = 2 then 'Técnico'
				when a.motivo_detractor = 3 then 'Cliente'
				when a.motivo_detractor = 4 then 'Despacho provisión' end as [Motivo detractor],
		d.concepto,
		case when e.sub_concepto is null then '-' else e.sub_concepto end as subconcepto,
		case when f.detalle is null then '-' else f.detalle end as detalle,
		-----------------------
		case when a.motivo_detractor_2 = 1 then 'Comercial'
				when a.motivo_detractor_2 = 2 then 'Técnico'
				when a.motivo_detractor_2 = 3 then 'Cliente'
				when a.motivo_detractor_2 = 4 then 'Despacho provisión' else null end as [Motivo detractor 2da gestión],
		(select concepto from medallia_cbo_conceptos where id_concepto = a.concepto_2) as [Concepto 2da gestión],
		(select sub_concepto from medallia_cbo_sub_conceptos where id_subconcepto = a.subconcepto_2) as [Subconcepto 2da gestión],
		(select detalle from medallia_cbo_detalle where id_detalle = a.detalle_2) as [Detalle 2da gestión],
		-----------------------------------------------------------------------
		case when a.accion_ejecutada = 1 then 'Derivado a la contratista'
				when a.accion_ejecutada = 2 then 'Derivado a clooper comercial'
				when a.accion_ejecutada = 3 then 'Derivado a soporte sistema'
				when a.accion_ejecutada = 4 then 'Gestionado por clooper' end as [Acción ejecutada],
		case when a.estado = 1 then 'Cerrado'
				when a.estado = 2 then 'Escalado'
				when a.estado = 3 then 'Pendiente'
				when a.estado = 4 then 'Escalado / Refuerzo' end as Estado,
		a.comentarios_cliente,
		a.respuesta_cliente,
		a.resp_final_cliente,
		case when a.respuesta_supervisor is null then '' else a.respuesta_supervisor end as resp_supervisor,
		case when a.cbo_resp_supervisor = 1 then 'Materiales'
				when a.cbo_resp_supervisor = 2 then 'Método constructivo'
				when a.cbo_resp_supervisor = 3 then 'Cambio Android TV'
				when a.cbo_resp_supervisor = 4 then 'Cambio Android TV recuperado'
				when a.cbo_resp_supervisor = 5 then 'Cambio cable de red'
				when a.cbo_resp_supervisor = 6 then 'Cambio caja estanco'
				when a.cbo_resp_supervisor = 7 then 'Cambio conector'
				when a.cbo_resp_supervisor = 8 then 'Cambio drop'
				when a.cbo_resp_supervisor = 9 then 'Cambio HGU'
				when a.cbo_resp_supervisor = 10 then 'Cambio HGU recuperado'
				when a.cbo_resp_supervisor = 11 then 'Cambio patch cord FO'
				when a.cbo_resp_supervisor = 12 then 'Cambio repetidor'
				when a.cbo_resp_supervisor = 13 then 'Cambio repetidor recuperado'
				when a.cbo_resp_supervisor = 14 then 'Cambio roseta óptica'
				when a.cbo_resp_supervisor = 15 then 'Cambio STB IPTV'
				when a.cbo_resp_supervisor = 16 then 'Cambio STB IPTV recuperado'
				when a.cbo_resp_supervisor = 17 then 'Conexión Android TV'
				when a.cbo_resp_supervisor = 18 then 'Conexión cable de red'
				when a.cbo_resp_supervisor = 19 then 'Conexión en CTO'
				when a.cbo_resp_supervisor = 20 then 'Conexión HGU'
				when a.cbo_resp_supervisor = 21 then 'Conexión repetidor'
				when a.cbo_resp_supervisor = 22 then 'Conexión STB IPTV'
				when a.cbo_resp_supervisor = 23 then 'Conexión VoIP'
				when a.cbo_resp_supervisor = 24 then 'Configuración Android TV'
				when a.cbo_resp_supervisor = 25 then 'Configuración redes'
				when a.cbo_resp_supervisor = 26 then 'Configuración STB IPTV'
				when a.cbo_resp_supervisor = 27 then 'Configuración VoIP'
				when a.cbo_resp_supervisor = 43 then 'Corte FO'
				when a.cbo_resp_supervisor = 28 then 'CTO sin potencia'
				when a.cbo_resp_supervisor = 29 then 'Disp. no compatible con red 5Ghz'
				when a.cbo_resp_supervisor = 30 then 'Emprendimientos/Country'
				when a.cbo_resp_supervisor = 31 then 'Falla masiva'
				when a.cbo_resp_supervisor = 32 then 'Medición de velocidad'
				when a.cbo_resp_supervisor = 33 then 'No permite ingreso'
				when a.cbo_resp_supervisor = 34 then 'Pidió baja de servicio'
				when a.cbo_resp_supervisor = 35 then 'Problemas con alianzas'
				when a.cbo_resp_supervisor = 36 then 'Refuerzo al técnico'
				when a.cbo_resp_supervisor = 37 then 'Reparó instalación externa'
				when a.cbo_resp_supervisor = 38 then 'Reparó instalación interna'
				when a.cbo_resp_supervisor = 39 then 'Reubicación HGU'
				when a.cbo_resp_supervisor = 40 then 'Reubicación repetidor'
				when a.cbo_resp_supervisor = 41 then 'Servicio ya funcionando'
				when a.cbo_resp_supervisor = 42 then 'Tamaño de la vivienda'
				when a.cbo_resp_supervisor = 43 then 'Corte FO'
				when a.cbo_resp_supervisor = 44 then 'Cliente ausente'
				when a.cbo_resp_supervisor = 45 then 'Configuración BP'
				when a.cbo_resp_supervisor = 46 then 'Desconexión Drop'
				when a.cbo_resp_supervisor = 47 then 'Manipulación de instalación'
				when a.cbo_resp_supervisor = 48 then 'Baja por error'
				when a.cbo_resp_supervisor = 49 then 'Configuración HGU' else '' end as [Motivo supervisor],
		a.sn_anterior,
		a.sn_actual,
		a.reiteros,
		case when a.accion_clooper = 1 then 'Derivado a operaciones'
				when a.accion_clooper = 2 then 'Derivado a redes'
				when a.accion_clooper = 3 then 'Derivado a sistemas'
				when a.accion_clooper = 4 then 'Resuelto por soporte sistemas'
				when a.accion_clooper = 24 then 'Resuelto por soporte sistemas - Derivado a TASA'
				when a.accion_clooper = 5 then 'Funciona OK'
				when a.accion_clooper = 6 then 'Baja en proceso'
				when a.accion_clooper = 27 then 'Cliente no permite ingreso'
				when a.accion_clooper = 7 then 'Despacho provisión'
				when a.accion_clooper = 8 then 'Instrucción en IPTV'
				when a.accion_clooper = 9 then 'Instrucción en Playbox'
				when a.accion_clooper = 10 then 'Instrucción en Redes/Equipos'
				when a.accion_clooper = 11 then 'Instrucción en VoIP'
				when a.accion_clooper = 12 then 'Instrucción test de velocidad'
				when a.accion_clooper = 13 then 'PDR - Regenerar'
				when a.accion_clooper = 14 then 'PDR - Reiniciar'
				when a.accion_clooper = 15 then 'PDR - Reset ONT'
				when a.accion_clooper = 16 then 'PDR - Valores de fabrica'
				when a.accion_clooper = 17 then 'PDR - Ver pruebas de velocidad'
				when a.accion_clooper = 18 then 'PDR - ACS actualización de firmware'
				when a.accion_clooper = 19 then 'PDR - VoIP bootstrap'
				when a.accion_clooper = 20 then 'PDR - VoIP reconfigurar IAD'
				when a.accion_clooper = 21 then 'Resuelto por ATC'
				when a.accion_clooper = 22 then 'SIGRES - Cambio FTTH'
				when a.accion_clooper = 23 then 'SIGRES - VoIP regenerar clave'
				when a.accion_clooper = 25 then 'VERIFICACION EN SISTEMA'
				when a.accion_clooper = 26 then 'FALTA DE LIMPIEZA' end as [Gestión clooper],
		a.respuesta_clooper,
		case when a.reagenda = 0 then 'NO' else 'SI' end as [Reagenda]

from medallia_encuestas as a join usuarios as b
on a.id_clooper = b.id_usr join contratas as c
on a.id_empresa = c.id_contrata left join medallia_cbo_conceptos as d
on a.concepto = d.id_concepto left join medallia_cbo_sub_conceptos as e
on a.subconcepto = e.id_subconcepto left join medallia_cbo_detalle as f
on a.detalle = f.id_detalle left join tecnicos as g
on a.id_recurso = g.id_tecnico