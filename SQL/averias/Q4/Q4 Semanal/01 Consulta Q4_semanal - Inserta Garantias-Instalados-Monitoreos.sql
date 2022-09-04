alter procedure q4s_Semanal_A

as

create table #compa ([Subtipo de Actividad] varchar (80) null, Empresa varchar (50) null, Tecnico varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date, tecnologia varchar (80) null, dupli bit null)
create table #av_temp (id int identity(1,1),[Subtipo de Actividad] varchar (80) null, Orden varchar(30) null, Access varchar (25) null, Ani varchar (20) null, av_fecha date null, tecno varchar(25) null)

declare @fecha date
declare @fecha1 date
declare @fecha2 date
declare @fecha_averias_fin date
declare @fecha_fin_altas date
declare @dias tinyint
declare @sem tinyint

------------------------------------------------------- 2 SEMANAS ATRAS
--SETEA FECHA 2 SEMANAS ATRAS
set @fecha = cast(getdate() as date)
set @fecha1 = (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-8)) -- 2 SEMANAS ATRAS
set @fecha2 = (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-2)) -- 1 SEMANA ATRAS
set @fecha_averias_fin = dateadd(day, 1, @fecha)--cast (getdate() + 1 as date)
set @fecha_fin_altas = dateadd(day, 1, @fecha2)

--SETEA DIAS GARANTIAS
set @dias = 7


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
		toa_pm.[Subtipo de actividad] like 'Reparación%'

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
				when #av_temp.tecno = 'cobre' then 'CORRECTO'
				when #av_temp.access is null then null else 'INCORRECTO' end as Averia,
		1 as Insta,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 1
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 1
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
truncate table #av_temp
truncate table #compa
	
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
create table #instalaciones (id_recurso varchar(15), Instalaciones smallint, tecno varchar (80))

insert into #instalaciones (id_recurso, instalaciones, tecno)

select id_recurso,
		sum(Instalados) as Instalaciones,
		[Tecnologia Instalación]
from #garantias
group by id_recurso, Access, [Tecnologia Instalación]




-- Borro las 2 últimas semanas calculadas de las tablas
delete from Q4s_semanal where fecha1 >= @fecha1
delete from metricas_ctta_semanal where fecha1 >= @fecha1
delete from metricas_tecnico_semanal where fecha1 >= @fecha1

set @sem = 1 + (select case when max(Semana) is null then 0 else max(Semana) end from Q4s_semanal)


--INSERTA DATOS FINALES EN LA TABLA Q4S_semanal
insert into Q4s_semanal (Semana, id_contrata, Tecnico, id_tecnico, Instalaciones, Garantias_7d, Monitoreos, [Monitoreos Apto], tecnologia, fecha1)

select @sem,
		b.id_contrata,
		a.[Tecnico que instaló],
		a.id_recurso,
		sum(a.Instalados) as Instalaciones,
		sum(a.Garantias) as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = a.id_recurso) as Monitoreos,
		(select count(*) from mon_gestionados2 where calificacion = 1 and id_recurso = a.id_recurso) as Monitoreos_aptos,
		a.[Tecnologia Instalación],
		@fecha1

from #garantias as a left join contratas as b
on a.[Empresa que instaló] = b.descripcion_contrata
group by b.id_contrata,
			a.[Tecnico que instaló],
			a.id_recurso,
			a.[Tecnologia Instalación]
order by a.[Tecnico que instaló]

-- PEGA CANTIDAD DE INSTALACIONES CORRECTA
merge into Q4s_semanal as destino
using (select id_recurso,
				count(*) as Instalaciones,
				tecno
		from #instalaciones
		group by id_recurso, tecno) as origen

on origen.id_recurso = destino.id_tecnico and
	origen.tecno = destino.tecnologia and
	destino.fecha1 = @fecha1
	
when matched then
update set
destino.Instalaciones = origen.Instalaciones;




--CALCULO LAS MÉTRICAS DE 2 SEMANAS ATRAS PARA LUEGO SUMARLAS A HISTORICO SI ES PRINCIPIO DE MES
IF((select (DATEPART(day,@fecha_fin_altas)-1)/7 + 1) = 1)
BEGIN
exec q4s_Semanal_B
exec q4s_Semanal_C
exec metricas_inserta_ctta_semanal
exec metricas_inserta_tecnico_semanal

insert into metricas_ctta_semanal_his (
				Semana,
				id_ctta,
				metrica_cumplidas,
				metrica_garantias,
				metrica_garantias_7d,
				metrica_monitoreos,
				metrica_diarias,
				metrica_citas,
				metrica_presentismo,
				tecnologia,
				fecha)

select * from metricas_ctta_semanal

insert into metricas_tecnico_semanal_his (
				Semana,
				id_ctta,
				id_recurso,
				metrica_cumplidas,
				metrica_garantias,
				metrica_garantias_7d,
				metrica_monitoreos,
				metrica_diarias,
				metrica_citas,
				metrica_presentismo,
				tecnologia,
				fecha)

select * from metricas_tecnico_semanal

truncate table Q4s_semanal
truncate table metricas_ctta_semanal
truncate table metricas_tecnico_semanal

set @sem = 1
END

ELSE
BEGIN
-- Seteo el valor de la última semana en la tabla
set @sem = 1 + (select case when max(Semana) is null then 0 else max(Semana) end from Q4s_semanal)
END


------------------------------------------------------- 1 SEMANA ATRAS
truncate table #garantias
truncate table #instalaciones

-- SETEO FECHAS 1 SEMANA ATRAS
set @fecha1 = DATEADD(day,7,@fecha1)
set @fecha2 = DATEADD(day,7,@fecha2)
set @fecha_fin_altas = DATEADD(day,7,@fecha_fin_altas)

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
		toa_pm.[Subtipo de actividad] like 'Reparación%'

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
				when #av_temp.tecno = 'cobre' then 'CORRECTO'
				when #av_temp.access is null then null else 'INCORRECTO' end as Averia,
		1 as Insta,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 1
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 1
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
truncate table #av_temp
truncate table #compa
	
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
insert into #instalaciones (id_recurso, instalaciones, tecno)

select id_recurso,
		sum(Instalados) as Instalaciones,
		[Tecnologia Instalación]
from #garantias
group by id_recurso, Access, [Tecnologia Instalación]




--INSERTA DATOS FINALES EN LA TABLA Q4S_semanal
insert into Q4s_semanal (Semana, id_contrata, Tecnico, id_tecnico, Instalaciones, Garantias_7d, Monitoreos, [Monitoreos Apto], tecnologia, fecha1)

select @sem,
		b.id_contrata,
		a.[Tecnico que instaló],
		a.id_recurso,
		sum(a.Instalados) as Instalaciones,
		sum(a.Garantias) as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = a.id_recurso) as Monitoreos,
		(select count(*) from mon_gestionados2 where calificacion = 1 and id_recurso = a.id_recurso) as Monitoreos_aptos,
		a.[Tecnologia Instalación],
		@fecha1

from #garantias as a left join contratas as b
on a.[Empresa que instaló] = b.descripcion_contrata
group by b.id_contrata,
			a.[Tecnico que instaló],
			a.id_recurso,
			a.[Tecnologia Instalación]
order by a.[Tecnico que instaló]

-- PEGA CANTIDAD DE INSTALACIONES CORRECTA
merge into Q4s_semanal as destino
using (select id_recurso,
				count(*) as Instalaciones,
				tecno
		from #instalaciones
		group by id_recurso, tecno) as origen

on origen.id_recurso = destino.id_tecnico and
	origen.tecno = destino.tecnologia and
	destino.fecha1 = @fecha1
	
when matched then
update set
destino.Instalaciones = origen.Instalaciones;