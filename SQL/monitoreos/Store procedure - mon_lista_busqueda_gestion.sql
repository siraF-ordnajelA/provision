alter procedure mon_lista_busqueda_gestion
@tecnico int,
@fecha varchar(10)

as

select top 1 LEFT(cast ([Fecha de carga] as date), 10) as [Fecha de carga],
		[Fecha de monitoreo],
		[Usuario Auditor],
		[Motivo Calibraci�n],
		[Monitoreo realizado],
		id_medallia,
		Contexto,
		[Nombre del Tecnico],
		id_recurso,
		Ingresante,
		Contratista,
		DNI,
		Credencial,
		[Equipo Cel.],
		[Estado del Vehiculo],
		Escalera,
		[Porta escalera],
		Identificacion,
		Patente,
		[KIT de sanidad],
		Vestimenta,
		EPP,
		[M�todo constructivo],
		[Drop plano],
		[Drop circular],
		observaciones,
		-- CONOCIMIENTO USO DE APP
		[Conocimiento uso - Mobbi 2.0],
		[Conocimiento uso - PDR],
		[Conocimiento uso - Escaner QR],
		[Conocimiento uso - WiFi analizer],
		[Conocimiento uso - Smart WiFi],
		-- HERRAMIENTAS FIBRA
		[Herramientas Kit Fibra - Tijera Kevlar],
		[Herramientas Kit Fibra - Cortadora Cleaver],
		[Herramientas Kit Fibra - Power Meter],
		[Herramientas Kit Fibra - Pinza peladora triple ranura],
		[Herramientas Kit Fibra - Peladora Drop rect],
		[Herramientas Kit Fibra - Alcohol],
		[Herramientas Kit Fibra - Pa�os],
		[Herramientas Kit Fibra - Linterna l�ser],
		-- APP INSTALADAS
		[APP instaladas - Mobbi 2.0],
		[APP instaladas - Lector QR],
		[APP instaladas - PDR],
		[APP instaladas - WiFi Analizer],
		-- PROCESOS Y CONOCIMIENTO
		[Procesos - IPTV],
		[Procesos - HGU],
		[Procesos - VoIp],
		-- HERRAMIENTAS COBRE
		[Cobre adaptaci�n VoIp - Alicate],
		[Cobre adaptaci�n VoIp - Pinzas],
		[Cobre adaptaci�n VoIp - Destornillador],
		[Cobre adaptaci�n VoIp - Agujereadora/Mechas],
		[Cobre adaptaci�n VoIp - Microtel�fono],
		[Cobre adaptaci�n VoIp - Cable inst. interna],
		[Cobre adaptaci�n VoIp - Ficha americana],
		[Cobre adaptaci�n VoIp - Filtros combinado],
		[Cobre adaptaci�n VoIp - Martillo],
		[Cobre adaptaci�n VoIp - Pela cable],
		[Cobre adaptaci�n VoIp - Alargue],
		[Resultado Final]

from mon_lista_gestionados_tecnico --"mon_lista_gestionados_tecnico" es una vista.
where cast ([Fecha de carga] as date) = @fecha and id_recurso = @tecnico