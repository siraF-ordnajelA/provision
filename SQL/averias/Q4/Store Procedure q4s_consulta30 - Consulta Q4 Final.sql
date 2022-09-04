alter procedure q4s_consulta30
@id_empresa varchar(150),
@mes varchar(11),
@dias varchar(2)

as

declare @id_contra tinyint
declare @tecnicos tinyint
set @id_contra = (select id_contrata from contratas where descripcion_contrata = @id_empresa)
/*
select q4s_30d.id_contrata,
		contratas.descripcion_contrata as Empresa
from q4s_30d left join contratas
on q4s_30d.id_contrata = contratas.id_contrata
group by q4s_30d.id_contrata, contratas.descripcion_contrata
*/
if ((@mes is null or @mes = '') and @dias = '30')
begin
set @tecnicos = (select count(*) from q4s_30d where id_contrata = @id_contra and Fecha = (Select top 1 Fecha from q4s_30d order by fecha desc))

select cast (q4s_30d.Fecha as varchar(7)) as Fecha,
		contratas.descripcion_contrata as Empresa,
		q4s_30d.Tecnico,
		q4s_30d.Instalaciones,
		q4s_30d.Garantias,
		ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2) as Porc,
		case when Garantias = 0 then 0
				when ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then 120
				else ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) end as [Cumpl. Obj. Garantias],
		(select count(*) from mon_gestionados2 where id_recurso = id_tecnico) as Monitoreos,
		q4s_30d.[No Realizado],
		q4s_30d.Suspendido,
		q4s_30d.dias_trabajo,
		ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 ) as [Porc. Informados],
		case when q4s_30d.[No Realizado] + q4s_30d.Suspendido = 0 then 0
				when ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then 120
				else ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) end as [Cumpl. Obj. Informadas],
		prom_diarias as Produccion,
		case when ROUND ((prom_diarias / cast (2.5 as float)) * 100.00, 2) > 120 then 120
				else ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) end as [Cumpl. Obj. Inst. diarias],
		case when Garantias = 0 or q4s_30d.[No Realizado] + q4s_30d.Suspendido = 0 then 0
				-- when alguna de las 3 variales da mayor a 120%
				when ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then cast (1.2 as float) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * cast (1.2 as float) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * cast (1.2 as float) * 100
				else ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100, 2) end as PERFORMANCE,
				--CUMPL DIARIAS else (prom_diarias / cast (2.5 as float)) end
				--INFORMADAS    else (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) end
				--GARANTIAS     else 4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2)) end
		round (@tecnicos / 4, 0) as cuartil

from q4s_30d left join contratas
on q4s_30d.id_contrata = contratas.id_contrata
where q4s_30d.id_contrata = @id_contra and
		q4s_30d.Fecha = (Select top 1 Fecha from q4s_30d order by fecha desc)
order by ROUND(cast(q4s_30d.Instalaciones as float) / cast(q4s_30d.dias_trabajo as float), 2)
--order by ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100) desc
end

if ((@mes is not null or @mes <> '') and @dias = '30')
begin
set @tecnicos = (select count(*) from q4s_30d where id_contrata = @id_contra and Fecha = @mes)

select cast (q4s_30d.Fecha as varchar(7)) as Fecha,
		contratas.descripcion_contrata as Empresa,
		q4s_30d.Tecnico,
		q4s_30d.Instalaciones,
		q4s_30d.Garantias,
		ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2) as Porc,
		case when Garantias = 0 then 0
				when ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then 120
				else ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) end as [Cumpl. Obj. Garantias],
		(select count(*) from mon_gestionados2 where id_recurso = id_tecnico) as Monitoreos,
		q4s_30d.[No Realizado],
		q4s_30d.Suspendido,
		q4s_30d.dias_trabajo,
		ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 ) as [Porc. Informados],
		case when q4s_30d.[No Realizado] + q4s_30d.Suspendido = 0 then 0
				when ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then 120
				else ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) end as [Cumpl. Obj. Informadas],
		prom_diarias as Produccion,
		case when ROUND ((prom_diarias / cast (2.5 as float)) * 100.00, 2) > 120 then 120
				else ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) end as [Cumpl. Obj. Inst. diarias],
		case when Garantias = 0 or q4s_30d.[No Realizado] + q4s_30d.Suspendido = 0 then 0
				-- when alguna de las 3 variales da mayor a 120%
				when ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then cast (1.2 as float) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * cast (1.2 as float) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * cast (1.2 as float) * 100
				else ROUND ((4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100, 2) end as PERFORMANCE,
				--CUMPL DIARIAS else (prom_diarias / cast (2.5 as float)) end
				--INFORMADAS    else (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) end
				--GARANTIAS     else 4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2)) end
		round (@tecnicos / 4, 0) as cuartil

from q4s_30d left join contratas
on q4s_30d.id_contrata = contratas.id_contrata
where q4s_30d.id_contrata = @id_contra and q4s_30d.Fecha = @mes
order by ROUND(cast(q4s_30d.Instalaciones as float) / cast(q4s_30d.dias_trabajo as float), 2)
--order by ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100) desc
end

if ((@mes is null or @mes = '') and @dias = '7')
begin
set @tecnicos = (select count(*) from q4s_7d where id_contrata = @id_contra and Fecha = (Select top 1 Fecha from q4s_7d order by fecha desc))

select cast (q4s_7d.Fecha as varchar(7)) as Fecha,
		contratas.descripcion_contrata as Empresa,
		q4s_7d.Tecnico,
		q4s_7d.Instalaciones,
		q4s_7d.Garantias,
		ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2) as Porc,
		case when q4s_7d.Garantias = 0 then 0
				when ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then 120
				else ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) end as [Cumpl. Obj. Garantias],
		(select count(*) from mon_gestionados2 where id_recurso = id_tecnico) as Monitoreos,
		q4s_7d.[No Realizado],
		q4s_7d.Suspendido,
		q4s_7d.dias_trabajo,
		ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 ) as [Porc. Informados],
		case when q4s_7d.[No Realizado] + q4s_7d.Suspendido = 0 then 0
				when ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then 120
				else ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) end as [Cumpl. Obj. Informadas],
		prom_diarias as Produccion,
		case when ROUND ((prom_diarias / cast (2.5 as float)) * 100.00, 2) > 120 then 120
				else ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) end as [Cumpl. Obj. Inst. diarias],
		case when Garantias = 0 or q4s_7d.[No Realizado] + q4s_7d.Suspendido = 0 then 0
				-- when alguna de las 3 variales da mayor a 120%
				when ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then cast (1.2 as float) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * cast (1.2 as float) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * cast (1.2 as float) * 100
				else ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100, 2) end as PERFORMANCE,
				--CUMPL DIARIAS else (prom_diarias / cast (2.5 as float)) end
				--INFORMADAS    else (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) end
				--GARANTIAS     else 4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2)) end
		round (@tecnicos / 4, 0) as cuartil

from q4s_7d left join contratas
on q4s_7d.id_contrata = contratas.id_contrata
where q4s_7d.id_contrata = @id_contra and
		q4s_7d.Fecha = (Select top 1 Fecha from q4s_7d order by fecha desc)
order by ROUND(cast(q4s_7d.Instalaciones as float) / cast(q4s_7d.dias_trabajo as float), 2)
--order by ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100) desc
end

if ((@mes is not null or @mes <> '') and @dias = '7')
begin
set @tecnicos = (select count(*) from q4s_7d where id_contrata = @id_contra and Fecha = @mes)

select cast (q4s_7d.Fecha as varchar(7)) as Fecha,
		contratas.descripcion_contrata as Empresa,
		q4s_7d.Tecnico,
		q4s_7d.Instalaciones,
		q4s_7d.Garantias,
		ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2) as Porc,
		case when Garantias = 0 then 0
				when ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then 120
				else ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) end as [Cumpl. Obj. Garantias],
		(select count(*) from mon_gestionados2 where id_recurso = id_tecnico) as Monitoreos,
		q4s_7d.[No Realizado],
		q4s_7d.Suspendido,
		q4s_7d.dias_trabajo,
		ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 ) as [Porc. Informados],
		case when q4s_7d.[No Realizado] + q4s_7d.Suspendido = 0 then 0
				when ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then 120
				else ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) end as [Cumpl. Obj. Informadas],
		prom_diarias as Produccion,
		case when ROUND ((prom_diarias / cast (2.5 as float)) * 100.00, 2) > 120 then 120
				else ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) end as [Cumpl. Obj. Inst. diarias],
		case when Garantias = 0 or q4s_7d.[No Realizado] + q4s_7d.Suspendido = 0 then 0
				-- when alguna de las 3 variales da mayor a 120%
				when ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * 100, 2) > 120 then cast (1.2 as float) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * cast (1.2 as float) * (prom_diarias / cast (2.5 as float)) * 100
				when ROUND ((prom_diarias / cast (2.5 as float)) * 100, 2) > 120 then (4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * cast (1.2 as float) * 100
				else ROUND ((4 / (ROUND ((cast (q4s_7d.Garantias as float) / cast (q4s_7d.Instalaciones as float)) * 100, 2))) * (30 / ROUND (cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido) as float) / cast ((q4s_7d.[No Realizado] + q4s_7d.Suspendido + q4s_7d.Instalaciones) as float) * 100, 2 )) * (prom_diarias / cast (2.5 as float)) * 100, 2) end as PERFORMANCE,
				--CUMPL DIARIAS else (prom_diarias / cast (2.5 as float)) end
				--INFORMADAS    else (30 / ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 )) end
				--GARANTIAS     else 4 / (ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2)) end
		round (@tecnicos / 4, 0) as cuartil

from q4s_7d left join contratas
on q4s_7d.id_contrata = contratas.id_contrata
where q4s_7d.id_contrata = @id_contra and q4s_7d.Fecha = @mes
order by ROUND(cast(q4s_7d.Instalaciones as float) / cast(q4s_7d.dias_trabajo as float), 2)
--order by ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100) desc
end
/*
select cast (q4s_30d.Fecha as varchar(7)) as Fecha,
		contratas.descripcion_contrata as Empresa,
		q4s_30d.Tecnico,
		q4s_30d.Instalaciones,
		q4s_30d.Garantias,
		ROUND ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100, 2) as Porc,
		q4s_30d.Monitoreos,
		q4s_30d.[No Realizado],
		q4s_30d.Suspendido,
		ROUND (cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido) as float) / cast ((q4s_30d.[No Realizado] + q4s_30d.Suspendido + q4s_30d.Instalaciones) as float) * 100, 2 ) as [Porc. Informados],
		round (@tecnicos / 4, 0) as cuartil

from q4s_30d left join contratas
on q4s_30d.id_contrata = contratas.id_contrata
where q4s_30d.id_contrata = @id_contra
order by ((cast (q4s_30d.Garantias as float) / cast (q4s_30d.Instalaciones as float)) * 100) desc
*/