create table #dias_habiles (dias date)

insert into #dias_habiles (dias)

select cast(dia as date) from toa_pm
where periodo = '202112' and
		alta = 1 and
		--tecnologia like 'fibra%' and
		[ESTADO DE LA ORDEN] in ('Completado','No Realizada', 'Suspendido')
group by dia having sum(1) > 100 --Me setea que se hayan trabajado más de 100 órdenes por día

select count(dias) as DIAS from #dias_habiles