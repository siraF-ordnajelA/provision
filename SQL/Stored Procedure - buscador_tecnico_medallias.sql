create procedure buscador_tecnico_medallias
@id_tec int

as

select id_caso,
		usuario,
		id_encuesta,
		fecha_encuesta,
		fecha_mail,
		fecha_fin,
		[Acción ejecutada],
		Estado

from lista_medallia_casos
where id_recurso = @id_tec
order by fecha_mail desc