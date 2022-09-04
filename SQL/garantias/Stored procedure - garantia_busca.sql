alter procedure garantia_busca
@peticion varchar(50)

as

IF ((select COUNT(*) from provision_toa where [Número de Petición] = @peticion) > 0)
BEGIN
select top 1 a.[ID RECURSO],
		a.Técnico,
		a.[Empresa],
		a.[Subtipo de Actividad],
		a.[Número de Petición],
		a.[Número de Orden],
		a.[Access ID],
		a.Síntoma,
		case when a.central is null then 0 else a.Central end as central,
		b.CENT_DESCRIP_COTA,
		case when b.DISTRITO_ATC is null then b.DISTRITO_PROV else b.DISTRITO_ATC end as DISTRITO_ATC,
		case when b.GERENCIA is null then b.GAUDI_CIUDAD else b.GERENCIA end as GERENCIA,
		b.AGRUPACION,
		a.[Bucket Inicial],
		a.[Fecha de Emisión/Reclamo],
		a.[Fecha creacion toa],
		a.[Fecha/Hora de autorizacion del cierre],
		a.[Estado de la orden],
		a.[Segmento del cliente],
		--a.alta,
		a.Multiproducto,
		case when a.[Tipo de Acceso] = 'CU' then 'cobre'
				else a.[Tipo de Acceso] end as tecnologia

from provision_toa as a left join Centrales as b
on a.Central = b.CENT_ID
where a.[Número de Petición] = @peticion
order by a.[Fecha creacion toa] desc
END

ELSE IF ((select COUNT(*) from OPENDATASOURCE('SQLOLEDB','Data Source=10.249.15.194\DATAFLOW;User ID=telegestion;Password=telefonica').ATC.dbo.toa_pm where [Número de Petición] = @peticion) > 0)
BEGIN
select top 1 a.[ID RECURSO],
		a.Técnico,
		a.[Empresa],
		a.[Subtipo de Actividad],
		a.[Número de Petición],
		a.[Número de Orden],
		a.[Access ID],
		'' as Síntoma,
		case when a.central is null then 0 else a.Central end as central,
		b.CENT_DESCRIP_COTA,
		case when b.DISTRITO_ATC is null then b.DISTRITO_PROV else b.DISTRITO_ATC end as DISTRITO_ATC,
		case when b.GERENCIA is null then b.GAUDI_CIUDAD else b.GERENCIA end as GERENCIA,
		b.AGRUPACION,
		a.[Bucket Inicial],
		a.[Fecha de Emisión Reclamo] as [Fecha de Emisión/Reclamo],
		a.[fecha ingreso TOA] as [Fecha creacion toa],
		a.TIMESTAMP as [Fecha/Hora de autorizacion del cierre],
		a.[Estado de la orden],
		a.[Segmento del cliente],
		--a.alta,
		a.Multiproducto,
		a.tecnologia

from OPENDATASOURCE('SQLOLEDB','Data Source=10.249.15.194\DATAFLOW;User ID=telegestion;Password=telefonica').ATC.dbo.toa_pm as a left join Centrales as b
on a.Central = b.CENT_ID
where a.[Número de Petición] = @peticion
order by a.[Fecha ingreso TOA] desc
END

ELSE
BEGIN
select top 1 a.[ID RECURSO],
		a.Técnico,
		a.[Empresa],
		a.[Subtipo de Actividad],
		a.[Número de Petición],
		a.[Número de Orden],
		a.[Access ID],
		'' as Síntoma,
		SUBSTRING(Central_Manzana,0,CHARINDEX('_', Central_Manzana)) as Central,
		b.CENT_DESCRIP_COTA,
		case when b.DISTRITO_ATC is null then b.DISTRITO_PROV else b.DISTRITO_ATC end as DISTRITO_ATC,
		case when b.GERENCIA is null then b.GAUDI_CIUDAD else b.GERENCIA end as GERENCIA,
		b.AGRUPACION,
		a.[Bucket Inicial],
		a.[Fecha de Emisión Reclamo] as [Fecha de Emisión/Reclamo],
		a.[fecha ingreso TOA] as [Fecha creacion toa],
		a.TIMESTAMP as [Fecha/Hora de autorizacion del cierre],
		a.[Estado de la orden],
		a.[Segmento del cliente],
		--a.alta,
		a.Multiproducto,
		a.TECNOLOGIA

from toa_ultima as a left join Centrales as b
on SUBSTRING(a.Central_Manzana,0,CHARINDEX('_', a.Central_Manzana)) = b.CENT_ID
where a.[Número de Petición] = @peticion
order by a.[Fecha ingreso TOA] desc
END