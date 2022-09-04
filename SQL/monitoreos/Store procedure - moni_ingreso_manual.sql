create procedure mon_ingreso_manual
@id_user int,
@id_recurso int,
@observaciones varchar(1500)

as

insert into mon_medallia_lista (id_recurso,
								id_usuario,
								fyhingreso,
								observaciones,
								monitoreado)
values (@id_recurso, @id_user, cast(getdate() as smalldatetime), @observaciones, 0)