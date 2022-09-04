create table #compa ([Subtipo de Actividad] varchar (80) null, Empresa varchar (50) null, Tecnico varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date, tecnologia varchar (80) null, dupli bit null)
create table #av_temp (id int identity(1,1),[Subtipo de Actividad] varchar (80) null, Orden varchar(30) null, Access varchar (25) null, Ani varchar (20) null, av_fecha date null, tecno varchar(25) null)

declare @fecha1 date
declare @fecha2 date
declare @fecha_averias_fin date
declare @fecha_fin_altas date
declare @dias tinyint

--SETEA FECHA 1 MES ATRAS
set @fecha1 = '20210701'--select cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL
set @fecha2 = '20210801'--select cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
set @fecha_averias_fin = '20210901'--select cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--MES ACTUAL
set @fecha_fin_altas = @fecha2

--SETEA DIAS GARANTIAS
set @dias = 30


--INSERTO AVERIAS ENTRE FECHAS
insert into #av_temp ([Subtipo de Actividad], Orden, Ani, Access, av_fecha, tecno)

select [Subtipo de Actividad],
		[Número de Orden],
		case when [Access ID] is null then [Número Teléfono] else null end,
		[Access ID],
		cast (timestamp as date) as fecha,
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_averias_fin) and
		toa_pm.[Subtipo de actividad] like 'Reparación%' /*and
		toa_pm.tecnologia <> 'cobre'
group by [Subtipo de Actividad], [Número de Orden], [Número Teléfono], [Access ID], cast (timestamp as date)*/

--Elimino duplicados de Número de Orden para dejar averías por access
DELETE T FROM
	(SELECT Row_Number() Over(Partition By Orden ORDER BY Orden) AS RowNumber,* FROM #av_temp) T
	WHERE T.RowNumber > 1


--INSERTO INSTALADOS ENTRE FECHAS
insert into #compa ([Subtipo de Actividad], Empresa, Tecnico, id_recurso, Access, Ani, Instalados, fecha_insta, tecnologia)

select [Subtipo de Actividad],
		Empresa,
		Técnico,
		[ID RECURSO],
		[Access ID],
		[Número Teléfono],
		count (*) Instalados,
		cast (timestamp as date),
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_fin_altas) and
		alta = 1 and
		[Estado de la orden] = 'Completado'
group by [Subtipo de Actividad], Empresa, Técnico, [ID RECURSO], [Access ID], [Número Teléfono], timestamp, tecnologia


--CREO TABLA FINAL GARANTIAS
create table #garantias ([Subtipo de Actividad Insalacion] varchar (80) null, [Empresa que instaló] varchar (50) null, [Tecnico que instaló] varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, [Tecnologia Instalación] varchar (80) null, Averia varchar (15) null, Instalados tinyint null, Garantias tinyint null, [Fecha instalacion] date, [Fecha avería] date, [Subtipo de Actividad Averia] varchar (80) null, [Orden Averia] varchar (50) null, [Tecnologia Averia] varchar (80) null, dupli bit null)

--INSERTO EL CRUDO DE AVERIAS T3
insert into #garantias ([Subtipo de Actividad Insalacion],
						[Empresa que instaló],
						[Tecnico que instaló],
						id_recurso,
						Access,
						Ani,
						[Tecnologia Instalación],
						Averia,
						Instalados,
						Garantias,
						[Subtipo de Actividad Averia],
						[Orden averia],
						[Fecha instalacion],
						[Fecha avería],
						[Tecnologia Averia])

select #compa.[Subtipo de Actividad],
		#compa.Empresa,
		#compa.Tecnico,
		#compa.id_recurso,
		#compa.Access,
		#compa.Ani,
		#compa.tecnologia,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv','fibra+iptv') then 'CORRECTO'
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV','fibra+box') then 'CORRECTO'
				when #av_temp.access is null then null else 'INCORRECTO' end as Averia,
		1 as Insta,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 1
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 1 else 0 end as Garan,
		#av_temp.[Subtipo de Actividad] as Subtipo_AV,
		#av_temp.Orden,
		#compa.fecha_insta,
		#av_temp.av_fecha,
		#av_temp.tecno

from #compa left join #av_temp
on #compa.Access = #av_temp.Access /*and
	#compa.fecha_insta < #av_temp.av_fecha*/
	
--Elimino tablas temporales!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
drop table #compa
drop table #av_temp

--Elimino las averias anteriores a la fecha de instalación
delete from #garantias
where datediff(day, [Fecha instalacion], [Fecha avería]) < 0

--Marco los Mayores a 30 días
update #garantias
set Averia = 'INCORRECTO +30', Garantias = 0
where datediff(day, [Fecha instalacion], [Fecha avería]) > @dias




--INSERTA DATOS FINALES EN LA TABLA Q4S_30d
insert into Q4s_30d (id_contrata, Tecnico, id_tecnico, Instalaciones, Garantias, Monitoreos, [Monitoreos Apto], Fecha)

select b.id_contrata,
		a.[Tecnico que instaló],
		a.id_recurso,
		sum(a.Instalados) as Instalaciones,
		sum(a.Garantias) as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = a.id_recurso) as Monitoreos,
		(select count(*) from mon_gestionados2 where calificacion = 1 and id_recurso = a.id_recurso) as Monitoreos_aptos,
		@fecha1 as Fecha1

from #garantias as a left join contratas as b
on a.[Empresa que instaló] = b.descripcion_contrata
group by b.id_contrata,
			a.[Tecnico que instaló],
			a.id_recurso
order by a.[Tecnico que instaló]