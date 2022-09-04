alter procedure medallia_combo_subconceptos
@id_concepto varchar(2)

as

select id_subconcepto, sub_concepto from medallia_cbo_sub_conceptos
where id_concepto = @id_concepto and activo = 1
order by sub_concepto