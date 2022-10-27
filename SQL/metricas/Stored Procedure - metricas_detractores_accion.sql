alter procedure metricas_detractores_accion
@empresa tinyint,
@fecha1 varchar(8),
@fecha2 varchar(8),
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


IF(@opc = 1)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from lista_medallia_casos where cast(fecha_mail as date) >= @fecha_inicio)
		
		IF (@empresa = 0)
		BEGIN
			-- ACCION EJECUTADA
			select [Acci�n ejecutada] as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from lista_medallia_casos
			where cast(fecha_mail as date) >= @fecha_inicio
			group by [Acci�n ejecutada]
			order by count(*) desc
		END
		ELSE
		BEGIN
			-- ACCION EJECUTADA
			select [Acci�n ejecutada] as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from lista_medallia_casos
			where cast(fecha_mail as date) >= @fecha_inicio and
					id_empresa = @id_ctta
			group by [Acci�n ejecutada]
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from lista_medallia_casos where cast(fecha_mail as date) between @fecha1 and @fecha2)
		
		IF (@empresa = 0)
		BEGIN
			select [Acci�n ejecutada] as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from lista_medallia_casos
			where cast(fecha_mail as date) between @fecha1 and @fecha2
			group by [Acci�n ejecutada]
			order by count(*) desc
		END
		ELSE
		BEGIN
			select [Acci�n ejecutada] as Accion_ejecutada,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from lista_medallia_casos
			where cast(fecha_mail as date) between @fecha1 and @fecha2 and
					id_empresa = @id_ctta
			group by [Acci�n ejecutada]
			order by count(*) desc
		END
	END
END



IF(@opc = 2)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio)

		IF (@empresa = 0)
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio
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
					id_empresa = @id_ctta
			group by region_mop
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2)
		
		IF (@empresa = 0)
		BEGIN
			-- REGION
			select region_mop,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2
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
					id_empresa = @id_ctta
			group by region_mop
			order by count(*) desc
		END
	END
END




IF(@opc = 3)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio)
		
		IF (@empresa = 0)
		BEGIN
			-- SEGMENTO
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio
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
					id_empresa = @id_ctta
			group by segmento
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2)
		
		IF (@empresa = 0)
		BEGIN
			select segmento,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2
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
					id_empresa = @id_ctta
			group by segmento
			order by count(*) desc
		END
	END
END




IF(@opc = 4)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio
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
					id_empresa = @id_ctta
			group by tecnologia
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select tecnologia,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2
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
					id_empresa = @id_ctta
			group by tecnologia
			order by count(*) desc
		END
	END
END




IF(@opc = 5)
BEGIN
	IF(@fecha1 is null or @fecha1 = '' or @fecha1 = 0 or @fecha2 = 0)
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) >= @fecha_inicio)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) >= @fecha_inicio
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
					id_empresa = @id_ctta
			group by localidad
			order by count(*) desc
		END
	END

	ELSE
	BEGIN
		set @totales = (select count(*) from medallia_encuestas where cast(fecha_mail as date) between @fecha1 and @fecha2)
		
		IF (@empresa = 0)
		BEGIN
			-- TECNOLOGIA
			select top 10 localidad,
					count(*) as casos,
					@totales as totales,
					round((cast(count(*) as float) / cast(@totales as float)) * 100, 2) as Porcentaje

			from medallia_encuestas
			where cast(fecha_mail as date) between @fecha1 and @fecha2
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
					id_empresa = @id_ctta
			group by localidad
			order by count(*) desc
		END
	END
END