alter procedure metricas_detractores_accion
@empresa tinyint,
@fecha1 varchar(8),
@fecha2 varchar(8),
@motivo varchar(1),
@opc tinyint

as

declare @fecha_inicio date
declare @totales int
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

IF(@motivo = 0)
BEGIN
set @motivo = '_'
END




IF(@opc = 1)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- ACCION EJECUTADA
			select case when accion_ejecutada = 1 then 'Derivado a la contratista'
					when accion_ejecutada = 2 then 'Derivado a clooper comercial'
					when accion_ejecutada = 3 then 'Derivado a soporte sistema'
					when accion_ejecutada = 4 then 'Gestionado por clooper' end as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					motivo_detractor like @motivo
			group by accion_ejecutada
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- ACCION EJECUTADA
			select case when accion_ejecutada = 1 then 'Derivado a la contratista'
					when accion_ejecutada = 2 then 'Derivado a clooper comercial'
					when accion_ejecutada = 3 then 'Derivado a soporte sistema'
					when accion_ejecutada = 4 then 'Gestionado por clooper' end as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by accion_ejecutada
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2 and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			select case when accion_ejecutada = 1 then 'Derivado a la contratista'
					when accion_ejecutada = 2 then 'Derivado a clooper comercial'
					when accion_ejecutada = 3 then 'Derivado a soporte sistema'
					when accion_ejecutada = 4 then 'Gestionado por clooper' end as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					motivo_detractor like @motivo
			group by accion_ejecutada
			order by count(*) desc
		END
		ELSE
		BEGIN
			select case when accion_ejecutada = 1 then 'Derivado a la contratista'
					when accion_ejecutada = 2 then 'Derivado a clooper comercial'
					when accion_ejecutada = 3 then 'Derivado a soporte sistema'
					when accion_ejecutada = 4 then 'Gestionado por clooper' end as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by accion_ejecutada
			order by count(*) desc
		END
	END
END



IF(@opc = 2)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio and motivo_detractor like @motivo)

		IF (@empresa = 0)
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					motivo_detractor like @motivo
			group by region_mop
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by region_mop
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2 and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					motivo_detractor like @motivo
			group by region_mop
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by region_mop
			order by count(*) desc
		END
	END
END




IF(@opc = 3)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- SEGMENTO
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					motivo_detractor like @motivo
			group by segmento
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- SEGMENTO
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by segmento
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2 and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					motivo_detractor like @motivo
			group by segmento
			order by count(*) desc
		END
		ELSE
		BEGIN
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by segmento
			order by count(*) desc
		END
	END
END




IF(@opc = 4)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					motivo_detractor like @motivo
			group by tecnologia
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by tecnologia
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2 and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					motivo_detractor like @motivo
			group by tecnologia
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by tecnologia
			order by count(*) desc
		END
	END
END




IF(@opc = 5)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					motivo_detractor like @motivo
			group by localidad
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by localidad
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2 and motivo_detractor like @motivo)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					motivo_detractor like @motivo
			group by localidad
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta and
					motivo_detractor like @motivo
			group by localidad
			order by count(*) desc
		END
	END
END