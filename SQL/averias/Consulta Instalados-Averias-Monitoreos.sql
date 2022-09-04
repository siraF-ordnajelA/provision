create table #compa (Empresa varchar (50) null, Tecnico varchar (150) null, Recurso smallint null, Access varchar (25) null, Instalados tinyint null, Garantias tinyint null, fecha_insta date, fecha_av date)
create table #av_temp (Access varchar (25) null, av_fecha date null)

declare @fecha1 date
declare @fecha2 date
declare @fecha_averias_fin date
declare @fecha_fin_altas date

set @fecha1 = CAST (CONVERT (char(6), getdate(), 112)-1 as varchar(6)) + CAST ('01' as varchar(2))
set @fecha2 = CAST (CONVERT (char(6), getdate(), 112) as varchar(6)) + CAST ('01' as varchar(2))
set @fecha_averias_fin = dateadd (day, 30, @fecha2)
set @fecha_fin_altas = @fecha2--dateadd (day, 1, @fecha2)


--INSERTO AVERIAS ENTRE FECHAS
insert into #av_temp (Access, av_fecha)

select [Access ID],
		min (cast (timestamp as date)) as fecha
		
from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_averias_fin) and
		toa_pm.[Subtipo de actividad] like 'Reparación%' and
		toa_pm.tecnologia <> 'cobre'
group by [Access ID]


--INSERTO INSTALADOS ENTRE FECHAS
insert into #compa (Empresa, Tecnico, Recurso, Access, Instalados, fecha_insta)

select Empresa,
		Técnico,
		[ID RECURSO],
		[Access ID],
		count (*) Instalados,
		cast (timestamp as date)

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha_fin_altas) and
		[Access ID] <> 0 and
		alta = 1 and
		[Estado de la orden] = 'Completado' and
		[Subtipo de actividad] <> 'Instalar Kit' and
		tecnologia <> 'cobre' and
		[Tecnologia Banda Ancha] <> 'ADSL2+'
		
group by Empresa, Técnico, [ID RECURSO], [Access ID], timestamp
order by Empresa, Técnico


--AVERIAS
merge #compa as destino
using (select #compa.Tecnico,
				#compa.Access,
				case when #av_temp.Access is null then 0 else 1 end as Averias,
				#av_temp.av_fecha

		from #compa left join #av_temp
		on #compa.Access = #av_temp.Access
		group by #compa.Tecnico, #compa.Access, #av_temp.Access, #av_temp.av_fecha) as origen

on origen.Access = destino.Access and
	origen.Tecnico = destino.Tecnico
when matched then update set
destino.Garantias = origen.Averias,
destino.fecha_av = origen.av_fecha;


--CONSULTA FINAL
select a.Empresa,
		a.Tecnico,
		sum (a.Instalados) as Instalados,
		sum (a.Garantias) as Garantias,
		avg (cast (b.calificacion as float)) as Promedio_Calificacion

from #compa as a left join mon_gestionados as b
on a.Recurso = b.id_recurso
--where b.calificacion is not null
group by a.Empresa,
		a.Tecnico