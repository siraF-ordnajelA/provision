alter procedure actualiza_av_averias_instalados
as

declare @fecha1 date
set @fecha1 = cast ((dateadd(month, datediff(month, '19000301', getdate()), '19000101')) as date)--RESTA 2 MESES AL MES ACTUAL

--INSERTO TECNICO QUE INSTALO
create table #av_temp (id_temp int identity(1,1),
							id int,
							fecha_de_cumpli smalldatetime,
							asignacion varchar(12),
							averia varchar(10),
							sub_actividad varchar (80),
							cod_actua varchar(80),
							tec_instalo varchar(100),
							Empresa varchar(50),
							Multi varchar(50),
							Tecno varchar(50))

insert into #av_temp (id, fecha_de_cumpli, asignacion, averia, sub_actividad, cod_actua, tec_instalo, Empresa, Multi, Tecno)

SELECT av_averias.id,
		cast (toa_pm.timestamp as date) as [Fecha cumplimiento Instalación],
		case when av_averias.[Técnico] like '%CTTA' then 'NO ASIGNADO' else 'ASIGNADO' end as Asignacion,
		case when av_averias.[Subtipo de Actividad] like '%IPTV' and toa_pm.tecnologia in ('EQUIPO IPTV','fibra+iptv','FTTH+IPTV','iptv') then 'CORRECTO'
				when av_averias.[Subtipo de Actividad] not like '%IPTV' and toa_pm.[tecnologia] in ('fibra','fibra+iptv','FTTH+IPTV') then 'CORRECTO'
				when toa_pm.[Subtipo de Actividad] is null then null else 'INCORRECTO' end as [Garantia correcta],
		toa_pm.[Subtipo de Actividad],
		toa_pm.[Código de actuación],
		toa_pm.Técnico as [Técnico que instaló],
		toa_pm.Empresa,
		toa_pm.Multiproducto,
		toa_pm.Tecnologia

FROM av_averias left join ATC.dbo.toa_pm as toa_pm
on --cast (toa_pm.timestamp as date) <= (SELECT min (cast ([Fecha de Emisión/Reclamo] as date)) FROM av_averias) and
	--toa_pm.TIMESTAMP > @fecha1 and
	toa_pm.alta = 1 and
	av_averias.[Access ID] <> '' and
	av_averias.[Access ID] = toa_pm.[Access ID] and
	toa_pm.[Estado de la orden] = 'Completado'


--Elimino los duplicados
create table #av_temp2 (id2 int, fcumpl smalldatetime)

insert into #av_temp2 (id2, fcumpl)

select id, min(fecha_de_cumpli)
from #av_temp
group by id
having count (id) > 1

delete from #av_temp
where id in (select id2 from #av_temp2) and
		--fecha_de_cumpli <> (select fcumpl from #av_temp2) and
		averia = 'INCORRECTO'

delete from #av_temp
where id in (select id2 from #av_temp2) and
		fecha_de_cumpli <> (select min(fcumpl) from #av_temp2)

DELETE T FROM
	(SELECT Row_Number() Over(Partition By id, tec_instalo ORDER BY id) AS RowNumber,* FROM #av_temp) T
	WHERE T.RowNumber > 1
	
DELETE T FROM
	(SELECT Row_Number() Over(Partition By id ORDER BY id_temp) AS RowNumber,* FROM #av_temp) T
	WHERE T.RowNumber > 1
/*
select #av_temp.id_temp,
		#av_temp.id,
		#av_temp.tec_instalo,
		av_averias.id
		
from #av_temp left join av_averias
on #av_temp.id = av_averias.id

select * from av_averias where id = 44073
select * from #av_temp where id = 44073
*/

--INSERTO DATOS DE QUIEN INSTALÓ
merge av_averias as destino2
using (select * from #av_temp) as origen2
			
on origen2.id = destino2.id 

when matched then update set
destino2.Fecha_de_cumplimiento_inst = origen2.[Fecha_de_cumpli],
destino2.Asignacion = origen2.asignacion,
destino2.Averia = origen2.averia,
destino2.[Subtipo de Actividad Instalacion] = origen2.[Sub_actividad],
destino2.[Código de actuación Instalacion] = origen2.[cod_actua],
destino2.[Técnico que instaló] = origen2.[tec_instalo],
destino2.[Empresa que instaló] = origen2.Empresa,
destino2.[Multiproducto instalado] = origen2.[Multi],
destino2.[Tecnologia instalada] = origen2.Tecno;

update av_averias
set [Empresa que instaló] = ''
where [Empresa que instaló] is null

update av_averias
set [Técnico que instaló] = ''
where [Técnico que instaló] is null

--ELIMINO AVERIAS MAYOR 30 DIAS
delete from av_averias
where datediff(day, Fecha_de_cumplimiento_inst, [Fecha de Emisión/Reclamo]) > 90