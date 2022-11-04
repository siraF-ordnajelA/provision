declare @fecha date
set @fecha = '20220601'

create table #averias (id_ctta smallint, Access varchar(25), Orden varchar(50))
create table #reiteros (id_ctta smallint, cantidad smallint)


insert into #averias(id_ctta, Access, Orden)

select id_contrata,
		[Access ID],
		Orden
		
from av_averias_historico
where [Access ID] <> 0 and
		[Access ID] <> '' and
		[Access ID] is not null and
		[Fecha creacion TOA] >= @fecha
group by id_contrata, [Access ID], Orden


insert into #reiteros(id_ctta, cantidad)

select id_ctta,
		count(*) as Cant

from #averias
group by id_ctta, Access
having count(*) > 1


-- SELECCION
select b.descripcion_contrata,
		count(*) as Reiteros
from #reiteros as a join contratas as b
on a.id_ctta = b.id_contrata
group by b.descripcion_contrata
order by count(*) desc