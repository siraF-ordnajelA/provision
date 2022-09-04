alter procedure mon_indicadores_1
@opc tinyint,
@empresa varchar(150),
@f1 varchar(11),
@f2 varchar(11)

as

declare @fecha1 date, @fecha2 date

create table #tempo (ctta varchar(150), medallia smallint, tn smallint, tt smallint)
create table #tempo3 (tecnico varchar(150), apto smallint, napto smallint, prov smallint)

IF (@f1 = '' and @f2 = '')
BEGIN
set @fecha1 = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO DEL MES ACTUAL
set @fecha2 = cast (getdate() + 1 as date)
END

ELSE
BEGIN
set @fecha1 = @f1
set @fecha2 = dateadd(day, 1, cast(@f2 as date))
END

IF (@opc = 1 and @empresa = 'TASA')
BEGIN
-- MONITOREOS POR CONTRATISTA
insert into #tempo (ctta, medallia)

select Contratista, count(*) as medallia

from mon_lista_gestionados_tecnico
where [Fecha de carga] between @fecha1 and @fecha2 and
		Contratista <> '0' and
		[Motivo Calibración] = 'Monitoreo por Medallia'
group by Contratista


merge into #tempo as destino
using (select Contratista, count(*) as tn

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista <> '0' and
				[Motivo Calibración] = 'Solicitud ingreso técnico nuevo'
		group by Contratista) as origen

on destino.ctta = origen.Contratista

when matched then update set
destino.tn = origen.tn

when not matched then
insert (ctta, tn)
values (origen.Contratista, origen.tn);

merge into #tempo as destino
using (select Contratista, count(*) as tt

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista <> '0' and
				[Motivo Calibración] = 'Técnico trabajando actualmente'
		group by Contratista) as origen

on destino.ctta = origen.Contratista

when matched then update set
destino.tt = origen.tt

when not matched then
insert (ctta, tt)
values (origen.Contratista, origen.tt);

--Relleno los nulls a cero
update #tempo
set medallia = 0
where medallia is null

update #tempo
set tn = 0
where tn is null

update #tempo
set tt = 0
where tt is null

select ctta as Nombre,
		medallia as valor1,
		tn as valor2,
		tt as valor3

from #tempo
order by ctta
END

IF (@opc = 1 and @empresa <> 'TASA')
BEGIN
-- MONITOREOS POR CONTRATISTA
insert into #tempo(ctta, medallia)

select Contratista, count(*) as medallia

from mon_lista_gestionados_tecnico
where [Fecha de carga] between @fecha1 and @fecha2 and
		Contratista = @empresa and
		[Motivo Calibración] = 'Monitoreo por Medallia'
group by Contratista


merge into #tempo as destino
using (select Contratista, count(*) as tn

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista = @empresa and
				[Motivo Calibración] = 'Solicitud ingreso técnico nuevo'
		group by Contratista) as origen

on destino.ctta = origen.Contratista

when matched then update set
destino.tn = origen.tn

when not matched then
insert (ctta, tn)
values (origen.Contratista, origen.tn);

merge into #tempo as destino
using (select Contratista, count(*) as tt

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista = @empresa and
				[Motivo Calibración] = 'Técnico trabajando actualmente'
		group by Contratista) as origen

on destino.ctta = origen.Contratista

when matched then update set
destino.tt = origen.tt

when not matched then
insert (ctta, tt)
values (origen.Contratista, origen.tt);

--Relleno los nulls a cero
update #tempo
set medallia = 0
where medallia is null

update #tempo
set tn = 0
where tn is null

update #tempo
set tt = 0
where tt is null

select ctta as Nombre,
		medallia as valor1,
		tn as valor2,
		tt as valor3

from #tempo
order by ctta
END


IF (@opc = 2)
BEGIN
-- RESULTADO DE MONITOREOS POR TECNICO
insert into #tempo3 (tecnico, apto)

select [Nombre del Tecnico], count(*) as apto

from mon_lista_gestionados_tecnico
where [Fecha de carga] between @fecha1 and @fecha2 and
		Contratista = @empresa and
		[Resultado Final] = 'Apto'
group by [Nombre del Tecnico]


merge into #tempo3 as destino
using (select [Nombre del Tecnico], count(*) as napto

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista = @empresa and
				[Resultado Final] = 'No apto'
		group by [Nombre del Tecnico]) as origen

on destino.tecnico = origen.[Nombre del Tecnico]

when matched then update set
destino.napto = origen.napto

when not matched then
insert (tecnico, napto)
values (origen.[Nombre del Tecnico], origen.napto);


merge into #tempo3 as destino
using (select [Nombre del Tecnico], count(*) as provisorio

		from mon_lista_gestionados_tecnico
		where [Fecha de carga] between @fecha1 and @fecha2 and
				Contratista = @empresa and
				[Resultado Final] = 'Provisorio'
		group by [Nombre del Tecnico]) as origen

on destino.tecnico = origen.[Nombre del Tecnico]

when matched then update set
destino.prov = origen.provisorio

when not matched then
insert (tecnico, prov)
values (origen.[Nombre del Tecnico], origen.provisorio);


update #tempo3
set apto = 0
where apto is null

update #tempo3
set napto = 0
where napto is null

update #tempo3
set prov = 0
where prov is null

select tecnico as Nombre,
		apto as valor1,
		napto as valor2,
		prov as valor3

from #tempo3
order by tecnico
END

--MONITOREOS POR EMPRESA
IF (@opc = 3 and @empresa = 'TASA')
BEGIN
create table #ctta_monitoreos (ctta varchar(150), tecnicos smallint, monitoreos smallint)

insert into #ctta_monitoreos (ctta, tecnicos)

select ctta, count(*)
from tecnicos
where activo = 1 and ctta <> 'TASA'
group by ctta

merge into #ctta_monitoreos as destino
using (select b.ctta, count(*) as monitoreados
		from mon_gestionados2 as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where b.ctta is not null and
		a.fyhgestion between @fecha1 and @fecha2
		group by b.ctta) as origen

on destino.ctta = origen.ctta

when matched then update set
destino.monitoreos = origen.monitoreados;

update #ctta_monitoreos
set monitoreos = 0
where monitoreos is null

select * from #ctta_monitoreos
order by ctta
END

IF (@opc = 3 and @empresa <> 'TASA')
BEGIN
create table #ctta_monitoreos2 (ctta varchar(150), tecnicos smallint, monitoreos smallint)

insert into #ctta_monitoreos2 (ctta, tecnicos)

select ctta, count(*)
from tecnicos
where activo = 1 and ctta = @empresa
group by ctta

merge into #ctta_monitoreos2 as destino
using /*(select b.ctta, count(*) as monitoreados
		from mon_gestionados2 as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where b.ctta = @empresa and
		a.fyhgestion between @fecha1 and @fecha2
		group by b.ctta) as origen*/
		(select Contratista as ctta,
					count(*) as monitoreados

			from mon_lista_gestionados_tecnico
			where [Fecha de carga] between @fecha1 and @fecha2 and
					Contratista = @empresa
			group by Contratista) as origen

on destino.ctta = origen.ctta

when matched then update set
destino.monitoreos = origen.monitoreados;

update #ctta_monitoreos2
set monitoreos = 0
where monitoreos is null

select * from #ctta_monitoreos2
order by ctta
END