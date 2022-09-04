alter procedure lista_contratas
as
/*
select contratas.id_contrata, tecnicos.ctta
from tecnicos join contratas
on tecnicos.ctta = contratas.descripcion_contrata
group by contratas.id_contrata, tecnicos.ctta
order by tecnicos.ctta
*/
select id_contrata, descripcion_contrata as ctta
from contratas
where id_contrata <> 1
order by descripcion_contrata