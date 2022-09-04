--CRUDO INSTALADO
select *		
from toa_pm_ult31

--CRUDO AVERIAS
select * from av_averias

--INSTALACIONES POR CONTRATA


--AVERIAS POR CONTRATA
select Empresa, count (*) as Averias
from av_averias
where [N�mero de Orden] <> '' or [N�mero de Orden] is not null
group by Empresa
With Cube
Order by Empresa


--AVERIAS POR TECNICO POR CONTRATA
select Empresa, T�cnico, count (*) as Averias
from av_averias
where [N�mero de Orden] <> '' or [N�mero de Orden] is not null
group by Empresa, T�cnico
Order by Empresa, T�cnico

--AVERIAS SIN NUMERO DE ORDEN
select *
from av_averias
where [N�mero de Orden] = '' or [N�mero de Orden] is null