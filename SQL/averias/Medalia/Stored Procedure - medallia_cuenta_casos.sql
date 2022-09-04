alter procedure medallia_cuenta_casos
@id_usuario smallint,
@empresa varchar(150)

as

create table #salida (empresa varchar(50),
						id_user tinyint,
						escalados tinyint,
						refuerzos tinyint,
						pend_clooper smallint,
						sistemas smallint,
						cerrados int,
						pend_monitoreo smallint,
						pend_gestor smallint,
						provisorios smallint,
						noaptos smallint)
declare @id_empresa tinyint
set @id_empresa = (select id_contrata from contratas where descripcion_contrata = @empresa)

IF (@empresa <> 'TASA')
BEGIN
-- ESCALADOS CONTRATA
insert into #salida(empresa, escalados)

select contratas.descripcion_contrata, count(*) as casos
from medallia_encuestas join contratas
on medallia_encuestas.id_empresa = contratas.id_contrata
where medallia_encuestas.estado = 2 and -- Antes era 4 (Escalado)
		medallia_encuestas.accion_ejecutada = 1/* and
		(medallia_encuestas.detalle not in (22,23,41) and
		medallia_encuestas.subconcepto not in (12,13,14,15,16))*/
group by contratas.descripcion_contrata

-- PENDIENTES CLOOPER
merge into #salida as destino
using (select contratas.descripcion_contrata, count(*) as casos
		from medallia_encuestas join contratas
		on medallia_encuestas.id_empresa = contratas.id_contrata
		where medallia_encuestas.estado = 3 and
				medallia_encuestas.accion_ejecutada <> 3
		group by contratas.descripcion_contrata) as origen

on destino.empresa = origen.descripcion_contrata

when matched then
update set
destino.pend_clooper = origen.casos

when not matched then
insert (empresa, pend_clooper)
values (origen.descripcion_contrata, origen.casos);

-- ESCALADOS SISTEMA
merge into #salida as destino
using (select contratas.descripcion_contrata, count(*) as casos
		from medallia_encuestas join contratas
		on medallia_encuestas.id_empresa = contratas.id_contrata
		where medallia_encuestas.accion_ejecutada = 3 and medallia_encuestas.estado <> 1
		group by contratas.descripcion_contrata) as origen

on destino.empresa = origen.descripcion_contrata

when matched then
update set
destino.sistemas = origen.casos

when not matched then
insert (empresa, sistemas)
values (origen.descripcion_contrata, origen.casos);

-- ESCALADOS REFUERZO CTTA
merge into #salida as destino
using (select contratas.descripcion_contrata, count(*) as casos
		from medallia_encuestas join contratas
		on medallia_encuestas.id_empresa = contratas.id_contrata
		where medallia_encuestas.estado = 4 and -- Antes era estado = 2 (Escalado)
				medallia_encuestas.accion_ejecutada = 1 /*and
				(medallia_encuestas.detalle in (22,23,41) or
				medallia_encuestas.subconcepto in (12,13,14,15,16))*/
		group by contratas.descripcion_contrata) as origen

on destino.empresa = origen.descripcion_contrata

when matched then
update set
destino.refuerzos = origen.casos

when not matched then
insert (empresa, refuerzos)
values (origen.descripcion_contrata, origen.casos);

-- CERRADOS
merge into #salida as destino
using (select contratas.descripcion_contrata, count(*) as casos
		from medallia_encuestas join contratas
		on medallia_encuestas.id_empresa = contratas.id_contrata
		where medallia_encuestas.estado = 1
		group by contratas.descripcion_contrata) as origen

on destino.empresa = origen.descripcion_contrata

when matched then
update set
destino.cerrados = origen.casos

when not matched then
insert (empresa, cerrados)
values (origen.descripcion_contrata, origen.casos);


-- PENDIENTES MONITOREO
merge into #salida as destino
using (select b.ctta,
			count(*) as cant
		from mon_medallia_lista as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where a.monitoreado = 0 and
				cast (a.fyhingreso as date) > '20210516' and
				b.activo = 1
		group by b.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.pend_monitoreo = origen.cant

when not matched then
insert (empresa, pend_monitoreo)
values (origen.ctta, origen.cant);

-- PENDIENTES GESTOR
merge into #salida as destino
using (select b.ctta,
			count(*) as cant
		from mon_gestionados2 as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where a.trabajado = 0 and a.visto_ctta = 1 and
				a.flag_ingresante = 0 and
				cast (a.fyhgestion as date) > '20210516'
		group by b.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.pend_gestor = origen.cant

when not matched then
insert (empresa, pend_gestor)
values (origen.ctta, origen.cant);

-- PENDIENTES PROVISORIO
merge into #salida as destino
using (select tecnicos.ctta,
			count(*) as cant
		from mon_gestionados2 left join tecnicos
		on mon_gestionados2.id_recurso = tecnicos.id_tecnico
		where mon_gestionados2.calificacion = 2 and -- Calificacion = 2 PROVISORIO
				trabajado = 0 and
				visto_ctta is null and
				mon_gestionados2.flag_ingresante = 0 and
				mon_gestionados2.fyhmonitoreo > '20210516'
		group by tecnicos.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.provisorios = origen.cant

when not matched then
insert (empresa, provisorios)
values (origen.ctta, origen.cant);

-- PENDIENTES NO APTOS
merge into #salida as destino
using (select tecnicos.ctta,
			count(*) as cant
		from mon_gestionados2 left join tecnicos
		on mon_gestionados2.id_recurso = tecnicos.id_tecnico
		where mon_gestionados2.calificacion = 3 and -- Calificacion = 3 NO APTOS
				trabajado = 0 and
				visto_ctta is null and
				mon_gestionados2.flag_ingresante = 0 and
				mon_gestionados2.fyhmonitoreo > '20210516'
		group by tecnicos.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.noaptos = origen.cant

when not matched then
insert (empresa, noaptos)
values (origen.ctta, origen.cant);


--PONGO A CERO LOS NULOS
update #salida
set escalados = 0
where escalados is null

update #salida
set refuerzos = 0
where refuerzos is null

update #salida
set pend_clooper = 0
where pend_clooper is null

update #salida
set sistemas = 0
where sistemas is null

update #salida
set pend_monitoreo = 0
where pend_monitoreo is null

update #salida
set pend_gestor = 0
where pend_gestor is null

update #salida
set provisorios = 0
where provisorios is null

update #salida
set noaptos = 0
where noaptos is null

if ((select count(*) from #salida where empresa = @empresa) = 0)
begin
	insert into #salida (empresa,
		escalados,
		refuerzos,
		pend_clooper,
		sistemas,
		cerrados,
		pend_monitoreo,
		pend_gestor,
		provisorios,
		noaptos)
	values (@empresa,0,0,0,0,0,0,0,0,0)
end

-- MUESTRO SALIDA
select empresa,
		escalados,
		refuerzos,
		pend_clooper,
		sistemas,
		cerrados,
		pend_monitoreo,
		pend_gestor,
		provisorios,
		noaptos
from #salida
where empresa = @empresa
END




IF (@empresa = 'TASA')
BEGIN
-- ESCALADOS CONTRATA
insert into #salida(id_user, escalados)

select id_clooper, count(*) as casos
from medallia_encuestas
where medallia_encuestas.estado = 2 and
		medallia_encuestas.accion_ejecutada = 1/* and
		(medallia_encuestas.detalle not in (22,23,41) and
		medallia_encuestas.subconcepto not in (12,13,14,15,16))*/
group by id_clooper

-- PENDIENTES CLOOPER
merge into #salida as destino
using (select id_clooper, count(*) as casos
		from medallia_encuestas
		where medallia_encuestas.estado = 3 and
				medallia_encuestas.accion_ejecutada <> 3
		group by id_clooper) as origen

on destino.id_user = origen.id_clooper

when matched then
update set
destino.pend_clooper = origen.casos

when not matched then
insert (id_user, pend_clooper)
values (origen.id_clooper, origen.casos);

-- ESCALADOS SISTEMA
merge into #salida as destino
using (select id_clooper, count(*) as casos
		from medallia_encuestas join contratas
		on medallia_encuestas.id_empresa = contratas.id_contrata
		where medallia_encuestas.accion_ejecutada = 3
		group by id_clooper) as origen

on destino.id_user = origen.id_clooper

when matched then
update set
destino.sistemas = origen.casos

when not matched then
insert (id_user, sistemas)
values (origen.id_clooper, origen.casos);

-- ESCALADOS REFUERZO CTTA
merge into #salida as destino
using (select id_clooper, count(*) as casos
		from medallia_encuestas
		where medallia_encuestas.estado = 4 and -- Antes era 2 (Escalado)
				medallia_encuestas.accion_ejecutada = 1 /*and
				(medallia_encuestas.detalle in (22,23,41) or
				medallia_encuestas.subconcepto in (12,13,14,15,16))*/
		group by id_clooper) as origen

on destino.id_user = origen.id_clooper

when matched then
update set
destino.refuerzos = origen.casos

when not matched then
insert (id_user, refuerzos)
values (origen.id_clooper, origen.casos);


-- PENDIENTES MONITOREO
merge into #salida as destino
using (select b.ctta,
			count(*) as cant
		from mon_medallia_lista as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where a.monitoreado = 0 and
				b.activo = 1 and
				cast (a.fyhingreso as date) > '20210516'
		group by b.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.pend_monitoreo = origen.cant

when not matched then
insert (empresa, pend_monitoreo)
values (origen.ctta, origen.cant);

-- PENDIENTES GESTOR
merge into #salida as destino
using (select b.ctta,
			count(*) as cant
		from mon_gestionados2 as a left join tecnicos as b
		on a.id_recurso = b.id_tecnico
		where a.trabajado = 0 and a.visto_ctta = 1 and
				a.flag_ingresante = 0 and
				cast (a.fyhgestion as date) > '20210516'
		group by b.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.pend_gestor = origen.cant

when not matched then
insert (empresa, pend_gestor)
values (origen.ctta, origen.cant);

-- PENDIENTES PROVISORIO
merge into #salida as destino
using (select tecnicos.ctta,
			count(*) as cant
		from mon_gestionados2 left join tecnicos
		on mon_gestionados2.id_recurso = tecnicos.id_tecnico
		where mon_gestionados2.calificacion = 2 and -- Calificacion = 2 PROVISORIO
				trabajado = 0 and
				visto_ctta is null and
				mon_gestionados2.flag_ingresante = 0 and
				mon_gestionados2.fyhmonitoreo > '20210516'
		group by tecnicos.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.provisorios = origen.cant

when not matched then
insert (empresa, provisorios)
values (origen.ctta, origen.cant);

-- PENDIENTES NO APTOS
merge into #salida as destino
using (select tecnicos.ctta,
			count(*) as cant
		from mon_gestionados2 left join tecnicos
		on mon_gestionados2.id_recurso = tecnicos.id_tecnico
		where mon_gestionados2.calificacion = 3 and -- Calificacion = 3 NO APTOS
				trabajado = 0 and
				visto_ctta is null and
				mon_gestionados2.flag_ingresante = 0 and
				mon_gestionados2.fyhmonitoreo > '20210516'
		group by tecnicos.ctta) as origen

on destino.empresa = origen.ctta

when matched then
update set
destino.noaptos = origen.cant

when not matched then
insert (empresa, noaptos)
values (origen.ctta, origen.cant);


--PONGO A CERO LOS NULOS
update #salida
set escalados = 0
where escalados is null

update #salida
set refuerzos = 0
where refuerzos is null

update #salida
set pend_clooper = 0
where pend_clooper is null

update #salida
set sistemas = 0
where sistemas is null

update #salida
set pend_monitoreo = 0
where pend_monitoreo is null

update #salida
set pend_gestor = 0
where pend_gestor is null

update #salida
set provisorios = 0
where provisorios is null

update #salida
set noaptos = 0
where noaptos is null

-- Suma pendientes monitoreo
update #salida
set pend_monitoreo = (select sum(pend_monitoreo) from #salida)
where empresa is null and id_user is not null
-- Suma pendientes gestor
update #salida
set pend_gestor = (select sum(pend_gestor) from #salida)
where empresa is null and id_user is not null
-- Suma provisorios
update #salida
set provisorios = (select sum(provisorios) from #salida)
where empresa is null and id_user is not null
-- Suma no aptos
update #salida
set noaptos = (select sum(noaptos) from #salida)
where empresa is null and id_user is not null


-- Suma sistemas para Maxi y para mi
update #salida
set sistemas = (select sum(sistemas) from #salida)
where id_user in (37, 1)


-- MUESTRO SALIDA
IF (@id_usuario = 1 or @id_usuario = 37)
BEGIN
merge into #salida as destino
using (select @id_usuario as id_usuario,
				(select sum(sistemas) from #salida) as sistemas,
				(select sum(pend_monitoreo) from #salida where empresa is not null and id_user is null) as pend_monitoreo,
				(select sum(pend_gestor) from #salida where empresa is not null and id_user is null) as pend_gestor,
				(select sum(provisorios) from #salida where empresa is not null and id_user is null) as provisorios,
				(select sum(noaptos) from #salida where empresa is not null and id_user is null) as noaptos) as origen

on destino.id_user = origen.id_usuario

when matched then update set
destino.sistemas = origen.sistemas,
destino.pend_monitoreo = origen.pend_monitoreo,
destino.pend_gestor = origen.pend_gestor,
destino.provisorios = origen.provisorios,
destino.noaptos = origen.noaptos

when not matched then
insert (id_user,
		escalados,
		refuerzos,
		pend_clooper,
		sistemas,
		pend_monitoreo,
		pend_gestor,
		provisorios,
		noaptos)
values (@id_usuario,
		0,
		0,
		0,
		origen.sistemas,
		origen.pend_monitoreo,
		origen.pend_gestor,
		origen.provisorios,
		origen.noaptos);
END

select id_user,
		escalados,
		refuerzos,
		pend_clooper,
		sistemas,
		0 as cerrados,
		pend_monitoreo,
		pend_gestor,
		provisorios,
		noaptos
from #salida
where id_user = @id_usuario
END