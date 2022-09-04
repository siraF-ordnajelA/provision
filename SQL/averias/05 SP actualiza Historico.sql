alter procedure actualiza_av_historico
as

--ACTUALIZA TABLA CONTRATAS
merge contratas as destino1
using (select [Empresa que instaló]
		from av_averias
		where [Empresa que instaló] <> ''
		group by [Empresa que instaló]) as origen1

on origen1.[Empresa que instaló] = destino1.descripcion_contrata

when not matched then
insert (descripcion_contrata)
values (origen1.[Empresa que instaló]);

--ACTUALIZA TABLA TECNICOS
/*
merge tecnicos as destino2
using (select [Técnico que instaló]
		from av_averias
		where [Técnico que instaló] <> ''
		group by [Técnico que instaló]) as origen2

on origen2.[Técnico que instaló] = destino2.nombre

when not matched then
insert (nombre)
values (origen2.[Técnico que instaló]);
*/


--ACTUALIZA TABLA SUBTIPO ACTIVIDAD
merge av_subtipo_actividad as destino3
using (select [Subtipo de Actividad]
		from av_averias
		where [Subtipo de Actividad] <> ''
		group by [Subtipo de Actividad]) as origen3

on origen3.[Subtipo de Actividad] = destino3.descrip_subtipo

when not matched then
insert (descrip_subtipo)
values (origen3.[Subtipo de Actividad]);


--ACTUALIZA TABLA CODIGO DE ACTUACION
merge av_cod_actuacion as destino4
using (select [Código de actuación]
		from av_averias
		where [Código de actuación] <> ''
		group by [Código de actuación]) as origen4

on origen4.[Código de actuación] = destino4.descrip_cod_actuacion

when not matched then
insert (descrip_cod_actuacion)
values (origen4.[Código de actuación]);


--ACTUALIZA TABLA SINTOMA
merge av_sintoma as destino5
using (select Síntoma
		from av_averias
		where Síntoma <> ''
		group by Síntoma) as origen5

on origen5.Síntoma = destino5.descrip_sintoma

when not matched then
insert (descrip_sintoma)
values (origen5.Síntoma);


--ACTUALIZA TABLA DIAGNOSTICO
merge av_diagnostico as destino6
using (select [Diagnóstico Inicial]
		from av_averias
		where [Diagnóstico Inicial] <> ''
		group by [Diagnóstico Inicial]) as origen6

on origen6.[Diagnóstico Inicial] = destino6.descrip_diagnostico

when not matched then
insert (descrip_diagnostico)
values (origen6.[Diagnóstico Inicial]);


--ACTUALIZA TABLA DIAGNOSTICO ACTUAL
merge av_diag_actual as destino7
using (select [Diagnóstico Actual]
		from av_averias
		where [Diagnóstico Actual] <> ''
		group by [Diagnóstico Actual]) as origen7

on origen7.[Diagnóstico Actual] = destino7.descrip_diagtual

when not matched then
insert (descrip_diagtual)
values (origen7.[Diagnóstico Actual]);


--ACTUALIZA TABLA CATEGORIA
merge av_categoria as destino8
using (select [Categoría de Capacidad]
		from av_averias
		where [Categoría de Capacidad] <> ''
		group by [Categoría de Capacidad]) as origen8

on origen8.[Categoría de Capacidad] = destino8.descrip_categoria

when not matched then
insert (descrip_categoria)
values (origen8.[Categoría de Capacidad]);


--ACTUALIZA TABLA MULTIPRODUCTO
merge av_multiproducto as destino9
using (select Multiproducto
		from av_averias
		where Multiproducto <> ''
		group by Multiproducto) as origen9

on origen9.Multiproducto = destino9.descrip_multiproducto

when not matched then
insert (descrip_multiproducto)
values (origen9.Multiproducto);


--ACTUALIZA TABLA TIPO DE ACCESO
merge av_tipo_acceso as destino9b
using (select [Tipo de Acceso]
		from av_averias
		where [Tipo de Acceso] <> ''
		group by [Tipo de Acceso]) as origen9b

on origen9b.[Tipo de Acceso] = destino9b.descrip_acceso

when not matched then
insert (descrip_acceso)
values (origen9b.[Tipo de Acceso]);


--ACTUALIZA TABLA TIPO DE CLIENTES
merge av_tipo_cliente as destino10
using (select [Tipo de cliente]
		from av_averias
		where [Tipo de cliente] <> ''
		group by [Tipo de cliente]) as origen10

on origen10.[Tipo de cliente] = destino10.descrip_cliente

when not matched then
insert (descrip_cliente)
values (origen10.[Tipo de cliente]);


--ACTUALIZA TABLA SUBTIPO DE CLIENTES
merge av_subtipo_cliente as destino11
using (select [Subtipo de cliente]
		from av_averias
		where [Subtipo de cliente] <> ''
		group by [Subtipo de cliente]) as origen11

on origen11.[Subtipo de cliente] = destino11.descrip_subcliente

when not matched then
insert (descrip_subcliente)
values (origen11.[Subtipo de cliente]);



--INSERTA HISTORICO
if ((Select CONVERT(nvarchar(2), GETDATE(), 108) AS Hora) < 12)
insert into av_averias_historico (id_contrata,
				id_tecnico,
				id_recurso,
				id_subtipo,
				id_cod,
				Peticion,
				Orden,
				[Access ID],
				id_sintoma,
				id_diag,
				id_diagtual,
				Central,
				[Fecha Instalacion],
				[Fecha Emision],
				[Fecha creacion TOA],
				id_categoria,
				id_multi,
				id_acceso,
				id_tipo_cliente,
				id_subtipo_cliente,
				Fecha)

select contratas.id_contrata,
		tecnicos.id_tecnico,
		av_averias.[ID RECURSO],
		av_subtipo_actividad.id_subtipo,
		av_cod_actuacion.id_cod,
		av_averias.[Número de Petición],
		av_averias.[Número de Orden],
		av_averias.[Access ID],
		av_sintoma.id_sintoma,
		av_diagnostico.id_diag,
		av_diag_actual.id_diagtual,
		av_averias.Central,
		av_averias.Fecha_de_cumplimiento_inst as [Fecha de Instalación],
		av_averias.[Fecha de Emisión/Reclamo],
		av_averias.[Fecha creación TOA],
		av_categoria.id_categoria,
		av_multiproducto.id_multi,
		av_tipo_acceso.id_acceso,-----------------
		av_tipo_cliente.id_cliente as [id tipo cliente],
		av_subtipo_cliente.id_subcliente,
		cast (getdate() as date) as Fecha

from av_averias left join contratas
on av_averias.[Empresa que instaló] = contratas.descripcion_contrata left join tecnicos
on av_averias.[Técnico que instaló] = tecnicos.nombre left join av_subtipo_actividad
on av_averias.[Subtipo de Actividad] = av_subtipo_actividad.descrip_subtipo left join av_cod_actuacion
on av_averias.[Código de actuación] = av_cod_actuacion.descrip_cod_actuacion left join av_sintoma
on av_averias.Síntoma = av_sintoma.descrip_sintoma left join av_diagnostico
on av_averias.[Diagnóstico Inicial] = av_diagnostico.descrip_diagnostico left join av_diag_actual
on av_averias.[Diagnóstico Actual] = av_diag_actual.descrip_diagtual left join av_categoria
on av_averias.[Categoría de Capacidad] = av_categoria.descrip_categoria left join av_multiproducto
on av_averias.Multiproducto = av_multiproducto.descrip_multiproducto left join av_tipo_acceso
on av_averias.[Tipo de Acceso] = av_tipo_acceso.descrip_acceso left join av_tipo_cliente
on av_averias.[Tipo de cliente] = av_tipo_cliente.descrip_cliente left join av_subtipo_cliente
on av_averias.[Subtipo de cliente] = av_subtipo_cliente.descrip_subcliente

else
select 'es la tarde'