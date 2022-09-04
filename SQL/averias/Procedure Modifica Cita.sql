create procedure modificar_cita
@usuario_cita varchar(50),
@fecha_cita date,
@access varchar (25)
as

update av_citas
set [Fecha gestion cita] = cast (getdate() as date),
	[Fecha Cita Manual] = @fecha_cita,
	usuario_cita = @usuario_cita
where [Access ID] = @access