alter procedure q4s_7d_A_actualiza_gar_mon_inst
@opc tinyint
/*
1 = MES COMPLETO
2 = MES ANTERIOR
3 = MES ACTUAL
*/
as

create table #compa ([Subtipo de Actividad] varchar (80) null, Empresa varchar (50) null, Tecnico varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, cent_id smallint null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date, tecnologia varchar (80) null, dupli bit null)
create table #av_temp (id int identity(1,1),[Subtipo de Actividad] varchar (80) null, Orden varchar(30) null, Access varchar (25) null, Ani varchar (20) null, cent_id smallint null, av_fecha date null, tecno varchar(25) null)

declare @fecha1 date
declare @fecha2 date
declare @fecha_averias_fin date
declare @fecha_fin_altas date
declare @dias tinyint

-- MES COMPLETO
IF (@opc = 1)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL
set @fecha2 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--MES ANTERIOR
set @fecha_averias_fin = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000108')) as date)--MES ANTERIOR + 7 dias
set @fecha_fin_altas = @fecha2
END

-- MES ANTERIOR
ELSE IF (@opc = 2)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
set @fecha2 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--MES ACTUAL
set @fecha_averias_fin = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000108')) as date)--MES ACTUAL + 7 dias
set @fecha_fin_altas = @fecha2
END

-- MES ACTUAL
ELSE IF (@opc = 3)
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO MES ACTUAL
set @fecha2 = cast (getdate() as date) --FECHA ACTUAL
set @fecha_averias_fin = @fecha2
set @fecha_fin_altas = @fecha2
END

-- ELIMINA DATOS INCOMPLETOS
delete from Q4s_7d
where Fecha = @fecha1

--SETEA DIAS GARANTIAS
set @dias = 7


--INSERTO AVERIAS ENTRE FECHAS
insert into #av_temp ([Subtipo de Actividad], Orden, Ani, cent_id, Access, av_fecha, tecno)

select [Subtipo de Actividad],
		[Número de Orden],
		case when [Access ID] is null then [Número Teléfono] else null end,
		central,
		[Access ID],
		cast (timestamp as date) as fecha,
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_averias_fin) and
		toa_pm.[Subtipo de actividad] like 'Reparación%'

--Elimino duplicados de Número de Orden para dejar averías por access
DELETE T FROM
	(SELECT Row_Number() Over(Partition By Orden ORDER BY Orden) AS RowNumber,* FROM #av_temp) T
	WHERE T.RowNumber > 1


--INSERTO INSTALADOS ENTRE FECHAS
insert into #compa ([Subtipo de Actividad], Empresa, Tecnico, id_recurso, Access, Ani, cent_id, Instalados, fecha_insta, tecnologia)

select [Subtipo de Actividad],
		Empresa,
		Técnico,
		[ID RECURSO],
		[Access ID],
		[Número Teléfono],
		central,
		count (*) Instalados,
		cast (timestamp as date),
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_fin_altas) and
		alta = 1 and
		[Estado de la orden] = 'Completado'
group by [Subtipo de Actividad], Empresa, Técnico, [ID RECURSO], [Access ID], [Número Teléfono], central, timestamp, tecnologia


--CREO TABLA FINAL GARANTIAS
create table #garantias ([Subtipo de Actividad Insalacion] varchar (80) null, [Empresa que instaló] varchar (50) null, [Tecnico que instaló] varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, cent_id smallint null, [Tecnologia Instalación] varchar (80) null, Averia varchar (15) null, Instalados tinyint null, Garantias tinyint null, [Fecha instalacion] date, [Fecha avería] date, [Subtipo de Actividad Averia] varchar (80) null, [Orden Averia] varchar (50) null, [Tecnologia Averia] varchar (80) null, dupli bit null)

--INSERTO EL CRUDO DE AVERIAS T3
insert into #garantias ([Subtipo de Actividad Insalacion],
						[Empresa que instaló],
						[Tecnico que instaló],
						id_recurso,
						Access,
						Ani,
						cent_id,
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
		case when #compa.cent_id is null then #av_temp.cent_id else #compa.cent_id end,
		#compa.tecnologia,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv','fibra+box') then 'CORRECTO'
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV','fibra+box') then 'CORRECTO'
				when #av_temp.tecno = 'cobre' then 'CORRECTO'
				when #av_temp.access is null then null else 'INCORRECTO' end as Averia,
		1 as Insta,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv','fibra+box') then 1
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV','fibra+box') then 1
				when #av_temp.tecno = 'cobre' then 1 else 0 end as Garan,
		#av_temp.[Subtipo de Actividad] as Subtipo_AV,
		#av_temp.Orden,
		#compa.fecha_insta,
		#av_temp.av_fecha,
		#av_temp.tecno

from #compa left join #av_temp
on #compa.Access = #av_temp.Access /*and
	#compa.fecha_insta < #av_temp.av_fecha*/

--Elimino tablas temporales!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
drop table #av_temp
drop table #compa
	
--Marco averias anteriores a la fecha de instalación
update #garantias
set Averia = 'INCORRECTO -0',
	Garantias = 0
where datediff(day, [Fecha instalacion], [Fecha avería]) < 0

--Marco los Mayores a 7 días
update #garantias
set Averia = 'INCORRECTO +7', Garantias = 0
where datediff(day, [Fecha instalacion], [Fecha avería]) > @dias

--CALCULO CANTIDAD DE INSTALACIONES (Ya que se duplican por los reiteros)
create table #instalaciones (id_recurso varchar(15), cent_id smallint, Instalaciones smallint, tecno varchar (80))

insert into #instalaciones (id_recurso, cent_id, instalaciones, tecno)

select id_recurso,
		cent_id,
		sum(Instalados) as Instalaciones,
		[Tecnologia Instalación]
from #garantias
group by id_recurso, cent_id, Access, [Tecnologia Instalación]




--INSERTA DATOS FINALES EN LA TABLA Q4S_7d
insert into Q4s_7d (id_contrata, Tecnico, id_tecnico, Instalaciones, Garantias, Monitoreos, [Monitoreos Apto], tecnologia, central, Fecha)

select b.id_contrata,
		a.[Tecnico que instaló],
		a.id_recurso,
		sum(a.Instalados) as Instalaciones,
		sum(a.Garantias) as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = a.id_recurso) as Monitoreos,
		(select count(*) from mon_gestionados2 where calificacion = 1 and id_recurso = a.id_recurso) as Monitoreos_aptos,
		a.[Tecnologia Instalación],
		a.cent_id,
		@fecha1 as Fecha1

from #garantias as a left join contratas as b
on a.[Empresa que instaló] = b.descripcion_contrata
group by b.id_contrata,
			a.[Tecnico que instaló],
			a.id_recurso,
			a.cent_id,
			a.[Tecnologia Instalación]
order by a.[Tecnico que instaló]

-- PEGA CANTIDAD DE INSTALACIONES CORRECTA
merge into Q4s_7d as destino
using (select id_recurso,
				cent_id,
				count(*) as Instalaciones,
				tecno
		from #instalaciones
		group by id_recurso, cent_id, tecno) as origen

on origen.id_recurso = destino.id_tecnico and
	origen.tecno = destino.tecnologia and
	destino.Fecha = @fecha1 and
	origen.cent_id = destino.central
	
when matched then
update set
destino.Instalaciones = origen.Instalaciones;