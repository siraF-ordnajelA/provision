create procedure av_elimina_cita
@accessid varchar (25)
as

delete from av_citas
where [Access ID] = @accessid