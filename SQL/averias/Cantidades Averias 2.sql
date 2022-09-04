--CRUDO INSTALADO
select *		
from toa_pm_ult31

--CRUDO AVERIAS
select * from av_averias

--INSTALACIONES POR CONTRATA


--AVERIAS POR CONTRATA
select Empresa, count (*) as Averias
from av_averias
where [Número de Orden] <> '' or [Número de Orden] is not null
group by Empresa
With Cube
Order by Empresa


--AVERIAS POR TECNICO POR CONTRATA
select Empresa, Técnico, count (*) as Averias
from av_averias
where [Número de Orden] <> '' or [Número de Orden] is not null
group by Empresa, Técnico
Order by Empresa, Técnico

--AVERIAS SIN NUMERO DE ORDEN
select *
from av_averias
where [Número de Orden] = '' or [Número de Orden] is null