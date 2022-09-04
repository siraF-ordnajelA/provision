create view averias_historico
as

select contratas.descripcion_contrata as [Contratista que instal�],
		tecnicos.descripcion_tecnico as [T�cnico que Instal�],
		av_averias_historico.id_recurso as [Recurso],
		av_subtipo_actividad.descrip_subtipo as [Subtipo de Actividad],
		av_cod_actuacion.descrip_cod_actuacion as [C�digo de Actuaci�n],
		av_averias_historico.Peticion as [N�mero de Petici�n],
		av_averias_historico.Orden as [N�mero de Orden],
		av_averias_historico.[Access ID],
		av_sintoma.descrip_sintoma as S�ntoma,
		av_diagnostico.descrip_diagnostico as [Diagn�stico Inicial],
		av_diag_actual.descrip_diagtual as [Diagn�stico Actual],
		av_averias_historico.Central,
		av_averias_historico.[Fecha Instalacion],
		av_averias_historico.[Fecha Emision],
		av_averias_historico.[Fecha creacion TOA],
		av_categoria.descrip_categoria as Categor�a,
		av_multiproducto.descrip_multiproducto as Multiproducto,
		av_tipo_acceso.descrip_acceso as [Tipo Acceso],
		av_tipo_cliente.descrip_cliente as [Tipo Cliente],
		av_subtipo_cliente.descrip_subcliente as [Subtipo Cliente],
		av_averias_historico.Fecha

from av_averias_historico left join contratas
on av_averias_historico.id_contrata = contratas.id_contrata left join tecnicos
on av_averias_historico.id_tecnico = tecnicos.id_tecnico left join av_subtipo_actividad
on av_averias_historico.id_subtipo = av_subtipo_actividad.id_subtipo left join av_cod_actuacion
on av_averias_historico.id_cod = av_cod_actuacion.id_cod left join av_sintoma
on av_averias_historico.id_sintoma = av_sintoma.id_sintoma left join av_diagnostico
on av_averias_historico.id_diag = av_diagnostico.id_diag left join av_diag_actual
on av_averias_historico.id_diagtual = av_diag_actual.id_diagtual left join av_categoria
on av_averias_historico.id_categoria = av_categoria.id_categoria left join av_multiproducto
on av_averias_historico.id_multi = av_multiproducto.id_multi left join av_tipo_acceso
on av_averias_historico.id_acceso = av_tipo_acceso.id_acceso left join av_tipo_cliente
on av_averias_historico.id_tipo_cliente = av_tipo_cliente.id_cliente left join av_subtipo_cliente
on av_averias_historico.id_subtipo_cliente = av_subtipo_cliente.id_subcliente