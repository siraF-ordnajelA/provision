alter procedure medallia_exporta_casos

as

SET LANGUAGE Spanish;

declare @fecha as date
set @fecha = dateadd(month, -12, cast(getdate() as date)) -- Resta 1 año

select case when a.motivo = 1 then 'Instalación' else 'Cancelación' end as MOTIVO,
		case when a.contexto = 1 then 'COVID-19' else 'Tradicional' end as CONTEXTO,
		b.apellido + ', ' + b.nombre as CLOOPER,
		datename(month,a.fecha_encuesta) + ' ' + cast(datepart(year,a.fecha_encuesta) as varchar(4)) as [MES ENCUESTA],
		a.fecha_encuesta as [FECHA ENCUESTA],
		a.fecha_mail as [FECHA INICIO CTTA / CIERRE CLOOPER],
		a.fecha_cierre1 as [FECHA CIERRE CTTA],
		datediff (hour, a.fecha_mail, a.fecha_cierre1) as [HS.RESP.CONTRATISTA],
		a.fecha_cierre2 as [FECHA CIERRE CLOOPER],
		datediff (hour, a.fecha_cierre1, fecha_cierre2) as [HS.RESP.CLOOPER],
		a.fecha_cierre3 as [FECHA CIERRE SOPORTE],
		case when a.reagenda = 0 then 'NO' else 'SI' end as [REAGENDADO],
		a.id_encuesta as [ID ENCUESTA],
		c.nombre as [TECNICO],
		c.ctta as [EMPRESA],
		c.dni as [DNI],
		a.nombre as [CLIENTE],
		a.segmento as [SEGMENTO],
		a.direccion as [DOMICILIO],
		--a.id_central,
		g.GERENCIA,
		g.DISTRITO_ATC as DISTRITO,
		a.localidad as [LOCALIDAD],
		a.contacto as [CONTACTO],
		a.nro_orden as [NUMERO DE ORDEN],
		a.access_id as [ACCESS ID],
		a.bucket as [BUCKET],
		case when a.nps = 11 then 'S/D' else cast (a.nps as varchar(3)) end as [NPS],
		case when a.tecnico = 11 then 'S/D' else cast (a.tecnico as varchar(3)) end as [PUNTAJE TECNICO],
		case when a.puntualidad = 11 then 'S/D' else cast (a.puntualidad as varchar(3)) end as [PUNTUALIDAD],
		case when a.profesionalidad = 11 then 'S/D' else cast (a.profesionalidad as varchar(3)) end as [PROFESIONALIDAD],
		case when a.conocimiento = 11 then 'S/D' else cast (a.conocimiento as varchar(3)) end as [CONOCIMIENTO],
		case when a.calidad = 11 then 'S/D' else cast (a.calidad as varchar(3)) end as [CALIDAD],
		case when a.comunicacion = 11 then 'S/D' else cast (a.comunicacion as varchar(3)) end as [COMUNICACION],
		case when a.motivo_detractor = 1 then 'Comercial'
				when a.motivo_detractor = 2 then 'Técnico'
				when a.motivo_detractor = 3 then 'Cliente'
				when a.motivo_detractor = 4 then 'Despacho provisión' end as [MOTIVO DETRACTOR 1ra GESTION],
		d.concepto as [CONCEPTO 1ra GESTION],
		e.sub_concepto as [SUB-CONCEPTO 1ra GESTION],
		f.detalle as [DETALLE 1ra GESTION],
		case when a.motivo_detractor_2 = 1 then 'Comercial'
				when a.motivo_detractor_2 = 2 then 'Técnico'
				when a.motivo_detractor_2 = 3 then 'Cliente'
				when a.motivo_detractor_2 = 4 then 'Despacho provisión' else null end as [MOTIVO DETRACTOR 2da GESTION],
		(select concepto from medallia_cbo_conceptos where id_concepto = a.concepto_2) as [CONCEPTO 2da GESTION],
		(select sub_concepto from medallia_cbo_sub_conceptos where id_subconcepto = a.subconcepto_2) as [SUB-CONCEPTO 2da GESTION],
		(select detalle from medallia_cbo_detalle where id_detalle = a.detalle_2) as [DETALLE 2da GESTION],
		case when a.accion_ejecutada = 1 then 'Derivado a la contrata'
				when a.accion_ejecutada = 2 then 'Derivado a clooper comercial'
				when a.accion_ejecutada = 3 then 'Derivado a soporte sistema'
				when a.accion_ejecutada = 4 then 'Gestionado por clooper'
				when a.accion_ejecutada = 5 then 'Cerrado/No contactado' end as [ACCION EJECUTADA],
		case when a.estado = 1 then 'Cerrado'
				when a.estado = 2 then 'Escalado'
				when a.estado = 3 then 'Pendiente'
				when a.estado = 4 then 'Ecalado/Refuerzo' end as [ESTADO],
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
				when a.accion_clooper = 26 then 'FALTA DE LIMPIEZA' end as [GESTION CLOOPER],
		a.respuesta_clooper as [COMENTARIOS DEL CLOOPER],
		a.comentarios_cliente as [COMENTARIOS DEL CLIENTE],
		(select respuesta from medallia_cbo_respuestas where motivo = a.respuesta_cliente and grupo = 1) as [RESPUESTA CLIENTE],
		(select respuesta from medallia_cbo_respuestas where motivo = a.resp_final_cliente and grupo = 2) as [RESPUESTA FINAL CLIENTE],
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
				when a.cbo_resp_supervisor = 48 then 'BAJA POR ERROR'
				when a.cbo_resp_supervisor = 49 then 'CONFIGURACIÓN HGU' else '' end as [MOTIVO SUPERVISOR],
		a.respuesta_supervisor as [RESPUESTA DEL SUPERVISOR],
		a.sn_anterior as [SERIAL ANTERIOR],
		a.sn_actual as [SERIAL ACTUAL],
		a.tecnologia as [TECNOLOGIA]

from medallia_encuestas as a left join usuarios as b
on a.id_clooper = b.id_usr left join tecnicos as c
on a.id_recurso = c.id_tecnico left join medallia_cbo_conceptos d
on a.concepto = d.id_concepto left join medallia_cbo_sub_conceptos as e
on a.subconcepto = e.id_subconcepto left join medallia_cbo_detalle as f
on a.detalle = f.id_detalle left join centrales2 as g
on a.id_central = g.CENT_ID
where a.fecha_mail >= @fecha
order by a.fecha_mail desc