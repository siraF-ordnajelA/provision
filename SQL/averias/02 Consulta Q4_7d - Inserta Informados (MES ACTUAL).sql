declare @fecha1 date
declare @fecha2 date

-- MES ACTUAL (Metrica incompleta)
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO MES ACTUAL
set @fecha2 = cast (getdate() as date) --FECHA ACTUAL

create table #informes (id_tecnico smallint, Estado varchar (25), Cuenta smallint, tecno varchar(12))


-- INSERTA INFORMADOS
insert into #informes (id_tecnico, Estado, Cuenta, tecno)

select [ID RECURSO],
		--T?cnico,
		[Estado de la orden],
		count ([Estado de la orden]) as Cuenta,
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
		alta = 1 and
		[Estado de la orden] in ('Cancelado','No Realizada','Suspendido','Completado')

group by [ID RECURSO],
			T?cnico,
			[Estado de la orden],
			tecnologia


--INSERTA CANTIDAD INFORMES "NO REALIZADO" EN TABLA Q4S_30d
merge into Q4s_7d as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado in ('No Realizada','Cancelado')
		group by id_tecnico, tecno) as origen
		
on destino.Fecha = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.[No Realizado] = origen.Cuenta;

--INSERTA CANTIDAD INFORMES "SUSPENDIDO" EN TABLA Q4S_30d
merge into Q4s_7d as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado = 'Suspendido'
		group by id_tecnico, tecno) as origen
		
on destino.Fecha = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.Suspendido = origen.Cuenta;

-- NULOS A CERO
update Q4s_7d
set [No Realizado] = 0
where fecha = @fecha1 and [No Realizado] is null

update Q4s_7d
set Suspendido = 0
where fecha = @fecha1 and Suspendido is null