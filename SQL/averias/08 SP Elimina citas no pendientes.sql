--ELIMINA CITAS CUANDO LA AVERIA YA NO ESTA EN EL PENDIENTE
alter procedure av_elimina_citas
as

delete from av_citas
where [N�mero de Petici�n] not in (select [N�mero de Petici�n] from av_averias)