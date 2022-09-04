select Técnico as [Asignado en TOA],
		Empresa,
		Asignacion,
		[Subtipo de Actividad],
		[Código de actuación],
		[Categoría de Capacidad],
		Averia as [Garantía correcta],
		[Número de Petición],
		[Número de Orden],
		[Access ID],
		Fecha_de_cumplimiento_inst as [Fecha cumplimiento Instalación],
		[Fecha de Emisión/Reclamo],
		[Fecha creación TOA],
		datediff (day, [Fecha creación TOA], cast (getdate() as date)) as [Días TOA],
		[Estado de la orden],
		Multiproducto,
		Síntoma,
		[Diagnóstico Inicial],
		Central,
		[Nombre Central],
		[Bucket Inicial],
		[Tipo de cliente],
		Programacion,
		[Subtipo de Actividad Instalacion],
		[Código de actuación Instalacion],
		[Técnico que instaló],
		[Empresa que instaló],
		[Multiproducto instalado],
		[Tecnologia instalada]		
		
from av_averias

SELECT top 1 av_averias.[Técnico] as [Asignado en TOA],
		                            av_averias.Empresa,
		                            case when av_averias.[Técnico] like '%CTTA' then 'NO ASIGNADO' else 'ASIGNADO' end as Asignacion,
		                            av_averias.[Subtipo de Actividad],
		                            av_averias.[Código de actuación],
		                            av_averias.[Categoría de Capacidad],
		                            case when av_averias.[Subtipo de Actividad] like '%IPTV' and toa_pm.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 'CORRECTO'
				                            when av_averias.[Subtipo de Actividad] not like '%IPTV' and toa_pm.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 'CORRECTO'
				                            when toa_pm.[Subtipo de Actividad] is null then null else 'INCORRECTO' end as [Garantia correcta],
		                            av_averias.[Número de Petición],
		                            av_averias.[Número de Orden],
		                            av_averias.[Access ID],
                                    toa_pm.timestamp as [Fecha cumplimiento Instalación],
		                            av_averias.[Fecha de Emisión/Reclamo],
                                    av_averias.[Fecha creación TOA],
                                    datediff (day, [Fecha creación TOA], cast (getdate() as date)) as [Días TOA],
		                            av_averias.[Estado de la orden],
		                            av_averias.Multiproducto,
		                            av_averias.[Síntoma],
		                            av_averias.[Diagnóstico Inicial],
		                            av_averias.Central,
		                            av_averias.[Nombre Central],
		                            av_averias.[Bucket Inicial],
		                            av_averias.[Tipo de cliente],
		                            av_averias.Programacion,
		                            toa_pm.[Subtipo de Actividad],
		                            toa_pm.[Código de actuación],
		                            toa_pm.Técnico as [Técnico que instaló],
		                            toa_pm.Empresa,
		                            toa_pm.Multiproducto,
		                            toa_pm.Tecnologia
		
                            FROM av_averias left join ATC.dbo.toa_pm as toa_pm
                            on cast (toa_pm.timestamp as date) >= (SELECT min ([Fecha de Emisión/Reclamo]) FROM av_averias) and
	                            toa_pm.alta = 1 and--(toa_pm.[Subtipo de Actividad] like 'i%' or toa_pm.[Subtipo de Actividad] like 'c%') and
	                            av_averias.[Access ID] <> '' and
	                            av_averias.[Access ID] = toa_pm.[Access ID] and
	                            toa_pm.[Estado de la orden] = 'Completado'