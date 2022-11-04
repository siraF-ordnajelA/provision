alter procedure medallia_busca
@id_cliente varchar(20),
@dni_tecnico varchar(20),
@id_encuesta varchar(20),
@opc_busqueda tinyint

as

if (@opc_busqueda = 1)
select top 1 a.Técnico,
		b.dni,
		a.[ID RECURSO],
		a.Empresa,
		a.[Subtipo de Actividad],
		a.[Código de actuación],
		a.[Número de Petición],
		a.[Número de Orden],
		a.[Access ID],
		a.[Fecha de Emisión Reclamo],
		a.[fecha ingreso TOA],
		a.timestamp as [Fecha cierre],
		a.[Estado de la orden],
		a.Multiproducto,
		a.tecnologia,
		a.alta,
		a.[Bucket Inicial],
		a.[Segmento del cliente],
		a.Nombre,
		a.direccion,
		a.region_mop,
		a.distrito,
		a.central as id_central,
		c.GERENCIA,
		c.DISTRITO_ATC,
		c.cent_descrip_cota as central,
		a.[telefono contacto 1],
		a.[ID de cliente]

from ATC.dbo.toa_pm as a left join tecnicos as b
on a.[ID RECURSO] = b.id_tecnico left join centrales2 as c
on a.central = c.cent_id
where a.[Estado de la orden] = 'Completado' and
		--a.tecnologia like 'fibra%' and
		a.[ID de cliente] = @id_cliente and
		b.dni = 'DNI-' + @dni_tecnico
order by timestamp asc