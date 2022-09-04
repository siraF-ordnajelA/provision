alter procedure av_actualiza_tecnicos
as

-- INSERTO TECNICOS NUEVOS
merge into tecnicos as destino
using (select * from bou.dbo.tecnicos) as origen
on destino.id_tecnico = origen.id_recurso

when not matched then
insert (id_tecnico,
		nombre,
		ctta,
		dni)
values (origen.id_recurso,
		origen.nombre,
		origen.ctta,
		origen.id_toa);

-- COLOCO TODOS A CERO PARA LUEGO ACTUALIZAR LOS QUE ESTAN ACTIVOS
update tecnicos
set activo = 0
		
-- VERIFICO TECNICOS QUE YA NO ESTAN
merge into tecnicos as destino
using (select * from bou.dbo.tecnicos where [id_recurso] <> '') as origen
on destino.id_tecnico = origen.id_recurso

when matched then
update set destino.activo = 1,
			destino.ctta = origen.CTTA;