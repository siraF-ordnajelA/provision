--9 TABLAS RELACIONALES
create table av_subtipo_actividad (id_subtipo int not null primary key identity (1,1), descrip_subtipo varchar (80) not null)

create table av_cod_actuacion (id_cod int not null primary key identity (1,1), descrip_cod_actuacion varchar (80) not null)

create table av_sintoma (id_sintoma int not null primary key identity (1,1), descrip_sintoma varchar (80) not null)

create table av_diagnostico (id_diag int not null primary key identity (1,1), descrip_diagnostico varchar (100) not null)

create table av_diag_actual (id_diagtual int not null primary key identity (1,1), descrip_diagtual varchar (80) not null)

create table av_categoria (id_categoria int not null primary key identity (1,1), descrip_categoria varchar (100) not null)

create table av_multiproducto (id_multi int not null primary key identity (1,1), descrip_multiproducto varchar (50) not null)

create table av_tipo_acceso (id_acceso int not null primary key identity (1,1), descrip_acceso varchar (80) not null)

create table av_tipo_cliente (id_cliente int not null primary key identity (1,1), descrip_cliente varchar (50) not null)

create table av_subtipo_cliente (id_subcliente tinyint not null primary key identity (1,1), descrip_subcliente varchar (50) not null)

--select * from av_tipo_acceso

--TABLA HISTORICO
create table av_averias_historico (id_historico int not null primary key identity (1,1),
				id_contrata tinyint null,
				id_tecnico int null,
				id_recurso smallint null,
				id_subtipo tinyint null,
				id_cod tinyint null,
				Peticion varchar (50) null,
				Orden varchar (50) null,
				[Access ID] varchar (25) null,
				id_sintoma tinyint null,
				id_diag tinyint null,
				id_diagtual tinyint null,
				Central smallint null,
				[Fecha Instalacion] date null,
				[Fecha Emision] date null,
				[Fecha creacion TOA] date null,
				id_categoria tinyint null,
				id_multi tinyint null,
				id_acceso tinyint null,
				id_tipo_cliente tinyint null,
				id_subtipo_cliente tinyint null,
				Fecha date not null)