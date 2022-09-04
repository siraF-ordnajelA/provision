alter procedure news_modifica
@titulo varchar (80),
@novedad varchar (500),
@usr_carga varchar (50),
@id_new int
--@video varchar (50)

as

update novedades
set Fecha = cast (getdate() as smalldatetime),
	Titulo = @titulo,
	Novedad = @novedad,
	user_carga = @usr_carga
	
where id_novedades = @id_new