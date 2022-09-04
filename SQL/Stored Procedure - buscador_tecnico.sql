alter procedure buscador_tecnico
@tecnico varchar (150)

as

select id_tecnico,
		nombre,
		ctta,
		dni,
		case when activo = 1 then 'SI' else 'NO' end as activo

from tecnicos
where (nombre like '%' + @tecnico + '%' or dni = 'DNI-' + @tecnico) and
		id_tecnico is not null
order by nombre