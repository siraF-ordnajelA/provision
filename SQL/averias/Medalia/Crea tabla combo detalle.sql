create table medallia_cbo_detalle (id_detalle tinyint not null primary key identity(1,1),
				id_subconcepto tinyint null,
				detalle varchar(80) null)