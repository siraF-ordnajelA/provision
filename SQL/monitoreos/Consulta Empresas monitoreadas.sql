select top 3 * from mon_gestionados2
order by fyhgestion desc

select top 3 * from tecnicos


create table #ctta_monitoreos (ctta varchar(150), tecnicos smallint, monitoreos smallint)

insert into #ctta_monitoreos (ctta, tecnicos)

select ctta, count(*)
from tecnicos
where activo = 1 
group by ctta

merge into #ctta_monitoreos as destino
using (select b.ctta, count(*) as monitoreados
		from mon_gestionados2 as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where b.ctta is not null and
		a.fyhgestion between '20210301' and '20210401'
		group by b.ctta) as origen

on destino.ctta = origen.ctta

when matched then update set
destino.monitoreos = origen.monitoreados;



select top 3 * from mon_gestionados2
select top 3 * from tecnicos