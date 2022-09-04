create table mon_medallia_lista (
		id_medallia int not null,
		id_recurso int not null,
		id_usuario smallint not null,
		fyhingreso smalldatetime null,
		observaciones varchar(1500) null,
		monitoreado bit null)