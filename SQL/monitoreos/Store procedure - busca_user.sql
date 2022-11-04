alter procedure busca_user
@usuario varchar(50),
@passo varchar(80)

as

select usuarios.id_usr,
		usuarios.usuario_red,
		usuarios.apellido,
		usuarios.nombre,
		usuarios.perfil,
		usuarios.centro,
		contratas.id_contrata
from usuarios left join contratas
on usuarios.centro = contratas.descripcion_contrata
where usuarios.usuario_red = @usuario and passo = @passo