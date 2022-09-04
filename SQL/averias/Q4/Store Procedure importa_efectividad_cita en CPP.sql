alter procedure importa_efectividad_cita

as

declare @fecha1 date
declare @fecha2 date

--SETEA FECHA 1 MES ATRAS
set @fecha1 = cast ((dateadd(month, datediff(month, '19000201', getdate()), '19000101')) as date)--RESTA 1 MES AL MES ACTUAL
set @fecha2 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '18991231')) as date)--MES ACTUAL

insert into [10.249.15.194\DATAFLOW].TELEGESTION.dbo.efectividad_cita (Fecha,
				ctta,
				tecnico,
				citado,
				no_cumplido,
				cumplido,
				tecnologia)

select @fecha1 as Fecha,
		b.ctta,
		b.nombre,
		sum(a.CITADO) as Citado,
		sum(a.NO_CUMPLIDO) as No_Cumplido,
		sum(a.CUMPLIDO) as Cumplido,
		a.XA_ACCESS_TECHNOLOGY

from CEAWEBVM.ODS.dbo.citas_del_dia as a left join [10.249.15.194\DATAFLOW].TELEGESTION.dbo.tecnicos as b
on a.RESOURCE_ID = b.dni and
	b.id_tecnico <> 0
where a.DIA between @fecha1 and @fecha2
group by b.ctta,
		b.nombre,
		a.XA_ACCESS_TECHNOLOGY