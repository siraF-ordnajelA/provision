alter procedure busca_tecnico
@tec varchar (255)
as

select id_tecnico,
		nombre,
		ctta,
		dni,
		activo,
		'NO' as Ingresante
from tecnicos
where nombre like '%' + @tec + '%' or
		dni = 'DNI-' + @tec

union

select id_ingresante,
		apellido + ' ' + nombre as Nombre,
		ctta,
		dni,
		0 as activo,
		'SI' as Ingresante
from tecnicos_ingresantes
where apellido like '%' + @tec + '%' or
		Nombre like '%' + @tec + '%' or
		dni = @tec
order by nombre