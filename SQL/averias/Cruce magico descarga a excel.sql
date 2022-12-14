SELECT av_averias.[T?cnico] as [Asignado en TOA],
		av_averias.Empresa,
		case when av_averias.[T?cnico] like '%CTTA' then 'NO ASIGNADO' else 'ASIGNADO' end as Asignacion,
		av_averias.[Subtipo de Actividad],
		av_averias.[C?digo de actuaci?n],
		av_averias.[Categor?a de Capacidad],
		case when av_averias.[Subtipo de Actividad] like '%IPTV' and toa_pm.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 'CORRECTO'
				when av_averias.[Subtipo de Actividad] not like '%IPTV' and toa_pm.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 'CORRECTO'
				when toa_pm.[Subtipo de Actividad] is null then null else 'INCORRECTO' end as [Garantia correcta],
		av_averias.[N?mero de Petici?n],
		av_averias.[N?mero de Orden],
		av_averias.[Access ID],
		av_averias.[Fecha de Emisi?n/Reclamo],
		av_averias.[Estado de la orden],
		av_averias.Multiproducto,
		av_averias.[S?ntoma],
		av_averias.[Diagn?stico Inicial],
		av_averias.Central,
		av_averias.[Nombre Central],
		av_averias.[Bucket Inicial],
		av_averias.[Tipo de cliente],
		av_averias.Programacion,
		toa_pm.[Subtipo de Actividad],
		toa_pm.[C?digo de actuaci?n],
		toa_pm.T?cnico as [T?cnico que instal?],
		toa_pm.Empresa,
		toa_pm.Multiproducto,
		toa_pm.Tecnologia,
		toa_pm.timestamp as [Fecha cumplimiento Instalaci?n]
		
FROM av_averias left join ATC.dbo.toa_pm as toa_pm
on cast (toa_pm.timestamp as date) >= (SELECT min ([Fecha de Emisi?n/Reclamo]) FROM av_averias) and
	toa_pm.alta = 1 and--(toa_pm.[Subtipo de Actividad] like 'i%' or toa_pm.[Subtipo de Actividad] like 'c%') and
	av_averias.[Access ID] <> '' and
	av_averias.[Access ID] = toa_pm.[Access ID] and
	toa_pm.[Estado de la orden] = 'Completado'

/*
select *
from ATC.dbo.toa_pm
where [Access ID] = 1050311552
*/