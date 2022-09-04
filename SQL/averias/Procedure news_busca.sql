create procedure news_busca
@id_novedad int
as

select * from novedades
where id_novedades = @id_novedad