alter procedure medallia_lista_todos
@opc tinyint

as

-- CERRADOS
IF (@opc = 0)
BEGIN
select medallia_encuestas.id_caso,
		usuarios.apellido + ', ' + usuarios.nombre as usuario,
		medallia_encuestas.id_encuesta,
		medallia_encuestas.access_id,
		tecnicos.nombre,
		tecnicos.ctta,
		medallia_encuestas.fecha_encuesta as fecha_inicio,
		case when fecha_cierre1 is null and fecha_cierre2 is null then fecha_cierre3
				when fecha_cierre1 is null and fecha_cierre2 is not null then fecha_cierre2
				when fecha_cierre1 is not null then fecha_cierre1 end as fecha_cierre

from medallia_encuestas left join usuarios
on medallia_encuestas.id_clooper = usuarios.id_usr left join tecnicos
on medallia_encuestas.id_recurso = tecnicos.id_tecnico
where medallia_encuestas.estado = 1
order by medallia_encuestas.fecha_mail desc
END

-- ESCALADOS CONTRATA
IF (@opc = 1)
BEGIN
select medallia_encuestas.id_caso,
		usuarios.apellido + ', ' + usuarios.nombre as usuario,
		medallia_encuestas.id_encuesta,
		medallia_encuestas.access_id,
		tecnicos.nombre,
		tecnicos.ctta,
		medallia_encuestas.fecha_mail as fecha_inicio,
		case when fecha_cierre1 is null and fecha_cierre2 is null then fecha_cierre3
				when fecha_cierre1 is null and fecha_cierre2 is not null then fecha_cierre2
				when fecha_cierre1 is not null then fecha_cierre1 end as fecha_cierre

from medallia_encuestas left join usuarios
on medallia_encuestas.id_clooper = usuarios.id_usr left join tecnicos
on medallia_encuestas.id_recurso = tecnicos.id_tecnico
where medallia_encuestas.estado = 2 and
		medallia_encuestas.accion_ejecutada = 1 /*and
		(medallia_encuestas.detalle not in (22,41) or
		medallia_encuestas.subconcepto not in (12,13,14,15,16))*/
order by medallia_encuestas.fecha_mail asc
END

-- PENDIENTES CLOOPER
IF (@opc = 2)
BEGIN
select medallia_encuestas.id_caso,
		usuarios.apellido + ', ' + usuarios.nombre as usuario,
		medallia_encuestas.id_encuesta,
		medallia_encuestas.access_id,
		tecnicos.nombre,
		tecnicos.ctta,
		medallia_encuestas.fecha_mail as fecha_inicio,
		case when fecha_cierre1 is null and fecha_cierre2 is null then fecha_cierre3
				when fecha_cierre1 is null and fecha_cierre2 is not null then fecha_cierre2
				when fecha_cierre1 is not null then fecha_cierre1 end as fecha_cierre

from medallia_encuestas left join usuarios
on medallia_encuestas.id_clooper = usuarios.id_usr left join tecnicos
on medallia_encuestas.id_recurso = tecnicos.id_tecnico
where medallia_encuestas.estado = 3 and
		medallia_encuestas.accion_ejecutada <> 3
order by medallia_encuestas.fecha_mail asc
END

-- ESCALADOS SISTEMA
IF (@opc = 3)
BEGIN
select medallia_encuestas.id_caso,
		usuarios.apellido + ', ' + usuarios.nombre as usuario,
		medallia_encuestas.id_encuesta,
		medallia_encuestas.access_id,
		tecnicos.nombre,
		tecnicos.ctta,
		medallia_encuestas.fecha_mail as fecha_inicio,
		case when fecha_cierre1 is null and fecha_cierre2 is null then fecha_cierre3
				when fecha_cierre1 is null and fecha_cierre2 is not null then fecha_cierre2
				when fecha_cierre1 is not null then fecha_cierre1 end as fecha_cierre

from medallia_encuestas left join usuarios
on medallia_encuestas.id_clooper = usuarios.id_usr left join tecnicos
on medallia_encuestas.id_recurso = tecnicos.id_tecnico
where medallia_encuestas.accion_ejecutada = 3
order by medallia_encuestas.fecha_mail asc
END

-- ESCALADOS REFUERZO CTTA
IF (@opc = 4)
BEGIN
select medallia_encuestas.id_caso,
		usuarios.apellido + ', ' + usuarios.nombre as usuario,
		medallia_encuestas.id_encuesta,
		medallia_encuestas.access_id,
		tecnicos.nombre,
		tecnicos.ctta,
		medallia_encuestas.fecha_mail as fecha_inicio,
		case when fecha_cierre1 is null and fecha_cierre2 is null then fecha_cierre3
				when fecha_cierre1 is null and fecha_cierre2 is not null then fecha_cierre2
				when fecha_cierre1 is not null then fecha_cierre1 end as fecha_cierre

from medallia_encuestas left join usuarios
on medallia_encuestas.id_clooper = usuarios.id_usr left join tecnicos
on medallia_encuestas.id_recurso = tecnicos.id_tecnico
where medallia_encuestas.estado = 4 and -- Antes era 2 (estado = Escalado)
		medallia_encuestas.accion_ejecutada = 1 /*and
		(medallia_encuestas.detalle in (22,41) or
		medallia_encuestas.subconcepto in (12,13,14,15,16))*/
order by medallia_encuestas.fecha_mail asc
END