create table novedades (id_novedades int not null primary key identity (1,1),
				Fecha smalldatetime not null,
				Titulo varchar (80) null,
				Novedad varchar (500) null,
				Foto varchar (50) null,
				Video varchar (50) null,
				Estado tinyint null)
				