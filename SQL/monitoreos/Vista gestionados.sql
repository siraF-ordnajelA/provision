ALTER view [dbo].[mon_lista_gestionados_tecnico]
as

select mon_gestionados2.fyhgestion as [Fecha de carga],
		mon_gestionados2.fyhmonitoreo as [Fecha de monitoreo],
		usuarios.apellido + ' ' + usuarios.nombre as [Usuario Auditor],
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_cita) as [Motivo Calibración],
		(select descripcion_cita from mon_cita where id_cita = mon_gestionados2.id_campo) as [Monitoreo realizado],
		mon_gestionados2.id_medallia,
		mon_covid19.descripcion_kit as Contexto,
		case when mon_gestionados2.id_recurso = 0 then mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec
			 when mon_gestionados2.flag_ingresante = 1 then (select Apellido + ' ' + Nombre from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.nombre end as [Nombre del Tecnico],
		mon_gestionados2.id_recurso,
		mon_gestionados2.flag_ingresante as Ingresante,
		case when mon_gestionados2.flag_ingresante = 1 then (select Ctta from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.ctta end as Contratista,
		case when mon_gestionados2.flag_ingresante = 1 then (select Dni from tecnicos_ingresantes where id_ingresante = mon_gestionados2.id_recurso)
			 else tecnicos.dni end as DNI,
		--mon_gestionados2.apellido_tec + ' ' + mon_gestionados2.nombre_tec as [Nombre del Tecnico Ingresante],
		mon_credencial.descripcion_cred as Credencial,
		mon_equipo_celular.descripcion_eq as [Equipo Cel.],
		mon_vehiculo.descripcion_veh as [Estado del Vehiculo],
		(select descripcion_veh from mon_vehiculo where id_vehiculo = mon_gestionados2.vehiculo_escalera) as Escalera,
		(select descripcion_veh from mon_vehiculo where id_vehiculo = mon_gestionados2.vehiculo_porta_escalera) as [Porta escalera],
		(select descripcion_veh from mon_vehiculo where id_vehiculo = mon_gestionados2.vehiculo_identificacion) as Identificacion,
		mon_gestionados2.vehiculo_patente as Patente,
		(select descripcion_kit from mon_covid19 where id_kit = mon_gestionados2.covid19_kit) as [KIT de sanidad],
		mon_presencia.descripcion_vest as Vestimenta,
		(select descripcion_herr from mon_herramientas where id_herramienta = id_epp) as EPP,
		(select descripcion_herr from mon_herramientas where id_herramienta = metodo_constr) as [Método constructivo],
		(select descripcion_herr from mon_herramientas where id_herramienta = id_drop_plano) as [Drop plano],
		(select descripcion_herr from mon_herramientas where id_herramienta = id_drop_circular) as [Drop circular],
		mon_gestionados2.observaciones,
		-- CONOCIMIENTO USO DE APP
		--(select descripcion_herr from mon_herramientas where id_herramienta = mobbi) as [Conocimiento uso - Mobbi],
		(select descripcion_herr from mon_herramientas where id_herramienta = mobbi20) as [Conocimiento uso - Mobbi 2.0],
		--(select descripcion_herr from mon_herramientas where id_herramienta = whop) as [Conocimiento uso - Whop],
		(select descripcion_herr from mon_herramientas where id_herramienta = pdr) as [Conocimiento uso - PDR],
		(select descripcion_herr from mon_herramientas where id_herramienta = escaner_qr) as [Conocimiento uso - Escaner QR],
		(select descripcion_herr from mon_herramientas where id_herramienta = wifianalizer) as [Conocimiento uso - WiFi analizer],
		(select descripcion_herr from mon_herramientas where id_herramienta = Smartwifi) as [Conocimiento uso - Smart WiFi],
		-- HERRAMIENTAS FIBRA
		(select descripcion_herr from mon_herramientas where id_herramienta = kevlar) as [Herramientas Kit Fibra - Tijera Kevlar],
		(select descripcion_herr from mon_herramientas where id_herramienta = cleaver) as [Herramientas Kit Fibra - Cortadora Cleaver],
		(select descripcion_herr from mon_herramientas where id_herramienta = pw) as [Herramientas Kit Fibra - Power Meter],
		(select descripcion_herr from mon_herramientas where id_herramienta = triple) as [Herramientas Kit Fibra - Pinza peladora triple ranura],
		(select descripcion_herr from mon_herramientas where id_herramienta = [drop]) as [Herramientas Kit Fibra - Peladora Drop rect],
		(select descripcion_herr from mon_herramientas where id_herramienta = alcohol) as [Herramientas Kit Fibra - Alcohol],
		(select descripcion_herr from mon_herramientas where id_herramienta = panios) as [Herramientas Kit Fibra - Paños],
		(select descripcion_herr from mon_herramientas where id_herramienta = laser) as [Herramientas Kit Fibra - Linterna láser],
		-- APP INSTALADAS
		--(select descripcion_app from mon_aplicaciones where id_app = mobbi_instalada) as [APP instaladas - Mobbi],
		(select descripcion_app from mon_aplicaciones where id_app = mobbi20_instalada) as [APP instaladas - Mobbi 2.0],
		--(select descripcion_app from mon_aplicaciones where id_app = whop_instalada) as [APP instaladas - Whop],
		(select descripcion_app from mon_aplicaciones where id_app = qr_instalada) as [APP instaladas - Lector QR],
		(select descripcion_app from mon_aplicaciones where id_app = pdr_instalada) as [APP instaladas - PDR],
		(select descripcion_app from mon_aplicaciones where id_app = wifianalizer_instalada) as [APP instaladas - WiFi Analizer],
		--(select descripcion_app from mon_aplicaciones where id_app = smart_instalada) as [APP instaladas - Smart WiFi],
		-- PROCESOS Y CONOCIMIENTO
		(select descripcion_herr from mon_herramientas where id_herramienta = iptv) as [Procesos - IPTV],
		(select descripcion_herr from mon_herramientas where id_herramienta = hgu) as [Procesos - HGU],
		(select descripcion_herr from mon_herramientas where id_herramienta = voip) as [Procesos - VoIp],
		-- HERRAMIENTAS COBRE
		(select descripcion_herr from mon_herramientas where id_herramienta = alicate) as [Cobre adaptación VoIp - Alicate],
		(select descripcion_herr from mon_herramientas where id_herramienta = pinzas) as [Cobre adaptación VoIp - Pinzas],
		(select descripcion_herr from mon_herramientas where id_herramienta = destornilla) as [Cobre adaptación VoIp - Destornillador],
		(select descripcion_herr from mon_herramientas where id_herramienta = agujereadora) as [Cobre adaptación VoIp - Agujereadora/Mechas],
		(select descripcion_herr from mon_herramientas where id_herramienta = micro) as [Cobre adaptación VoIp - Microteléfono],
		(select descripcion_herr from mon_herramientas where id_herramienta = interna) as [Cobre adaptación VoIp - Cable inst. interna],
		(select descripcion_herr from mon_herramientas where id_herramienta = fichas) as [Cobre adaptación VoIp - Ficha americana],
		(select descripcion_herr from mon_herramientas where id_herramienta = filtros) as [Cobre adaptación VoIp - Filtros combinado],
		(select descripcion_herr from mon_herramientas where id_herramienta = martillo) as [Cobre adaptación VoIp - Martillo],
		(select descripcion_herr from mon_herramientas where id_herramienta = pela_cable) as [Cobre adaptación VoIp - Pela cable],
		(select descripcion_herr from mon_herramientas where id_herramienta = alargue) as [Cobre adaptación VoIp - Alargue],
		case when mon_gestionados2.trabajado = 1 then 'SI' else 'NO' end as Trabajado,
		mon_calificaciones.capacitacion as [Resultado Final]

from mon_gestionados2 left join usuarios
on mon_gestionados2.usuario = usuarios.id_usr left join tecnicos
on mon_gestionados2.id_recurso = tecnicos.id_tecnico left join mon_covid19
on mon_gestionados2.covid19_contexto = mon_covid19.id_kit left join mon_credencial
on mon_gestionados2.id_credencial = mon_credencial.id_credencial left join mon_equipo_celular
on mon_gestionados2.id_equipo = mon_equipo_celular.id_equipo left join mon_vehiculo
on mon_gestionados2.id_vehiculo = mon_vehiculo.id_vehiculo left join mon_presencia
on mon_gestionados2.id_presencia = mon_presencia.id_presencia left join mon_calificaciones
on mon_gestionados2.calificacion = mon_calificaciones.id_capas

/*
select * from tecnicos_ingresantes
select * from mon_gestionados2 where id_recurso = 0 order by fyhgestion desc
*/
GO
