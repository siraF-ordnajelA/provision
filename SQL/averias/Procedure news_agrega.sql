alter procedure news_agrega
@titulo varchar (80),
@novedad varchar (500),
@usr_carga varchar (50)
--@video varchar (50)

as

insert into novedades (Fecha, Titulo, Novedad, user_carga, Estado)
values (cast (getdate() as smalldatetime), @titulo, @novedad, @usr_carga, 1)