create procedure news_elimina
@id_novedad int
as

delete from novedades
where id_novedades = @id_novedad;