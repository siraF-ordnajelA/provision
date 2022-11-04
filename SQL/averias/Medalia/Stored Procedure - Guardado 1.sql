alter procedure medallia_guardado_1
@motivo tinyint,
@contexto tinyint,
@id_clooper smallint,
@id_cliente bigint,
@id_recurso int,
@id_encuesta int,
@fecha varchar(25),
@nombre varchar(150),
@region_mop varchar(25),
@direccion varchar(250),
@localidad varchar(150),
@telefono varchar(11),
@orden varchar(50),
@access varchar(50),
@bucket varchar(150),
@ctta varchar(150),
@nps tinyint,
@tecnico tinyint,
@puntualidad tinyint,
@profesionalismo tinyint,
@conocimiento tinyint,
@calidad tinyint,
@comunicacion tinyint,
@motivo_detractor tinyint,
@concepto tinyint,
@subconcepto tinyint,
@detalle tinyint,
@accion tinyint,
@estado tinyint,
@gest_clooper tinyint,
@coment_cliente varchar(2000),
@resp_cliente tinyint,
@resp_final_cliente tinyint,
@id_cent smallint,
@segmento varchar(11),
@tecnologia varchar(13)

as

declare @contador tinyint
declare @id_ctta smallint

set @contador = (select count(*) from medallia_encuestas where id_encuesta = @id_encuesta)
set @id_ctta = (select id_contrata from contratas where descripcion_contrata = @ctta)

IF (@contador = 0)
BEGIN
insert into medallia_encuestas (motivo,
								contexto,
								id_clooper,
								id_cliente,
								id_recurso,
								id_encuesta,
								fecha_encuesta,
								fecha_mail,
								fecha_cierre1,
								nombre,
								region_mop,
								direccion,
								localidad,
								contacto,
								nro_orden,
								access_id,
								bucket,
								id_empresa,
								nps,
								tecnico,
								puntualidad,
								profesionalidad,
								conocimiento,
								calidad,
								comunicacion,
								motivo_detractor,
								concepto,
								subconcepto,
								detalle,
								accion_ejecutada,
								estado,
								accion_clooper,
								comentarios_cliente,
								respuesta_cliente,
								resp_final_cliente,
								reiteros,
								reagenda,
								id_central,
								segmento,
								tecnologia)
      
values (@motivo,
@contexto,
@id_clooper,
@id_cliente,
@id_recurso,
@id_encuesta,
@fecha,
cast (getdate() as smalldatetime),
case when @estado = 1 then cast (getdate() as smalldatetime) else null end,
@nombre,
@region_mop,
@direccion,
@localidad,
@telefono,
@orden,
@access,
@bucket,
@id_ctta,
@nps,
@tecnico,
@puntualidad,
@profesionalismo,
@conocimiento,
@calidad,
@comunicacion,
@motivo_detractor,
@concepto,
@subconcepto,
@detalle,
@accion,
@estado,
@gest_clooper,
@coment_cliente,
@resp_cliente,
@resp_final_cliente,
0,
0,
@id_cent,
@segmento,
@tecnologia)

select 'Encuesta guardada exitosamente' as mensaje
END

ELSE
BEGIN
select 'Ese ID de encuesta ya existe!' as mensaje;
END

IF (@estado = 4)
BEGIN
insert into mon_medallia_lista(id_medallia, id_recurso, id_usuario, fyhingreso, monitoreado)
values ((select top 1 id_caso from medallia_encuestas order by fecha_mail desc), @id_recurso, @id_clooper, cast(getdate() as smalldatetime), 0);
END