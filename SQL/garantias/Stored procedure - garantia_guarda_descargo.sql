alter procedure garantia_guarda_descargo
@id_clooper smallint,
@peticion varchar(50),
@sintoma varchar(80),
@recurso int,
@ctta varchar(50),
@access bigint,
@estado varchar(15),
@subtipo varchar(200),
@central smallint,
@segmento varchar(11),
@tecnologia varchar(12),
@f_ingreso varchar(20),
@f_cierre varchar(20),
@motivo tinyint,
@submotivo smallint,
@respuesta varchar(500),
@sn_anterior varchar(80),
@sn_actual varchar(80)

as

declare @id_ctta tinyint
set @id_ctta = (select id_contrata from contratas where descripcion_contrata = @ctta)

if (@id_ctta is null)
BEGIN
	set @id_ctta = 0
END

insert into garantias_descargo (id_usuario,
								id_recurso,
								id_empresa,
								nro_peticion,
								estado,
								access_id,
								id_central,
								subtipo_actividad,
								fecha_descargo,
								fecha_ingreso,
								fecha_cierre,
								segmento,
								tecnologia,
								comentarios_ctta,
								cbo1_ctta,
								cbo2_ctta,
								trabajado_gestor,
								sintoma,
								sn_anterior,
								sn_actual)
      
values (
@id_clooper,
@recurso,
@id_ctta,
@peticion,
@estado,
@access,
@central,
@subtipo,
cast (getdate() as smalldatetime),
@f_ingreso,
@f_cierre,
@segmento,
@tecnologia,
@respuesta,
@motivo,
@submotivo,
0,
@sintoma,
@sn_anterior,
@sn_actual)

select 'Garantia guardada exitosamente' as mensaje