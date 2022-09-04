create procedure medallia_combo_respuesta
@id_respuesta1 varchar(2)

as

select id_concepto, respuesta from medallia_cbo_respuestas
where motivo = @id_respuesta1