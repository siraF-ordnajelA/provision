create procedure inserta_garantias_mensuales
as

declare @fecha1 date
declare @fecha2 date
declare @dias tinyint

set @fecha1 = cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL
set @fecha2 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
set @dias = 30

create table #compa ([Subtipo de Actividad] varchar (80) null, codigo_actuacion varchar (80) null, Empresa varchar (50) null, Tecnico varchar (150) null, Access varchar (25) null, Ani varchar (20) null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date, tecnologia varchar (80) null, dupli bit null)
create table #av_temp ([Subtipo de Actividad] varchar (80) null, Ani varchar (20) null, Access varchar (25) null, av_fecha date null, dupli bit null)

declare @fecha_averias_fin date
declare @fecha_fin_altas date

set @fecha_averias_fin = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--PRIMER DIA DEL MES ACTUAL
set @fecha_fin_altas = @fecha2

--SELECT @fecha1 as Fecha_1, @fecha2 as Fecha_2, @fecha_averias_fin as Fecha_Av_Fin, @fecha_fin_altas as Fecha_Altas_Fin
--INSERTO AVERIAS ENTRE FECHAS
insert into #av_temp ([Subtipo de Actividad], Ani, Access, av_fecha)

select [Subtipo de Actividad],
		case when [Access ID] is null then [Número Teléfono] else null end,
		[Access ID],
		cast (timestamp as date) as fecha

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_averias_fin) and
		toa_pm.[Subtipo de actividad] like 'Reparación%' and
		toa_pm.tecnologia <> 'cobre'
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
insert into #compa ([Subtipo de Actividad], codigo_actuacion, Empresa, Tecnico, Access, Ani, Instalados, fecha_insta, tecnologia)

select [Subtipo de Actividad],
		[Código de actuación],
		Empresa,
		Técnico,
		[Access ID],
		[Número Teléfono],
		count (*) Instalados,
		cast (timestamp as date),
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_fin_altas) and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		[Subtipo de actividad] <> 'Instalar Kit' and
		tecnologia <> 'cobre' and
		[Tecnologia Banda Ancha] <> 'ADSL2+'
		
group by [Subtipo de Actividad], [Código de actuación], Empresa, Técnico, [Access ID], [Número Teléfono], timestamp, tecnologia
order by Empresa, Técnico



--INSERTO EL CRUDO DE AVERIAS T3
create table #compa2 ([Subtipo de Actividad Insalacion] varchar (80) null, codigo_actuacion varchar (80) null, [Empresa que instaló] varchar (50) null, [Tecnico que instaló] varchar (150) null, Access varchar (25) null, Ani varchar (20) null, Averia varchar (15) null, Instalados tinyint null, Garantias tinyint null, [Fecha instacion] date, [Fecha avería] date, [Subtipo de Actividad Averia] varchar (80) null, Tecnologia varchar (80) null, dupli bit null)

insert into #compa2 ([Subtipo de Actividad Insalacion],
						codigo_actuacion,
						[Empresa que instaló],
						[Tecnico que instaló],
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
		#compa.codigo_actuacion,
		#compa.Empresa,
		#compa.Tecnico,
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


--ELIMINO LOS DIAS NEGATIVOS Y DIAS MAYORES A 7 o 30 SEGUN CONSULTA
update #compa2
set Averia = case when @dias = 7 then 'INCORRECTO +7'
					when @dias = 30 then 'INCORRECTO +30' end,
	Garantias = 0
where [Fecha avería] is not null and
		datediff (day, [Fecha instacion], [Fecha avería]) > @dias


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


--COLOCO A CERO LOS NULLS
update #compa2
set Instalados = 0
where Instalados is null

update #compa2
set Garantias = 0
where Garantias is null

drop table #av_temp --Elimino tabla temporal #AV_TEMP!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!












--INSERTA EN EL MES DE NOVIEMBRE
if ((select datename (month, getdate())) = 'Enero')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = (datepart (year, getdate()))-1

when matched then update set
destino.Noviembre = origen.Porcentaje

when not matched then
insert (Empresa, Noviembre)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = (datepart (year, getdate()))-1

when matched then update set
destino.Noviembre = origen.Porcentaje;

update av_garantias_historico
set Noviembre = 0
where Noviembre is null
end

--INSERTA EN EL MES DE DICIEMBRE
if ((select datename (month, getdate())) = 'Febrero')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = (datepart (year, getdate()))-1

when matched then update set
destino.Diciembre = origen.Porcentaje

when not matched then
insert (Empresa, Diciembre)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = (datepart (year, getdate()))-1

when matched then update set
destino.Diciembre = origen.Porcentaje;

update av_garantias_historico
set Diciembre = 0
where Diciembre is null
end


--INSERTA EN EL MES DE ENERO--------------------------------------------------------------------------------------------
if ((select datename (month, getdate())) = 'Marzo')
begin
insert into av_garantias_historico (Empresa, anio)
values ('VALTELLINA', datepart (year, getdate())),
('RETESAR', datepart (year, getdate())),
('ARGENCOBRA', datepart (year, getdate())),
('ERB S.A.', datepart (year, getdate())),
('TEAMTEL', datepart (year, getdate())),
('NG', datepart (year, getdate())),
('TASA NEG', datepart (year, getdate())),
('RADIOTRONICA', datepart (year, getdate())),
('TECN Y CABLEADOS SA', datepart (year, getdate())),
('DOMINION BAIRES SA', datepart (year, getdate())),
('TASA', datepart (year, getdate())),
('PLANTEL', datepart (year, getdate())),
('COMFICA ARGENTINA', datepart (year, getdate())),
('GLOBAL', datepart (year, getdate()))

update av_garantias_historico
set febrero = 0,
	marzo = 0,
	abril = 0,
	mayo = 0,
	junio = 0,
	julio = 0,
	agosto = 0,
	septiembre = 0,
	octubre = 0,
	noviembre = 0,
	diciembre = 0
where Anio = datepart (year, getdate())



merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Enero = origen.Porcentaje

when not matched then
insert (Empresa, Enero)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Enero = origen.Porcentaje;

update av_garantias_historico
set Enero = 0
where Enero is null
end

--INSERTA EN EL MES DE FEBRERO
if ((select datename (month, getdate())) = 'Abril')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Febrero = origen.Porcentaje

when not matched then
insert (Empresa, Febrero)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Febrero = origen.Porcentaje;

update av_garantias_historico
set Febrero = 0
where Febrero is null
end

--INSERTA EN EL MES DE MARZO
if ((select datename (month, getdate())) = 'Mayo')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Marzo = origen.Porcentaje

when not matched then
insert (Empresa, Marzo)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Marzo = origen.Porcentaje;

update av_garantias_historico
set Marzo = 0
where Marzo is null
end

--INSERTA EN EL MES DE ABRIL
if ((select datename (month, getdate())) = 'Junio')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Abril = origen.Porcentaje

when not matched then
insert (Empresa, Abril)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Abril = origen.Porcentaje;

update av_garantias_historico
set Abril = 0
where Abril is null
end

--INSERTA EN EL MES DE MAYO
if ((select datename (month, getdate())) = 'Julio')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Mayo = origen.Porcentaje

when not matched then
insert (Empresa, Mayo)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Mayo = origen.Porcentaje;

update av_garantias_historico
set Mayo = 0
where Mayo is null
end

--INSERTA EN EL MES DE JUNIO
if ((select datename (month, getdate())) = 'Agosto')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Junio = origen.Porcentaje

when not matched then
insert (Empresa, Junio)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Junio = origen.Porcentaje;

update av_garantias_historico
set Junio = 0
where Junio is null
end

--INSERTA EN EL MES DE JULIO
if ((select datename (month, getdate())) = 'Septiembre')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Julio = origen.Porcentaje

when not matched then
insert (Empresa, Julio)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Julio = origen.Porcentaje;

update av_garantias_historico
set Julio = 0
where Julio is null
end

--INSERTA EN EL MES DE AGOSTO
if ((select datename (month, getdate())) = 'Octubre')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Agosto = origen.Porcentaje

when not matched then
insert (Empresa, Agosto)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Agosto = origen.Porcentaje;

update av_garantias_historico
set Agosto = 0
where Agosto is null
end

--INSERTA EN EL MES DE SEPTIEMBRE
if ((select datename (month, getdate())) = 'Noviembre')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Septiembre = origen.Porcentaje

when not matched then
insert (Empresa, Septiembre)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Septiembre = origen.Porcentaje;

update av_garantias_historico
set Septiembre = 0
where Septiembre is null
end

--INSERTA EN EL MES DE OCTUBRE
if ((select datename (month, getdate())) = 'Diciembre')
begin
merge into av_garantias_historico as destino
using (select [Empresa que instaló] as Empresa,
		ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje
		
		from #compa2
		group by [Empresa que instaló]) as origen
		
on destino.Empresa = origen.Empresa and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Octubre = origen.Porcentaje

when not matched then
insert (Empresa, Octubre)
values (origen.Empresa, origen.Porcentaje);

merge into av_garantias_historico as destino
using (select ROUND (((cast (sum (Garantias) as float) / cast (sum (Instalados) as float)) * 100), 1) as Porcentaje	
		from #compa2) as origen
		
on destino.Empresa = 'GLOBAL' and
	destino.Anio = datepart (year, getdate())

when matched then update set
destino.Octubre = origen.Porcentaje;

update av_garantias_historico
set Octubre = 0
where Octubre is null
end


--ACTUALIZA EN ANIO
/*
update av_garantias_historico
set Anio = datepart (year,getdate())
where Anio is null
*/