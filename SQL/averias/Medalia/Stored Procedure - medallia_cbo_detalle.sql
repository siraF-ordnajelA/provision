alter procedure medallia_combo_detalle
@id_subconcepto varchar(2)

as

select id_detalle, detalle from medallia_cbo_detalle
where id_subconcepto = @id_subconcepto and activo = 1
order by detalle