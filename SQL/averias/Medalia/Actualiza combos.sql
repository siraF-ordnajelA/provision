select * from medallia_cbo_conceptos order by concepto
select * from medallia_cbo_sub_conceptos order by sub_concepto
select * from medallia_cbo_detalle order by detalle


select * from medallia_cbo_conceptos where motivo = 3 order by concepto
select * from medallia_cbo_sub_conceptos where id_concepto in (31,28,27,30,26,12,29) order by sub_concepto
select * from medallia_cbo_detalle where id_subconcepto = 12 order by detalle

select * from medallia_cbo_detalle where detalle = 'DA�OS EN LA INSTALACI�N'

/*
insert into medallia_cbo_conceptos (motivo, concepto, activo)
values (3,'Per�odo de prueba', 1),
		(3,'Inconvenientes en domicilio del cliente', 1),
		(3,'Error en la contestaci�n de encuesta', 1),
		(3,'Solicit� baja del servicio', 1),
		(3,'M�todo instalaci�n CoVid-19', 1),
		(3,'Encontrado OK', 1),
		(43,'-', 1),
		(44,'-', 1)

insert into medallia_cbo_sub_conceptos (id_concepto, sub_concepto, activo)
values (31,'Conforme con el servicio', 1),
		(28,'Conforme con el servicio', 1),
		(27,'No permite el ingreso', 1),
		(27,'Ingreso sin protocolo sanitario', 1),
		(27,'Manipulaci�n de equipos', 1),
		(27,'Manipulaci�n instalaci�n', 1),
		(27,'Dispositivos m�viles', 1),
		(30,'Explicaci�n/Acepta', 1),
		(26,'Conforme con el servicio', 1),
		(26,'Por el momento no opina', 1),
		(29,'No permite ingreso del t�cnico', 1),
		(29,'Tiempo de espera t�cnico', 1)

insert into medallia_cbo_detalle (id_subconcepto, detalle, activo)
values (12,'Da�os en la instalaci�n', 1),
		(49,'-', 1),
		(56,'-', 1),
		(54,'-', 1),
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
where id_concepto = 12

update medallia_cbo_detalle
set activo = 0
where id_subconcepto in (17,19,47,35,18,37,20,36)
*/