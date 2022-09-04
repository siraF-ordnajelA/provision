use CCP
--set dateformat 'mdy'

insert into provision_toa ([T�cnico],
	[ID RECURSO],
	[Subtipo de Actividad],
	[C�digo de actuaci�n],
	[N�mero de Petici�n],
	[N�mero de Orden],
	[Empresa],
	[Fecha de Emisi�n/Reclamo],
	[Intervalo de tiempo],
	[SLA Inicio],
	[SLA Fin],
	[Ciudad],
	[Direcci�n],
	[Direcci�n (componente vertical)],
	[Direccion Polar X],
	[Direccion Polar Y],
	[Central_Manzana],
	[Zona de Trabajo],
	[Segmento del cliente],
	[Nombre],
	[Telefono Contacto 1],
	[Telefono Contacto 2],
	[N�mero Tel�fono],
	[Tiempo de Viaje],
	[Duraci�n de la actividad],
	[Habilidad del trabajo],
	[Estado de la orden],
	[Pendiente instancia externa],
	[Categor�a de Capacidad],
	[Tecnologia Voz],
	[Tecnologia Banda Ancha],
	[Tecnologia TV],
	[Multiproducto],
	[Tipo de Acceso],
	[Tipo Equipo de Acceso],
	[Tipo de Terminaci�n],
	[S�ntoma],
	[Diagn�stico Inicial],
	[Diagn�stico Actual],
	[Repetido],
	[Garant�a],
	[Validaci�n t�cnica],
	[Rural],
	[Zona Peligrosa],
	[Cable Primario],
	[Par Primario],
	[Par Secundario],
	[Pin ADSL],
	[Bloque ADSL],
	[N�mero de equipo de PI],
	[Armario],
	[Nivel de Urgencia (Prioridad)],
	[Prioridad],
	[Central],
	[Nombre Central],
	[Fecha de Cita Original],
	[Bucket Inicial],
	[Reitero_48HS],
	[Cuadrante],
	[Manzana],
	[Ventana de servicio],
	[Ventana de Llegada],
	[Correo electronico],
	[Cr�nico],
	[Desviado],
	[Ubicacion],
	[Enrutado autom�tico a fecha],
	[Cita ID],
	[Razon de Suspension Instalacion],
	[Motivo no realizado instalaci�n],
	[Comentarios Tecnico],
	[A_SLOW_NAVIGATION],
	[A_VOIP_NOT_WORKING],
	[Primera operaci�n manual],
	[Distancia a la Ubicacion mas cercana],
	[Primera operaci�n manual realizada por usuario],
	[Usuario que autorizo el cierre],
	[Fecha/Hora de autorizacion del cierre],
	[Fecha/Hora de autorizacion de la suspension],
	[Usuario que autorizo la suspension],
	[Fecha/Hora de autorizacion del quiebre],
	[Usuario que Autoriza Informar],
	[Access ID],
	[Recordatorio Realizado],
	[Respuesta del Cliente],
	[Fecha de respuesta del cliente],
	[Cita al ingreso],
	[Tipo de cliente],
	[Subtipo de cliente],
	Programacion,
	Actualizacion,
	[Fecha creacion toa]
)

select LEFT ([T�cnico], 100),
	case when ISNUMERIC ([ID RECURSO]) = 0 then null else LEFT ([ID RECURSO], 5) end as ID_RECURSO,
	LEFT ([Subtipo de Actividad], 80) as Subtipo_actividad,
	LEFT ([C�digo de actuaci�n], 80) as Cod_actuacion,
	LEFT ([N�mero de Petici�n], 50) as Peticion,
	LEFT ([N�mero de Orden], 50) as Orden,
	LEFT ([Empresa], 50) as Empresa,
	case when [Fecha de Emisi�n/Reclamo] = '' then null else cast ([Fecha de Emisi�n/Reclamo] as date) end as f_emison_recl,
	LEFT ([Intervalo de tiempo], 10) as Intervalo_tiempo,
	case when [SLA Inicio] = '' then null else CAST ((SUBSTRING (REPLACE([SLA Inicio],'\',''), 1, 2) + SUBSTRING (REPLACE([SLA Inicio],'\',''), 3, 3) + '/20' + SUBSTRING (REPLACE([SLA Inicio],'\',''), 7, 2)) as smalldatetime) end as sla_ini,
	case when [SLA Fin] = '' then null else CAST ((SUBSTRING (REPLACE([SLA Fin],'\',''), 1, 2) + SUBSTRING (REPLACE([SLA Fin],'\',''), 3, 3) + '/20' + SUBSTRING (REPLACE([SLA Fin],'\',''), 7, 2)) as smalldatetime) end as sla_fini,
	LEFT ([Ciudad], 100) as Ciudad,
	[Direcci�n],
	[Direcci�n (componente vertical)],
	LEFT ([Direccion Polar X], 30) as Direccion_Polar_X,
	LEFT ([Direccion Polar Y], 30) as Direccion_Polar_Y,
	LEFT ([Central_Manzana], 12) as Central_Mzna,
	LEFT ([Zona de Trabajo], 150) as Zona_Trabajo,
	LEFT ([Segmento del cliente], 20) as Seg_cliente,
	LEFT ([Nombre], 120),
	LEFT ([Telefono Contacto 1], 15),
	LEFT ([Telefono Contacto 2], 15),
	LEFT ([N�mero Tel�fono], 15),
	LEFT ([Tiempo de Viaje], 8),
	LEFT ([Duraci�n de la actividad], 8),
	LEFT ([Habilidad del trabajo], 120),
	LEFT ([Estado de la orden], 25),
	LEFT ([Pendiente instancia externa], 80),
	LEFT ([Categor�a de Capacidad], 100),
	LEFT ([Tecnologia Voz], 20),
	LEFT ([Tecnologia Banda Ancha], 20),
	LEFT ([Tecnologia TV], 20),
	LEFT ([Multiproducto], 50),
	LEFT ([Tipo de Acceso], 25),
	LEFT ([Tipo Equipo de Acceso], 25),
	LEFT ([Tipo de Terminaci�n], 25),
	LEFT ([S�ntoma], 80),
	LEFT ([Diagn�stico Inicial], 100),
	LEFT ([Diagn�stico Actual], 80),
	LEFT ([Repetido], 2),
	LEFT ([Garant�a], 3),
	LEFT ([Validaci�n t�cnica], 3),
	LEFT ([Rural], 3),
	LEFT ([Zona Peligrosa], 3),
	case when ISNUMERIC ([Cable Primario]) = 0 then null else LEFT ([Cable Primario], 5) end,
	case when ISNUMERIC ([Par Primario]) = 0 then null else LEFT ([Par Primario], 5) end,
	case when ISNUMERIC ([Par Secundario]) = 0 then null else LEFT ([Par Secundario], 5) end,
	case when ISNUMERIC ([Pin ADSL]) = 0 then null else LEFT ([Pin ADSL], 3) end,
	LEFT ([Bloque ADSL], 8),
	LEFT ([N�mero de equipo de PI], 15),
	LEFT ([Armario], 15),
	LEFT ([Nivel de Urgencia (Prioridad)], 3),
	case when ISNUMERIC ([Prioridad]) = 0 then null else LEFT ([Prioridad], 3) end,
	case when ISNUMERIC ([Central]) = 0 then null else LEFT ([Central], 5) end,
	LEFT ([Nombre Central], 50),
	case when [Fecha de Cita Original] = '' then null else [Fecha de Cita Original] end,
	LEFT ([Bucket Inicial], 80),
	LEFT ([Reitero_48HS], 3),
	LEFT ([Cuadrante], 15),
	case when ISNUMERIC ([Manzana]) = 0 then null else LEFT ([Manzana], 5) end,
	LEFT ([Ventana de servicio], 10),
	LEFT ([Ventana de Llegada], 10),
	LEFT ([Correo electronico], 150),
	LEFT ([Cr�nico], 3),
	LEFT ([Desviado], 3),
	LEFT ([Ubicacion], 50),
	case when [Enrutado autom�tico a fecha] = '' then null
			when [Enrutado autom�tico a fecha] = '-' then null else '20' + RIGHT (REPLACE([Enrutado autom�tico a fecha],'/',1), 2) + '-' + LEFT (REPLACE([Enrutado autom�tico a fecha],'/',1), 2) + '-' + SUBSTRING (REPLACE([Enrutado autom�tico a fecha],'/',1), 4, 2) end as [Enrutado auto],
	case when ISNUMERIC ([Cita ID]) = 0 then null else LEFT ([Cita ID], 8) end,
	LEFT ([Razon de Suspension Instalacion], 100),
	LEFT ([Motivo no realizado instalaci�n], 150),
	[Comentarios Tecnico],
	LEFT ([A_SLOW_NAVIGATION], 3),
	LEFT ([A_VOIP_NOT_WORKING], 3),
	LEFT ([Primera operaci�n manual], 80),
	case when ISNUMERIC ([Distancia a la Ubicacion mas cercana]) = 0 or [Distancia a la Ubicacion mas cercana] > 32000 then null else LEFT ([Distancia a la Ubicacion mas cercana], 5) end,
	case when ISNUMERIC ([Primera operaci�n manual realizada por usuario]) = 0 then null else LEFT ([Primera operaci�n manual realizada por usuario], 5) end,
	LEFT ([Usuario que autorizo el cierre], 100),
	case when [Fecha/Hora de autorizacion del cierre] = '' OR LEFT([Fecha/Hora de autorizacion del cierre],1) <> 2 then null
				--when LEN([Fecha/Hora de autorizacion del cierre]) = 10 then null
				else cast ([Fecha/Hora de autorizacion del cierre] as smalldatetime) end  as [F autoriza Cierre],
	case when [Fecha/Hora de autorizacion de la suspension] = '' OR LEFT([Fecha/Hora de autorizacion de la suspension],1) <> 2 then null
			--when LEN([Fecha/Hora de autorizacion de la suspension]) = 10 then null
			else [Fecha/Hora de autorizacion de la suspension] end  as [F autoriza Suspension],
	LEFT ([Usuario que autorizo la suspension.], 100),
	case when [Fecha/Hora de autorizacion del quiebre] = '' then null
			when LEN([Fecha/Hora de autorizacion del quiebre]) = 10 then [Fecha/Hora de autorizacion del quiebre] + ' 00:00:00'
			else [Fecha/Hora de autorizacion del quiebre] end  as [F autoriza quiebre],
	LEFT ([Usuario que Autoriza Informar], 150),
	case when ISNUMERIC ([Access ID]) = 0 then null else [Access ID] end as Access,
	LEFT ([Recordatorio Realizado], 3),
	LEFT ([Respuesta del Cliente], 10),
	case when [Fecha de respuesta del cliente] = '' then null else [Fecha de respuesta del cliente] end,
	case when [Cita al ingreso] = '' then null else [Cita al ingreso] end,
	LEFT ([Tipo de cliente], 50),
	LEFT ([Subtipo de cliente], 50),
	'NO PROGRAMADO',
	cast (timestamp as smalldatetime) as Actualizacion,
	--cast (getdate() as smalldatetime) as Actualizacion,
	case when LEFT([Fecha Ingreso TOA], 2) <> '20' then null
			else [Fecha Ingreso TOA] end as [Fecha Ingreso TOA]

from [10.249.15.194\DATAFLOW].ATC.dbo.toa_no_programado

/*
from OPENQUERY ([10.244.89.164], '
select [T�cnico],
	[ID RECURSO],
	[Subtipo de Actividad],
	[C�digo de actuaci�n],
	[N�mero de Petici�n],
	[N�mero de Orden],
	[Empresa],
	[Fecha de Emisi�n/Reclamo],
	[Intervalo de tiempo],
	[SLA Inicio],
	[SLA Fin],
	[Ciudad],
	[Direcci�n],
	[Direcci�n (componente vertical)],
	[Direccion Polar X],
	[Direccion Polar Y],
	[Central_Manzana],
	[Zona de Trabajo],
	[Segmento del cliente],
	[Nombre],
	[Telefono Contacto 1],
	[Telefono Contacto 2],
	[N�mero Tel�fono],
	[Tiempo de Viaje],
	[Duraci�n de la actividad],
	[Habilidad del trabajo],
	[Estado de la orden],
	[Pendiente instancia externa],
	[Categor�a de Capacidad],
	[Tecnologia Voz],
	[Tecnologia Banda Ancha],
	[Tecnologia TV],
	[Multiproducto],
	[Tipo de Acceso],
	[Tipo Equipo de Acceso],
	[Tipo de Terminaci�n],
	[S�ntoma],
	[Diagn�stico Inicial],
	[Diagn�stico Actual],
	[Repetido],
	[Garant�a],
	[Validaci�n t�cnica],
	[Rural],
	[Zona Peligrosa],
	[Cable Primario],
	[Par Primario],
	[Par Secundario],
	[Pin ADSL],
	[Bloque ADSL],
	[N�mero de equipo de PI],
	[Armario],
	[Nivel de Urgencia (Prioridad)],
	[Prioridad],
	[Central],
	[Nombre Central],
	[Fecha de Cita Original],
	[Bucket Inicial],
	[Reitero_48HS],
	[Cuadrante],
	[Manzana],
	[Ventana de servicio],
	[Ventana de Llegada],
	[Correo electronico],
	[Cr�nico],
	[Desviado],
	[Ubicacion],
	[Enrutado autom�tico a fecha],
	[Cita ID],
	[Razon de Suspension Instalacion],
	[Motivo no realizado instalaci�n],
	[Comentarios Tecnico],
	[A_SLOW_NAVIGATION],
	[A_VOIP_NOT_WORKING],
	[Primera operaci�n manual],
	[Distancia a la Ubicacion mas cercana],
	[Primera operaci�n manual realizada por usuario],
	[Usuario que autorizo el cierre],
	[Fecha/Hora de autorizacion del cierre],
	[Fecha/Hora de autorizacion de la suspension],
	[Usuario que autorizo la suspension.],
	[Fecha/Hora de autorizacion del quiebre],
	[Usuario que Autoriza Informar],
	[Access ID],
	[Recordatorio Realizado],
	[Respuesta del Cliente],
	[Fecha de respuesta del cliente],
	[Cita al ingreso],
	[Tipo de cliente],
	[Subtipo de cliente],
	timestamp,
	[Fecha Ingreso TOA]
	
from ATC.dbo.toa_no_programado')
*/