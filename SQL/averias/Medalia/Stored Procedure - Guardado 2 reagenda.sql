create procedure medallia_guardado_2_reagenda

@id_cas int,
@chk_reagenda tinyint

as

update medallia_encuestas
set fecha_cierre1 = cast(getdate() as smalldatetime),
	reagenda = @chk_reagenda
where id_caso = @id_cas