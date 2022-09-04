create table medallia_cbo_sub_conceptos (id_subconcepto tinyint not null primary key identity(1,1),
				id_concepto tinyint null,
				sub_concepto varchar(80) null)