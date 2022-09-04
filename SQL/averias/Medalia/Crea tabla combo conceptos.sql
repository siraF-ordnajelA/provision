create table medallia_cbo_conceptos (id_concepto smallint identity(1,1) primary key,
										motivo tinyint not null,
										concepto varchar(150))