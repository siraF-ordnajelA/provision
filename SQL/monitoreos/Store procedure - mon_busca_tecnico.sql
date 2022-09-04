alter procedure mon_busca_tecnico
@tecnico varchar (150)

as
/*
create table #compa ([Subtipo de Actividad] varchar (80) null, Empresa varchar (50) null, Tecnico varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date, tecnologia varchar (80) null, dupli bit null)
create table #av_temp ([Subtipo de Actividad] varchar (80) null, Ani varchar (20) null, Access varchar (25) null, av_fecha date null, dupli bit null)

declare @fecha1 date
declare @fecha2 date
declare @fecha_averias_fin date
declare @fecha_fin_altas date

set @fecha1 = cast (getdate() - 120 as date)
set @fecha2 = cast (getdate() - 30 as date)
set @fecha_averias_fin = dateadd (day, 31, @fecha2)
set @fecha_fin_altas = dateadd (day, 1, @fecha2) --@fecha2


--INSERTO AVERIAS ENTRE FECHAS
insert into #av_temp ([Subtipo de Actividad], Ani, Access, av_fecha)

select [Subtipo de Actividad],
		case when [Access ID] is null then [Número Teléfono] else null end,
		[Access ID],
		cast (timestamp as date) as fecha

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_averias_fin) and
		toa_pm.[Subtipo de actividad] like 'Reparación%' and
		toa_pm.tecnologia <> 'cobre' and
		[ID RECURSO] = @tecnico
group by [Subtipo de Actividad], [Número Teléfono], [Access ID], timestamp

--ELIMINO DUPLICADOS DE FECHA
--Marco duplicado de menor fecha
merge into #av_temp as destino
using (select access,
				min (av_fecha) as min_fecha

		from #av_temp
		group by access) as origen

on destino.Access = origen.access and
	destino.av_fecha = origen.min_fecha
	
when matched then update
set destino.dupli = 1;

--Marco duplicado de mayor fecha
merge into #av_temp as destino
using (select access
		from #av_temp
		group by access
		having count (access) < 2) as origen

on destino.Access = origen.access

when matched then update
set destino.dupli = 0;

--Elimino
delete from #av_temp
where dupli is null


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
		[ID RECURSO] = @tecnico and
		[Estado de la orden] = 'Completado' and
		[Subtipo de actividad] <> 'Instalar Kit' and
		tecnologia <> 'cobre' and
		[Tecnologia Banda Ancha] <> 'ADSL2+'
		
group by [Subtipo de Actividad], Empresa, Técnico, [ID RECURSO], [Access ID], [Número Teléfono], timestamp, tecnologia
order by Empresa, Técnico



--INSERTO EL CRUDO DE AVERIAS T3
create table #compa2 ([Subtipo de Actividad Insalacion] varchar (80) null, [Empresa que instaló] varchar (50) null, [Tecnico que instaló] varchar (150) null, id_recurso varchar (15) null, Access varchar (25) null, Ani varchar (20) null, Averia varchar (15) null, Instalados tinyint null, Garantias tinyint null, [Fecha instacion] date, [Fecha avería] date, [Subtipo de Actividad Averia] varchar (80) null, Tecnologia varchar (80) null, dupli bit null)

insert into #compa2 ([Subtipo de Actividad Insalacion],
						[Empresa que instaló],
						[Tecnico que instaló],
						id_recurso,
						Access,
						Ani,
						Averia,
						Instalados,
						Garantias,
						Tecnologia,
						[Subtipo de Actividad Averia],
						[Fecha instacion],
						[Fecha avería])

select #compa.[Subtipo de Actividad],
		#compa.Empresa,
		#compa.Tecnico,
		#compa.id_recurso,
		#compa.Access,
		#compa.Ani,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 'CORRECTO'
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 'CORRECTO'
				when #av_temp.access is null then null else 'INCORRECTO' end as Averia,
		1 as Insta,
		case when #av_temp.[Subtipo de Actividad] like '%IPTV' and #compa.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 1
				when #av_temp.[Subtipo de Actividad] not like '%IPTV' and #compa.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 1 else 0 end as Garan,
		#compa.tecnologia,
		#av_temp.[Subtipo de Actividad] as Subtipo_AV,
		#compa.fecha_insta,
		#av_temp.av_fecha

from #compa left join #av_temp
on #compa.Access = #av_temp.Access and
	#compa.fecha_insta < #av_temp.av_fecha
	
drop table #compa--Elimino tabla temporal #COMPA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


--INSERTO EL CRUDO DE AVERIAS COTA
merge into #compa2 as destino
using (select #compa2.[Tecnico que instaló],
				#compa2.Access,
				1 as Gara,
				#av_temp.av_fecha
				
		from #compa2 join #av_temp
		on #compa2.Ani <> '0' and
			#compa2.Ani = #av_temp.Ani and
			#compa2.[Fecha instacion] < #av_temp.av_fecha) as origen

on origen.[Tecnico que instaló] = destino.[Tecnico que instaló] and
	origen.Access = destino.Access
	
when matched then update
set destino.Garantias = origen.Gara,
	destino.[Fecha avería] = origen.av_fecha;


--ELIMINO AVERIAS DE MAS DE 30 DIAS
update #compa2
set Averia = 'INCORRECTO +30',
	Garantias = 0
where [Fecha avería] is not null and
		datediff (day, [Fecha instacion], [Fecha avería]) > 30


--PARA ACCESS DUPLICADOS, MARCO EL MAS NUEVO (Estas son instalaciones que luego se instaló un IPTV o 1 deco adicional y me genera access duplicados). Me quedo con la última instalación para imputar la avería
--Máxima fecha de instalación
merge into #compa2 as destino
using (select access, max ([Fecha instacion]) as f_max
		from #compa2
		where Averia = 'CORRECTO'
		group by access
		having count (access) > 1) as origen

on destino.access = origen.access and
	destino.[Fecha instacion] = origen.f_max
	
when matched then update
set destino.dupli = 1;

--Mínima fecha de instalación
merge into #compa2 as destino
using (select access, min ([Fecha instacion]) as f_min
		from #compa2
		where Averia = 'CORRECTO'
		group by access
		having count (access) > 1) as origen

on destino.access = origen.access and
	destino.[Fecha instacion] = origen.f_min
	
when matched then update
set destino.dupli = 0;
*/

--Saco la ultima fecha de los monitoreos
create table #max_fecha (fechamax smalldatetime, calif tinyint)

insert into #max_fecha (fechamax)
select max(fyhgestion) from mon_gestionados2
where id_recurso = @tecnico

merge into #max_fecha as destino
using (select fyhgestion, calificacion from mon_gestionados2 where id_recurso = @tecnico) as origen

on origen.fyhgestion = destino.fechamax

when matched then update
set destino.calif = origen.calificacion;



--DATOS FINALES
select @tecnico as id_recurso,
		(select top 1 [Nombre del Tecnico] from mon_lista_gestionados_tecnico where id_recurso = @tecnico) as Nombre,
		(select count(*) from mon_gestionados2 where id_recurso = @tecnico) as Monitoreos,
		(select capacitacion from mon_calificaciones where id_capas = (select calif from #max_fecha)) as [Calificacion Promedio]
/*
if ((select count(*) from #compa2) > 0)
BEGIN
select #compa2.[Empresa que instaló],
		#compa2.[Tecnico que instaló],
		sum (#compa2.Instalados) as Instalaciones,
		sum (#compa2.Garantias) as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = #compa2.id_recurso) as Monitoreos,
		(select capacitacion from mon_calificaciones where id_capas = (select calif from #max_fecha)) as [Calificacion Promedio],
		(select @fecha1) as Fecha1,
		(select @fecha2) as Fecha2

from #compa2 left join mon_gestionados2
on #compa2.id_recurso = mon_gestionados2.id_recurso
group by [Empresa que instaló], #compa2.[Tecnico que instaló], #compa2.id_recurso
END

if ((select count(*) from #compa2) = 0 and (select count(*) from mon_gestionados2 where id_recurso = @tecnico) > 0)
BEGIN
select '' as [Empresa que instaló],
		'' as [Tecnico que instaló],
		0 as Instalaciones,
		0 as Garantias,
		(select count(*) from mon_gestionados2 where id_recurso = @tecnico) as Monitoreos,
		(select capacitacion from mon_calificaciones where id_capas = (select calif from #max_fecha)) as [Calificacion Promedio],
		(select @fecha1) as Fecha1,
		(select @fecha2) as Fecha2
END
*/