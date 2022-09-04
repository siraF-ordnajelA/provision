create table medallia_cbo_respuestas (id_concepto smallint identity(1,1) primary key,
										motivo tinyint not null,
										respuesta varchar(150))