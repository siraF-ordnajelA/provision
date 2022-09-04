declare @fecha1 date
create table #g7d (id int, cant_cumplidas smallint, garantias_7d tinyint)

set @fecha1 = '20211001'

-- Inserto cant garantias 7d FTTH
insert into #g7d(id, cant_cumplidas, garantias_7d)

select id_contrata,
		sum(Instalaciones),
		sum(Garantias)
from Q4s_7d
where Fecha = @fecha1 and tecnologia <> 'cobre'
group by id_contrata
order by id_contrata

-- Pego FINAL
merge into metricas_ctta as destino
using (select * from #g7d) as origen

on destino.Fecha = @fecha1 and
	destino.id_ctta = origen.id and
	destino.tecnologia = 2

when matched then update set
destino.metrica_garantias_7d = round((1 - (cast(origen.garantias_7d as float) / cast(origen.cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6);


truncate table #g7d

-- Inserto cant garantias 7d COBRE
insert into #g7d(id, cant_cumplidas, garantias_7d)

select id_contrata,
		sum(Instalaciones),
		sum(Garantias)
from Q4s_7d
where Fecha = @fecha1 and tecnologia = 'cobre'
group by id_contrata
order by id_contrata

-- Pego FINAL
merge into metricas_ctta as destino
using (select * from #g7d) as origen

on destino.Fecha = @fecha1 and
	destino.id_ctta = origen.id and
	destino.tecnologia = 1

when matched then update set
destino.metrica_garantias_7d = round((1 - (cast(origen.garantias_7d as float) / cast(origen.cant_cumplidas as float))) / (select objetivo_garantias_7d from metricas_objetivos where fecha = '20211001'), 6);