alter procedure actualiza_av_contrata
as

delete from av_averias_contrata_porc
delete from av_averias_tecnico_porc

--INSERTA AVERIAS 24HS --EMPRESA--
--FTTH
insert into av_averias_contrata_porc (Empresa, Cant_24hs, tecno)

select [Empresa que instaló], count (*) as [24 horas], 1
from av_averias
where datediff (day, [Fecha creación TOA], cast (getdate() as date)) < 2 and
		[Tipo de Acceso] <> 'cobre'
group by [Empresa que instaló]
order by [Empresa que instaló];

--Cobre
insert into av_averias_contrata_porc (Empresa, Cant_24hs, tecno)

select [Empresa que instaló], count (*) as [24 horas], 2
from av_averias
where datediff (day, [Fecha creación TOA], cast (getdate() as date)) < 2 and
		[Tipo de Acceso] = 'COBRE'
group by [Empresa que instaló]
order by [Empresa que instaló];

--INSERTA AVERIAS ENTRE 48HS --EMPRESA--
--ftth
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [48hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 2 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 1

when matched then
update set destino.Cant_48hs = origen.[48hs]

when not matched then
insert (Empresa, Cant_48hs, tecno)
values (origen.[Empresa que instaló],
		origen.[48hs],
		1);

--Cobre
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [48hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 2 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 2

when matched then
update set destino.Cant_48hs = origen.[48hs]

when not matched then
insert (Empresa, Cant_48hs, tecno)
values (origen.[Empresa que instaló],
		origen.[48hs],
		2);

--INSERTA AVERIAS DE 72HS --EMPRESA--
--ftth
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [72hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 3 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 1

when matched then
update set destino.Cant_72hs = origen.[72hs]

when not matched then
insert (Empresa, Cant_72hs, tecno)
values (origen.[Empresa que instaló],
		origen.[72hs],
		1);
		
--Cobre
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [72hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 3 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 2

when matched then
update set destino.Cant_72hs = origen.[72hs]

when not matched then
insert (Empresa, Cant_72hs, tecno)
values (origen.[Empresa que instaló],
		origen.[72hs],
		2);

--INSERTA AVERIAS DE 96HS --EMPRESA--
--ftth
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 4 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 1

when matched then
update set destino.Cant_96hs = origen.[96hs]

when not matched then
insert (Empresa, Cant_96hs, tecno)
values (origen.[Empresa que instaló],
		origen.[96hs],
		1);

--Cobre
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 4 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 2

when matched then
update set destino.Cant_96hs = origen.[96hs]

when not matched then
insert (Empresa, Cant_96hs, tecno)
values (origen.[Empresa que instaló],
		origen.[96hs],
		2);
		
--INSERTA AVERIAS MAYOR A 96HS --EMPRESA--
--ftth
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [>96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) > 4 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 1

when matched then
update set destino.Cant_mas96 = origen.[>96hs]

when not matched then
insert (Empresa, Cant_mas96, tecno)
values (origen.[Empresa que instaló],
		origen.[>96hs],
		1);

--Cobre
merge av_averias_contrata_porc as destino
using (select [Empresa que instaló], count (*) as [>96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) > 4 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	destino.tecno = 2

when matched then
update set destino.Cant_mas96 = origen.[>96hs]

when not matched then
insert (Empresa, Cant_mas96, tecno)
values (origen.[Empresa que instaló],
		origen.[>96hs],
		2);
		

--ACTUALIZA CITAS PENDIENTES
merge av_averias_contrata_porc as destino
using (select Empresa, count (*) as Citas
		from av_citas
		group by Empresa) as origen

on destino.Empresa = origen.Empresa
when matched then update
set destino.Citas = origen.Citas;


--ACTUALIZA CITAS VENCIDAS
merge av_averias_contrata_porc as destino
using (select Empresa, count (*) as Citas_Vencidas
		from av_citas
		where [Fecha Cita Manual] < cast (getdate() as date)
		group by Empresa) as origen

on destino.Empresa = origen.Empresa
when matched then update
set destino.[C.Vencidas] = origen.Citas_Vencidas;

--COMPLETA LOS NULL --EMPRESA--
update av_averias_contrata_porc
set [Cant_24hs] = 0
where [Cant_24hs] is null

update av_averias_contrata_porc
set [Cant_48hs]= 0
where [Cant_48hs] is null

update av_averias_contrata_porc
set [Cant_72hs]= 0
where [Cant_72hs] is null

update av_averias_contrata_porc
set [Cant_96hs]= 0
where [Cant_96hs] is null

update av_averias_contrata_porc
set [Cant_mas96]= 0
where [Cant_mas96] is null

update av_averias_contrata_porc
set [Citas]= 0
where [Citas] is null

update av_averias_contrata_porc
set [C.Vencidas]= 0
where [C.Vencidas] is null





--INSERTA AVERIAS MENOR 24HS --TECNICO--
--ftth
insert into av_averias_tecnico_porc (Empresa, Tecnico, Cant_24hs, tecno)

select [Empresa que instaló], [Técnico que instaló], count (*) as [24hs], 1
from av_averias
where datediff (day, [Fecha creación TOA], cast (getdate() as date)) < 2 and
		[Tipo de Acceso] <> 'cobre'
group by [Empresa que instaló], [Técnico que instaló]
order by [Empresa que instaló], [Técnico que instaló];

--Cobre
insert into av_averias_tecnico_porc (Empresa, Tecnico, Cant_24hs, tecno)

select [Empresa que instaló], [Técnico que instaló], count (*) as [24hs], 2
from av_averias
where datediff (day, [Fecha creación TOA], cast (getdate() as date)) < 2 and
		[Tipo de Acceso] = 'COBRE'
group by [Empresa que instaló], [Técnico que instaló]
order by [Empresa que instaló], [Técnico que instaló];

--INSERTA AVERIAS ENTRE 48HS --TECNICO--
--ftth
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [48hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 2 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 1

when matched then
update set destino.Cant_48hs = origen.[48hs]

when not matched then
insert (Empresa, Tecnico, Cant_48hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[48hs],
		1);

--Cobre
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [48hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 2 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 2

when matched then
update set destino.Cant_48hs = origen.[48hs]

when not matched then
insert (Empresa, Tecnico, Cant_48hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[48hs],
		2);

--INSERTA AVERIAS 72HS --TECNICO--
--ftth
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [72hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 3 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 1

when matched then
update set destino.Cant_72hs = origen.[72hs]

when not matched then
insert (Empresa, Tecnico, Cant_72hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[72hs],
		1);

--Cobre
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [72hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 3 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 2

when matched then
update set destino.Cant_72hs = origen.[72hs]

when not matched then
insert (Empresa, Tecnico, Cant_72hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[72hs],
		2);

--INSERTA AVERIAS 96HS --TECNICO--
--ftth
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 4 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 1

when matched then
update set destino.Cant_96hs = origen.[96hs]

when not matched then
insert (Empresa, Tecnico, Cant_96hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[96hs],
		1);

--Cobre
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [96hs]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) = 4 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 2

when matched then
update set destino.Cant_96hs = origen.[96hs]

when not matched then
insert (Empresa, Tecnico, Cant_96hs, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[96hs],
		2);

--INSERTA AVERIAS MAYOR 96HS --TECNICO--
--ftth
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [>96]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) > 4 and
				[Tipo de Acceso] <> 'cobre'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 1

when matched then
update set destino.Cant_mas96 = origen.[>96]

when not matched then
insert (Empresa, Tecnico, Cant_mas96, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[>96],
		1);

--Cobre
merge av_averias_tecnico_porc as destino
using (select [Empresa que instaló], [Técnico que instaló], count (*) as [>96]
		from av_averias
		where datediff (day, [Fecha creación TOA], cast (getdate() as date)) > 4 and
				[Tipo de Acceso] = 'COBRE'
		group by [Empresa que instaló], [Técnico que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.Empresa and
	origen.[Técnico que instaló] = destino.Tecnico and
	destino.tecno = 2

when matched then
update set destino.Cant_mas96 = origen.[>96]

when not matched then
insert (Empresa, Tecnico, Cant_mas96, tecno)
values (origen.[Empresa que instaló],
		origen.[Técnico que instaló],
		origen.[>96],
		2);

--COMPLETA LOS NULL --TECNICO--
update av_averias_tecnico_porc
set [Cant_24hs] = 0
where [Cant_24hs] is null

update av_averias_tecnico_porc
set [Cant_48hs]= 0
where [Cant_48hs] is null

update av_averias_tecnico_porc
set [Cant_72hs]= 0
where [Cant_72hs] is null

update av_averias_tecnico_porc
set [Cant_96hs]= 0
where [Cant_96hs] is null

update av_averias_tecnico_porc
set [Cant_mas96]= 0
where [Cant_mas96] is null

/*
--TOTAL DE AVERIAS POR FECHA
select [Fecha de Emisión/Reclamo], count (*)
from av_averias
group by [Fecha de Emisión/Reclamo]
order by [Fecha de Emisión/Reclamo]

--TOTAL DE AVERIAS
select count (*) as [Total de Averias]
from av_averias

update av_averias_contrata_porc
set Cant_menos_7D = 0
where Cant_menos_7d is null

update av_averias_contrata_porc
set Cant_mayor_7D = 0
where Cant_mayor_7d is null

--PARSIMONIA
select case when Empresa = '' then 'Sin datos' else Empresa end as Empresa,
		Cant_menos_7d,
		Cant_mayor_7d,
		Cant_menos_7d + Cant_mayor_7d as Subtotal,
		case when Cant_menos_7d = 0 then 0 else round ((cast (Cant_menos_7d as float) / cast ((select sum (Cant_menos_7d) from av_averias_contrata_porc) as float)) * 100, 2) end as [% <= 7d],
		case when Cant_mayor_7d = 0 then 0 else round ((cast (Cant_mayor_7d as float) / cast ((select sum (Cant_mayor_7d) from av_averias_contrata_porc) as float)) * 100, 2) end as [% > 7d],
		case when Cant_menos_7d = 0 then 0 else round ((cast (Cant_menos_7d as float) / cast ((select sum (Cant_menos_7d) from av_averias_contrata_porc) as float)) * 100, 2) end + case when Cant_mayor_7d = 0 then 0 else round ((cast (Cant_mayor_7d as float) / cast ((select sum (Cant_mayor_7d) from av_averias_contrata_porc) as float)) * 100, 2) end as Subtotal_porcio

from av_averias_contrata_porc
*/