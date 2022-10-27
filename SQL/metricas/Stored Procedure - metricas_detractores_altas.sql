alter procedure metricas_detractores_altas
@empresa tinyint,
@fecha1 varchar(8),
@fecha2 varchar(8),
@opc tinyint

as

declare @fecha_inicio date
declare @id_ctta tinyint
set @fecha_inicio = cast ((dateadd(month, datediff(month, '19000101', getdate()), '19000101')) as date)--INICIO MES ACTUAL

IF(@empresa = 12)
BEGIN
set @id_ctta = 0
END
ELSE
BEGIN
	set @id_ctta = @empresa
END

create table #instalaciones (Empresa varchar(100),
							id_empresa tinyint,
							segmento varchar(20),
							tecnologia varchar(20),
							Bucket varchar(509),
							region_mop varchar(50),
							distrito varchar(50),
							localidad varchar(50))

--INSERTO INSTALADOS FTTH
IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
BEGIN
	insert into #instalaciones (Empresa, id_empresa, segmento, tecnologia, Bucket, region_mop, distrito, localidad)

	select a.Empresa,
			b.id_contrata,
			a.[Segmento del cliente],
			a.tecnologia,
			a.[Bucket Inicial],
			a.region_mop,
			a.distrito,
			a.distrito_op_atc

	from ATC.dbo.toa_pm as a left join contratas as b
	on a.Empresa = b.descripcion_contrata
	where cast(a.timestamp as date) >= @fecha_inicio and
			a.alta = 1 and
			a.[Estado de la orden] = 'Completado' and
			a.tecnologia <> 'cobre'
END

ELSE
BEGIN
	insert into #instalaciones (Empresa, id_empresa, segmento, tecnologia, Bucket, region_mop, distrito, localidad)

	select a.Empresa,
			b.id_contrata,
			a.[Segmento del cliente],
			a.tecnologia,
			a.[Bucket Inicial],
			a.region_mop,
			a.distrito,
			a.distrito_op_atc

	from ATC.dbo.toa_pm as a left join contratas as b
	on a.Empresa = b.descripcion_contrata
	where (cast(a.timestamp as date) between @fecha1 and @fecha2) and
			a.alta = 1 and
			a.[Estado de la orden] = 'Completado' and
			a.tecnologia <> 'cobre'
END


--------------------------------------------------------------------------

IF(@opc = 1)
BEGIN
	create table #instalados_empresa(Empresa varchar(120), Instalados int, casos int)
	create table #detractores_empresa(Empresa varchar(120), motivo varchar(50), casos int)

	-- ALTAS POR EMPRESA
	insert into #instalados_empresa (Empresa, Instalados)

	select Empresa, count(*)
	from #instalaciones
	group by Empresa

	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		-- DETRACTORES POR EMPRESA
		insert into #detractores_empresa (Empresa, motivo, casos)

		select descripcion_contrata,
				[Motivo detractor],
				count(*)
		from lista_medallia_casos
		where fecha_mail >= @fecha_inicio
		group by descripcion_contrata, [Motivo detractor]
	END

	ELSE
	BEGIN
		-- DETRACTORES POR EMPRESA
		insert into #detractores_empresa (Empresa, motivo, casos)

		select descripcion_contrata,
				[Motivo detractor],
				count(*)
		from lista_medallia_casos
		where fecha_mail between @fecha1 and @fecha2
		group by descripcion_contrata, [Motivo detractor]
	END

--SELECCION DETRACTORES ALTAS POR EMPRESA
merge into #instalados_empresa as origen
using (select Empresa, sum(casos) as cant
		from #detractores_empresa
		group by Empresa) as destino
		
on origen.Empresa = destino.Empresa
when matched then
update set origen.casos = destino.cant;

update #instalados_empresa
set casos = 0
where casos is null

select *,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje
from #instalados_empresa
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc
END




IF(@opc = 2)
BEGIN
	create table #detractores_region(region varchar(50), Instalados int, casos int)
	
	-- ALTAS POR REGION
	insert into #detractores_region (region, Instalados)

	select region_mop, count(*)
	from #instalaciones
	group by region_mop

	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		IF (@empresa = 0)
		BEGIN
			-- DETRACTORES POR REGION
			merge into #detractores_region as destino
			using (select region_mop,
							count(*) as casos
					from medallia_encuestas
					where fecha_mail >= @fecha_inicio
					group by region_mop) as origen
			
			on destino.region = origen.region_mop
			
			when matched then update
			set destino.casos = origen.casos;
		END
		ELSE
		BEGIN
			merge into #detractores_region as destino
			using (select region_mop,
							count(*) as casos
					from medallia_encuestas
					where fecha_mail >= @fecha_inicio and
					id_empresa = @id_ctta
					group by region_mop) as origen
			
			on destino.region = origen.region_mop
			
			when matched then update
			set destino.casos = origen.casos;
		END
	END

	ELSE
	BEGIN
		IF (@empresa = 0)
		BEGIN
			-- DETRACTORES ALTAS POR REGION
			merge into #detractores_region as destino
			using (select region_mop,
							count(*) as casos
					from medallia_encuestas
					where fecha_mail between @fecha1 and @fecha2
					group by region_mop) as origen
			
			on destino.region = origen.region_mop
			
			when matched then update
			set destino.casos = origen.casos;
		END
		ELSE
		BEGIN
			merge into #detractores_region as destino
			using (select region_mop,
							count(*) as casos
					from medallia_encuestas
					where fecha_mail between @fecha1 and @fecha2 and
					id_empresa = @id_ctta
					group by region_mop) as origen
			
			on destino.region = origen.region_mop
			
			when matched then update
			set destino.casos = origen.casos;
		END
	END

--SELECCION DETRACTORES POR REGION
update #detractores_region
set casos = 0
where casos is null

select region,
		Instalados,
		casos,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje

from #detractores_region
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc
END




IF(@opc = 3)
BEGIN
create table #detractores_segmento(Segmento varchar(11), Instalados int, casos int)

-- ALTAS POR SEGMENTO
	insert into #detractores_segmento (Segmento, Instalados)

	select segmento, count(*)
	from #instalaciones
	group by segmento

IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
BEGIN
	IF (@empresa = 0)
	BEGIN
		-- DETRACTORES ALTAS POR SEGMENTO
		merge into #detractores_segmento as destino
		using (select segmento,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail >= @fecha_inicio
				group by segmento) as origen
				
		on destino.Segmento = origen.segmento
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_segmento as destino
		using (select segmento,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail >= @fecha_inicio and
				id_empresa = @id_ctta
				group by segmento) as origen
				
		on destino.Segmento = origen.segmento
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

ELSE
BEGIN
	IF (@empresa = 0)
	BEGIN
		-- DETRACTORES ALTAS POR SEGMENTO
		merge into #detractores_segmento as destino
		using (select segmento,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2
				group by segmento) as origen
				
		on destino.Segmento = origen.segmento
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_segmento as destino
		using (select segmento,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2 and
				id_empresa = @id_ctta
				group by segmento) as origen
				
		on destino.Segmento = origen.segmento
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

--SELECCION DETRACTORES POR SEGMENTO
update #detractores_segmento
set casos = 0
where casos is null

select Segmento,
		Instalados,
		casos,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje

from #detractores_segmento
where Segmento <> ''
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc
END




IF(@opc = 4)
BEGIN
create table #detractores_tecnologia(tecnologia varchar(25), Instalados int, casos int)

-- ALTAS POR TECNOLOGIA
	insert into #detractores_tecnologia (tecnologia, Instalados)

	select tecnologia, count(*)
	from #instalaciones
	group by tecnologia

IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
BEGIN
	IF (@empresa = 0)
	BEGIN
		-- DETRACTORES ALTAS POR TECNOLOGIA
		merge into #detractores_tecnologia as destino
		using (select tecnologia,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail >= @fecha_inicio
				group by tecnologia) as origen
				
		on destino.tecnologia = origen.tecnologia
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_tecnologia as destino
		using (select tecnologia,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail >= @fecha_inicio and
				id_empresa = @id_ctta
				group by tecnologia) as origen
				
		on destino.tecnologia = origen.tecnologia
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

ELSE
BEGIN
	IF (@empresa = 0)
	BEGIN
		merge into #detractores_tecnologia as destino
		using (select tecnologia,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2
				group by tecnologia) as origen
				
		on destino.tecnologia = origen.tecnologia
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_tecnologia as destino
		using (select tecnologia,
						count(*) as cant

				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2 and
				id_empresa = @id_ctta
				group by tecnologia) as origen
				
		on destino.tecnologia = origen.tecnologia
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

--SELECCION DETRACTORES POR TECNOLOGIA
update #detractores_tecnologia
set casos = 0
where casos is null

select tecnologia,
		Instalados,
		casos,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje

from #detractores_tecnologia
where tecnologia is not null
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc
END




IF(@opc = 5)
BEGIN
create table #detractores_localidad(localidad varchar(150), Instalados int, casos int)

-- ALTAS POR LOCALIDAD
	insert into #detractores_localidad (localidad, Instalados)

	select localidad, count(*)
	from #instalaciones
	group by localidad

IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
BEGIN
	IF (@empresa = 0)
	BEGIN
		-- DETRACTORES POR LOCALIDAD
		merge into #detractores_localidad as destino
		using (select localidad,
						count(*) as cant
				from medallia_encuestas
				where fecha_mail >= @fecha_inicio and
						localidad <> ''
				group by localidad) as origen
		
		on destino.localidad = origen.localidad
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_localidad as destino
		using (select localidad,
						count(*) as cant
				from medallia_encuestas
				where fecha_mail >= @fecha_inicio and
						localidad <> '' and
						id_empresa = @id_ctta
				group by localidad) as origen
		
		on destino.localidad = origen.localidad
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

ELSE
BEGIN
	IF (@empresa = 0)
	BEGIN
		merge into #detractores_localidad as destino
		using (select localidad,
						count(*) as cant
				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2 and
						localidad <> ''
				group by localidad) as origen
		
		on destino.localidad = origen.localidad
		
		when matched then update
		set destino.casos = origen.cant;
	END
	ELSE
	BEGIN
		merge into #detractores_localidad as destino
		using (select localidad,
						count(*) as cant
				from medallia_encuestas
				where fecha_mail between @fecha1 and @fecha2 and
						localidad <> '' and
						id_empresa = @id_ctta
				group by localidad) as origen
		
		on destino.localidad = origen.localidad
		
		when matched then update
		set destino.casos = origen.cant;
	END
END

--SELECCION DETRACTORES POR LOCALIDAD
update #detractores_localidad
set casos = 0
where casos is null

select top 10 localidad,
		Instalados,
		casos,
		round((cast(casos as float) / cast(Instalados as float)) * 100, 2) as Porcentaje

from #detractores_localidad
order by (cast(casos as float) / cast(Instalados as float)) * 100 desc
END