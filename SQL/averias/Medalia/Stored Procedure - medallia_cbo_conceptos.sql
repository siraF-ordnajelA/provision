alter procedure medallia_combo_conceptos
@id_motivo varchar(2)

as

select id_concepto, concepto from medallia_cbo_conceptos
where motivo = @id_motivo and activo = 1
order by concepto