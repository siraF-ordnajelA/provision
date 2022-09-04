alter procedure q4s_Semanal_B

as

declare @fecha date
declare @fecha1 date
declare @fecha2 date

---------------------------------------------------- 2 SEMANAS ATRAS
--SETEA FECHA 2 SEMANAS ATRAS
set @fecha = cast(getdate() as date)
set @fecha1 = (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-8)) -- 2 SEMANAS ATRAS
set @fecha2 = dateadd(day, 1, (SELECT DATEADD(wk,DATEDIFF(wk,7,@fecha),-2))) -- 1 SEMANA ATRAS
--select @fecha1, @fecha2

create table #informes (id_tecnico smallint, Estado varchar (25), Cuenta smallint, tecno varchar(15))

-- INSERTA INFORMADOS
insert into #informes (id_tecnico, Estado, Cuenta, tecno)

select [ID RECURSO],
		--Técnico,
		[Estado de la orden],
		count ([Estado de la orden]) as Cuenta,
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
		alta = 1 and
		[Estado de la orden] in ('Cancelado','No Realizada','Suspendido','Completado')

group by [ID RECURSO],
			Técnico,
			[Estado de la orden],
			tecnologia


--INSERTA CANTIDAD INFORMES "NO REALIZADO" EN TABLA Q4S_30d
merge into Q4s_semanal as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado in ('No Realizada','Cancelado')
		group by id_tecnico, tecno) as origen
		
on destino.fecha1 = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.[No Realizado] = origen.Cuenta;

--INSERTA CANTIDAD INFORMES "SUSPENDIDO" EN TABLA Q4S_30d
merge into Q4s_semanal as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado = 'Suspendido'
		group by id_tecnico, tecno) as origen
		
on destino.fecha1 = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.Suspendido = origen.Cuenta;

-- NULOS A CERO
update Q4s_semanal
set [No Realizado] = 0
where fecha1 = @fecha1 and [No Realizado] is null

update Q4s_semanal
set Suspendido = 0
where fecha1 = @fecha1 and Suspendido is null


---------------------------------------------------- 1 SEMANA ATRAS
-- SETEO FECHAS 1 SEMANA ATRAS
set @fecha1 = DATEADD(day,7,@fecha1)
set @fecha2 = DATEADD(day,7,@fecha2)

truncate table #informes

-- INSERTA INFORMADOS
insert into #informes (id_tecnico, Estado, Cuenta, tecno)

select [ID RECURSO],
		--Técnico,
		[Estado de la orden],
		count ([Estado de la orden]) as Cuenta,
		tecnologia

from ATC.dbo.toa_pm
where (timestamp between @fecha1 and @fecha2) and
		alta = 1 and
		[Estado de la orden] in ('Cancelado','No Realizada','Suspendido','Completado')

group by [ID RECURSO],
			Técnico,
			[Estado de la orden],
			tecnologia


--INSERTA CANTIDAD INFORMES "NO REALIZADO" EN TABLA Q4S_30d
merge into Q4s_semanal as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado in ('No Realizada','Cancelado')
		group by id_tecnico, tecno) as origen
		
on destino.fecha1 = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.[No Realizado] = origen.Cuenta;

--INSERTA CANTIDAD INFORMES "SUSPENDIDO" EN TABLA Q4S_30d
merge into Q4s_semanal as destino
using (select id_tecnico,
				sum(Cuenta) as Cuenta,
				tecno
		from #informes
		where Estado = 'Suspendido'
		group by id_tecnico, tecno) as origen
		
on destino.fecha1 = @fecha1 and
	origen.id_tecnico = destino.id_tecnico and
	origen.tecno = destino.tecnologia

when matched then update
set destino.Suspendido = origen.Cuenta;

-- NULOS A CERO
update Q4s_semanal
set [No Realizado] = 0
where fecha1 = @fecha1 and [No Realizado] is null

update Q4s_semanal
set Suspendido = 0
where fecha1 = @fecha1 and Suspendido is null