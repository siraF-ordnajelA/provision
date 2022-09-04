declare @dias tinyint,
		@fecha_averias_min as date,
		@fecha_inicio_altas date

set @dias = 30


--CREO TABLA TEMPORAL
create table #averias (id int primary key identity (1,1) not null,
	[T�cnico] [varchar](100) NULL,
	[ID RECURSO] smallint NULL,
	[Subtipo de Actividad] [varchar](80) NULL,
	[C�digo de actuaci�n] [varchar](80) NULL,
	[N�mero de Petici�n] [varchar](50) NULL,
	[N�mero de Orden] [varchar](50) NULL,
	[Empresa] [varchar](50) NULL,
	[Fecha de Emisi�n/Reclamo] smalldatetime NULL,
	[Estado de la orden] [varchar](25) NULL,
	[Categor�a de Capacidad] [varchar](100) NULL,
	[Tecnologia Voz] [varchar](20) NULL,
	[Tecnologia Banda Ancha] [varchar](20) NULL,
	[Tecnologia TV] [varchar](20) NULL,
	[Multiproducto] [varchar](50) NULL,
	[Tipo de Acceso] [varchar](10) NULL,
	[Tipo Equipo de Acceso] [varchar](25) NULL,
	[S�ntoma] [varchar](80) NULL,
	[Diagn�stico Inicial] [varchar](100) NULL,
	[Diagn�stico Actual] [varchar](80) NULL,
	[Garant�a] [varchar](3) NULL,
	[Central] smallint NULL,
	[Nombre Central] [varchar](50) NULL,
	[Bucket Inicial] [varchar](80) NULL,
	[Razon de Suspension Instalacion] [varchar](100) NULL,
	[Motivo no realizado instalaci�n] [varchar](150) NULL,
	[Comentarios Tecnico] [nvarchar](max) NULL,
	[Usuario que autorizo el cierre] [varchar](100) NULL,
	[Fecha/Hora de autorizacion del cierre] smalldatetime NULL,
	[Fecha/Hora de autorizacion de la suspension] smalldatetime NULL,
	[Usuario que autorizo la suspension] [varchar](100) NULL,
	[Fecha/Hora de autorizacion del quiebre] smalldatetime NULL,
	[Usuario que Autoriza Informar] [varchar](150) NULL,
	[Access ID] [varchar](25) NULL,
	[Tipo de cliente] [varchar](50) NULL,
	[Subtipo de cliente] [varchar](50) NULL,
	Programacion varchar (15) null,
	Fecha_de_actualizacion smalldatetime null,
	Fecha_de_cumplimiento_insta date null,
	Asignacion varchar(12) null,
	Averia varchar(10) null,
	[Subtipo de Avctividad Instalacion] varchar(80) null,
	[C�digo de actuaci�n Instalacion] varchar(80) null,
	[T�cnico que instal�] varchar(100) null,
	[Empresa que instal�] varchar(50) null,
	[Multiproducto instalado] varchar(50),
	[Tecnolog�a instalada] varchar(50) null,
	[Fecha creaci�n TOA] date null)

--INSERTO AVERIAS ENTRE FECHAS
insert into #averias ([T�cnico],
				[ID RECURSO],
				[Subtipo de Actividad],
				[C�digo de actuaci�n],
				[N�mero de Petici�n],
				[N�mero de Orden],
				[Empresa],
				[Fecha de Emisi�n/Reclamo],
				[Estado de la orden],
				[Categor�a de Capacidad],
				[Tecnologia Voz],
				[Tecnologia Banda Ancha],
				[Tecnologia TV],
				[Multiproducto],
				[Tipo de Acceso],
				[Tipo Equipo de Acceso],
				[S�ntoma],
				[Diagn�stico Inicial],
				[Diagn�stico Actual],
				[Garant�a],
				[Central],
				[Nombre Central],
				[Bucket Inicial],
				[Razon de Suspension Instalacion],
				[Motivo no realizado instalaci�n],
				[Comentarios Tecnico],
				[Usuario que autorizo el cierre],
				[Fecha/Hora de autorizacion del cierre],
				[Fecha/Hora de autorizacion de la suspension],
				[Usuario que autorizo la suspension],
				[Fecha/Hora de autorizacion del quiebre],
				[Usuario que Autoriza Informar],
				[Access ID],
				[Tipo de cliente],
				[Subtipo de cliente],
				Programacion,
				Fecha_de_actualizacion,
				Asignacion,
				[Fecha creaci�n TOA])

select [T�cnico],
				[ID RECURSO],
				[Subtipo de Actividad],
				[C�digo de actuaci�n],
				[N�mero de Petici�n],
				[N�mero de Orden],
				[Empresa],
				[Fecha de Emisi�n/Reclamo],
				[Estado de la orden],
				[Categor�a de Capacidad],
				[Tecnologia Voz],
				[Tecnologia Banda Ancha],
				[Tecnologia TV],
				[Multiproducto],
				[Tipo de Acceso],
				[Tipo Equipo de Acceso],
				[S�ntoma],
				[Diagn�stico Inicial],
				[Diagn�stico Actual],
				[Garant�a],
				[Central],
				[Nombre Central],
				[Bucket Inicial],
				[Razon de Suspension Instalacion],
				[Motivo no realizado instalaci�n],
				[Comentarios Tecnico],
				[Usuario que autorizo el cierre],
				[Fecha/Hora de autorizacion del cierre],
				[Fecha/Hora de autorizacion de la suspension],
				[Usuario que autorizo la suspension],
				[Fecha/Hora de autorizacion del quiebre],
				[Usuario que Autoriza Informar],
				case when [Access ID] is null then [N�mero Tel�fono] else [Access ID] end as [ACCESS ID],
				[Tipo de cliente],
				[Subtipo de cliente],
				Programacion,
				Actualizacion,
				case when Programacion = 'PROGRAMADO' then 'Asignado' else 'No asignado' end,
				[Fecha creacion toa]

from provision_toa
where ([Subtipo de actividad] like 'Reparaci�n%' or
		[Subtipo de actividad] like 'Reacondicionar Inst Interna') and
		[Tipo de Acceso] <> 'Wireless' and
		[Estado de la orden] <> 'Cancelado' and
		[Estado de la orden] <> 'Completado'

--Elimina Duplicados
DELETE T FROM
(SELECT Row_Number() Over(Partition By [Access ID] ORDER BY [Access ID]) AS RowNumber,* FROM #averias) T
WHERE T.RowNumber > 1


--SETETO FECHA INICIO ALTAS
set @fecha_averias_min = (select MIN([Fecha creaci�n TOA]) from #averias)
set @fecha_inicio_altas = DATEADD(day,-@dias,@fecha_averias_min)


--INSERTO INSTALACIONES TEMPORAL
create table #instalaciones (id_averia int not null,
						[Subtipo de Actividad] varchar (80) null,
						codigo_actuacion varchar (80) null,
						--Petici�n varchar (50) NULL,
						Empresa varchar (50) null,
						Tecnico varchar (150) null,
						Access varchar (25) null,
						--Ani varchar (20) null,
						Multiproducto varchar (50) NULL,
						fecha_insta date,
						tecnologia varchar (80) null)

insert into #instalaciones (id_averia,
							[Subtipo de Actividad],
							codigo_actuacion,
							--Petici�n,
							Empresa,
							Tecnico,
							Access,
							--Ani,
							Multiproducto,
							fecha_insta,
							tecnologia)

select a.id,
		b.[Subtipo de Actividad],
		b.[C�digo de actuaci�n],
		--b.[N�mero de Petici�n],
		b.Empresa,
		b.T�cnico,
		b.[Access ID],
		--b.[N�mero Tel�fono],
		b.Multiproducto,
		cast (b.timestamp as date) as timesamp,
		b.tecnologia

from #averias as a left join [10.249.15.194\DATAFLOW].ATC.dbo.toa_pm as b
on a.[Access ID] = b.[ACCESS ID] and
	b.timestamp >= @fecha_inicio_altas and
	b.alta = 1 and
	b.[Estado de la orden] = 'Completado'/* and
	b.[Subtipo de actividad] <> 'Instalar Kit' and
	b.tecnologia <> 'cobre' and
	b.[Tecnologia Banda Ancha] <> 'ADSL2+'*/
	
delete from #instalaciones
where [Subtipo de Actividad] is null

--Elimina Duplicados
DELETE T FROM
(SELECT Row_Number() Over(Partition By id_averia ORDER BY fecha_insta desc) AS RowNumber,* FROM #instalaciones) T
WHERE T.RowNumber > 1


--INSERTO CRUCE INSTALADOS
merge into #averias as destino
using (select * from #instalaciones) as origen

on destino.id = origen.id_averia

when matched then update set
destino.Fecha_de_cumplimiento_insta = origen.fecha_insta,
destino.[Subtipo de Avctividad Instalacion] = origen.[Subtipo de Actividad],
destino.[C�digo de actuaci�n Instalacion] = origen.codigo_actuacion,
destino.[T�cnico que instal�] = origen.Tecnico,
destino.[Empresa que instal�] = origen.[Empresa],
destino.[Multiproducto instalado] = origen.Multiproducto,
destino.[Tecnolog�a instalada] = origen.tecnologia;

--Elimino las no coincidencias
delete from #averias
where [Subtipo de Avctividad Instalacion] is null


--ELIMINO AVERIAS MAYORES A LOS DIAS DEFINIDOS EN LA VARIABLE @dias
delete from #averias
where DATEDIFF(day, Fecha_de_cumplimiento_insta, [Fecha creaci�n TOA]) > @dias


--ETIQUETO AVERIAS CORRECTAS E INCORRECTA
/*
select [Tecnolog�a instalada] from #averias
group by [Tecnolog�a instalada]
order by [Tecnolog�a instalada]

select [Subtipo de Actividad] from #averias
group by [Subtipo de Actividad]
order by [Subtipo de Actividad]
*/
update #averias
set Averia = case when #averias.[Subtipo de Actividad] like '%IPTV' and #averias.[Tecnolog�a instalada] in ('EQUIPO IPTV','fibra+iptv','fibra+box','FTTH+IPTV','iptv') then 'CORRECTO'
				when #averias.[Subtipo de Actividad] like '%FTTH' and #averias.[Tecnolog�a instalada] in ('fibra','fibra+box','fibra+iptv','FTTH+IPTV') then 'CORRECTO'
				when #averias.[Subtipo de Actividad] = 'Reparaci�n STB' and #averias.[Tecnologia Voz] = 'VOIP' then 'CORRECTO'
				when #averias.[Subtipo de Actividad] <> 'Reparaci�n FTTH' and #averias.[Tecnolog�a instalada] in ('cobre','CU') then 'CORRECTO' else 'INCORRECTO' end


--VACIO TABLA DE AVERIAS
delete from [10.249.15.194\DATAFLOW].TELEGESTION.dbo.av_averias


--INSERTO LA TABLA TEMPORAL A LA TABLA DE AVERIAS
insert into [10.249.15.194\DATAFLOW].TELEGESTION.dbo.av_averias ([T�cnico]
      ,[ID RECURSO]
      ,[Subtipo de Actividad]
      ,[C�digo de actuaci�n]
      ,[N�mero de Petici�n]
      ,[N�mero de Orden]
      ,[Empresa]
      ,[Fecha de Emisi�n/Reclamo]
      ,[Estado de la orden]
      ,[Categor�a de Capacidad]
      ,[Tecnologia Voz]
      ,[Tecnologia Banda Ancha]
      ,[Tecnologia TV]
      ,[Multiproducto]
      ,[Tipo de Acceso]
      ,[Tipo Equipo de Acceso]
      ,[S�ntoma]
      ,[Diagn�stico Inicial]
      ,[Diagn�stico Actual]
      ,[Garant�a]
      ,[Central]
      ,[Nombre Central]
      ,[Bucket Inicial]
      ,[Razon de Suspension Instalacion]
      ,[Motivo no realizado instalaci�n]
      ,[Comentarios Tecnico]
      ,[Usuario que autorizo el cierre]
      ,[Fecha/Hora de autorizacion del cierre]
      ,[Fecha/Hora de autorizacion de la suspension]
      ,[Usuario que autorizo la suspension#]
      ,[Fecha/Hora de autorizacion del quiebre]
      ,[Usuario que Autoriza Informar]
      ,[Access ID]
      ,[Tipo de cliente]
      ,[Subtipo de cliente]
      ,[Programacion]
      ,[Fecha_de_actualizacion]
      ,[Fecha_de_cumplimiento_inst]
      ,Asignacion
      ,Averia
      ,[Subtipo de Actividad Instalacion]
      ,[C�digo de actuaci�n Instalacion]
      ,[T�cnico que instal�]
      ,[Empresa que instal�]
      ,[Multiproducto instalado]
      ,[Tecnologia instalada]
      ,[Fecha creaci�n TOA])

select [T�cnico],
	[ID RECURSO],
	[Subtipo de Actividad],
	[C�digo de actuaci�n],
	[N�mero de Petici�n],
	[N�mero de Orden],
	[Empresa],
	[Fecha de Emisi�n/Reclamo],
	[Estado de la orden],
	[Categor�a de Capacidad],
	[Tecnologia Voz],
	[Tecnologia Banda Ancha],
	[Tecnologia TV],
	[Multiproducto],
	[Tipo de Acceso],
	[Tipo Equipo de Acceso],
	[S�ntoma],
	[Diagn�stico Inicial],
	[Diagn�stico Actual],
	[Garant�a],
	[Central],
	[Nombre Central],
	[Bucket Inicial],
	[Razon de Suspension Instalacion],
	[Motivo no realizado instalaci�n],
	[Comentarios Tecnico],
	[Usuario que autorizo el cierre],
	[Fecha/Hora de autorizacion del cierre],
	[Fecha/Hora de autorizacion de la suspension],
	[Usuario que autorizo la suspension],
	[Fecha/Hora de autorizacion del quiebre],
	[Usuario que Autoriza Informar],
	[Access ID],
	[Tipo de cliente],
	[Subtipo de cliente],
	Programacion,
	Fecha_de_actualizacion,
	Fecha_de_cumplimiento_insta,
	Asignacion,
	Averia,
	[Subtipo de Avctividad Instalacion],
	[C�digo de actuaci�n Instalacion],
	[T�cnico que instal�],
	[Empresa que instal�],
	[Multiproducto instalado],
	[Tecnolog�a instalada],
	[Fecha creaci�n TOA]
from #averias