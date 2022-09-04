alter procedure busca_user
@usuario varchar(50),
@passo varchar(80)

as

select id_usr,
		usuario_red,
		apellido,
		nombre,
		perfil,
		centro
from usuarios
where usuario_red = @usuario and passo = @passo