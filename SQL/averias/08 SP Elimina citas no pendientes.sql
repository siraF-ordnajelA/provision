--ELIMINA CITAS CUANDO LA AVERIA YA NO ESTA EN EL PENDIENTE
alter procedure av_elimina_citas
as

delete from av_citas
where [Número de Petición] not in (select [Número de Petición] from av_averias)