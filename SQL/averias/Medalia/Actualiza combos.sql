select * from medallia_cbo_conceptos order by concepto
select * from medallia_cbo_sub_conceptos order by sub_concepto
select * from medallia_cbo_detalle order by detalle


select * from medallia_cbo_conceptos where motivo = 4 order by concepto
select * from medallia_cbo_sub_conceptos where id_concepto in (15) order by sub_concepto
select * from medallia_cbo_detalle where id_subconcepto = 67 order by detalle

/*
insert into medallia_cbo_conceptos (motivo, concepto, activo)
values (3,'Período de prueba', 1),
		(3,'Inconvenientes en domicilio del cliente', 1),
		(3,'Error en la contestación de encuesta', 1),
		(3,'Solicitó baja del servicio', 1),
		(3,'Método instalación CoVid-19', 1),
		(3,'Encontrado OK', 1),
		(43,'-', 1),
		(44,'-', 1)

insert into medallia_cbo_sub_conceptos (id_concepto, sub_concepto, activo)
values (15,'Falta de material', 1),
		(28,'Conforme con el servicio', 1),
		(27,'No permite el ingreso', 1),
		(27,'Ingreso sin protocolo sanitario', 1),
		(27,'Manipulación de equipos', 1),
		(27,'Manipulación instalación', 1),
		(27,'Dispositivos móviles', 1),
		(30,'Explicación/Acepta', 1),
		(26,'Conforme con el servicio', 1),
		(26,'Por el momento no opina', 1),
		(29,'No permite ingreso del técnico', 1),
		(29,'Tiempo de espera técnico', 1)

insert into medallia_cbo_detalle (id_subconcepto, detalle, activo)
values (67,'STB', 1),
		(67,'Drops', 1),
		(67,'HGU', 1),
		(54,'STB', 1),
		(55,'-', 1),
		(51,'-', 1),
		(52,'-', 1),
		(53,'-', 1),
		(50,'-', 1),
		(58,'-', 1),
		(57,'-', 1),
		(59,'-', 1)

		
update medallia_cbo_conceptos
set activo = 0
where id_concepto in (11)

update medallia_cbo_sub_conceptos
set activo = 0
where id_concepto = 15

update medallia_cbo_detalle
set activo = 0
where id_subconcepto in (17,19,47,35,18,37,20,36)
*/