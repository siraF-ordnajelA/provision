merge into garantias_descargo as destino
using (select distinct [N�mero de Petici�n],
				[Fecha de Emisi�n Reclamo]
		from ATC.dbo.toa_pm) as origen

on destino.nro_peticion = origen.[N�mero de Petici�n] and
	destino.fecha_ingreso = '1900-01-01 00:00:00'
when matched then update set
destino.fecha_ingreso = origen.[Fecha de Emisi�n Reclamo];