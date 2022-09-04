insert into [10.244.89.164].TELEGESTION.dbo.mon_gestionados2 (fyhgestion,
				usuario,
				id_recurso,
				id_credencial,
				id_equipo,
				id_cita,
				id_vehiculo,
				id_epp,
				id_presencia,
				id_drop_plano,
				id_drop_circular,
				observaciones,
				mobbi,
				mobbi20,
				whop,
				pdr,
				escaner_qr,
				wifianalizer,
				smartwifi,
				kevlar,
				cleaver,
				pw,
				triple,
				[drop],
				alcohol,
				panios,
				laser,
				mobbi_instalada,
				mobbi20_instalada,
				whop_instalada,
				qr_instalada,
				wifianalizer_instalada,
				iptv,
				hgu,
				voip,
				alicate,
				pinzas,
				destornilla,
				agujereadora,
				micro,
				interna,
				fichas,
				filtros,
				calificacion,
				smart_instalada)

select a.[Fecha de calibración],
		b.id_usr,
		c.id_tecnico,
		case when a.Credencial='Si' then 1
				when a.Credencial='No' then 3
				when a.Credencial='Vencida' then 2 end,
		case when a.[Teléfono DualBand]='Si' then 1
				when a.[Teléfono DualBand]='No' then 3 end,
		case when a.[Motivo calibración]='Segunda visita a los mismos tecnicos' then 3
				when a.[Motivo calibración]='Solicitud ingreso técnico nuevo' then 2
				when a.[Motivo calibración]='Técnicos trabajando actualmente' then 1 end,
		case when a.Vehículo='En condiciones' then 1
				when a.Vehículo='Estado regular' then 2
				when a.Vehículo='Mal Estado' then 3
				when a.Vehículo='Sin escaleras' then 5
				when a.Vehículo='Sin identificación' then 4 end,
		case when a.EPP='Completa' then 17
				when a.EPP='Incompleta' then 18
				when a.EPP='No Tiene' then 19 end,
		case when a.Vestimenta='Completa' then 1
				when a.Vestimenta='Incompleta' then 2
				when a.Vestimenta='En mal estado' then 3
				when a.Vestimenta='Sin vestimenta corporativa' then 4 end,
		case when a.[Armado conector (Drop plano)]='Bueno' then 21
				when a.[Armado conector (Drop plano)]='Malo' then 23
				when a.[Armado conector (Drop plano)]='No realizo' then 25
				when a.[Armado conector (Drop plano)]='Regular' then 22 end,
		case when a.[Armado conector (Drop circular)]='Bueno' then 21
				when a.[Armado conector (Drop circular)]='Malo' then 23
				when a.[Armado conector (Drop circular)]='No realizo' then 25
				when a.[Armado conector (Drop circular)]='Regular' then 22 end,
		a.[Observaciones particulares],
		case when a.[Conocimiento uso de APP (Mobbi 1)]='Bueno' then 9
				when a.[Conocimiento uso de APP (Mobbi 1)]='Malo' then 11
				when a.[Conocimiento uso de APP (Mobbi 1)]='No usa' then 12
				when a.[Conocimiento uso de APP (Mobbi 1)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (Mobbi 2#0)]='Bueno' then 9
				when a.[Conocimiento uso de APP (Mobbi 2#0)]='Malo' then 11
				when a.[Conocimiento uso de APP (Mobbi 2#0)]='No usa' then 12
				when a.[Conocimiento uso de APP (Mobbi 2#0)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (Whop)]='Bueno' then 9
				when a.[Conocimiento uso de APP (Whop)]='Malo' then 11
				when a.[Conocimiento uso de APP (Whop)]='No usa' then 12
				when a.[Conocimiento uso de APP (Whop)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (PDR)]='Bueno' then 9
				when a.[Conocimiento uso de APP (PDR)]='Malo' then 11
				when a.[Conocimiento uso de APP (PDR)]='No usa' then 12
				when a.[Conocimiento uso de APP (PDR)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (Lector QR)]='Bueno' then 9
				when a.[Conocimiento uso de APP (Lector QR)]='Malo' then 11
				when a.[Conocimiento uso de APP (Lector QR)]='No usa' then 12
				when a.[Conocimiento uso de APP (Lector QR)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (WiFi Analizer)]='Bueno' then 9
				when a.[Conocimiento uso de APP (WiFi Analizer)]='Malo' then 11
				when a.[Conocimiento uso de APP (WiFi Analizer)]='No usa' then 12
				when a.[Conocimiento uso de APP (WiFi Analizer)]='Regular' then 10 end,
		case when a.[Conocimiento uso de APP (Smart WiFi)]='Bueno' then 9
				when a.[Conocimiento uso de APP (Smart WiFi)]='Malo' then 11
				when a.[Conocimiento uso de APP (Smart WiFi)]='No usa' then 12
				when a.[Conocimiento uso de APP (Smart WiFi)]='Regular' then 10 end,
		case when a.[Herramientas Kit de Fibra (Tijera para corte de kevlar)]='Si' then 1
				when a.[Conocimiento uso de APP (Mobbi 1)]='No' then 2
				when a.[Conocimiento uso de APP (Mobbi 1)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Cortadora de Fibras Cleaver)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Cortadora de Fibras Cleaver)]='No' then 2
				when a.[Herramientas Kit de Fibra (Cortadora de Fibras Cleaver)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (PowerMeter)]='Si' then 1
				when a.[Herramientas Kit de Fibra (PowerMeter)]='No' then 2
				when a.[Herramientas Kit de Fibra (PowerMeter)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Pinza Peladora de triple ranura)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Pinza Peladora de triple ranura)]='No' then 2
				when a.[Herramientas Kit de Fibra (Pinza Peladora de triple ranura)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Peladora Drop rectangular)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Peladora Drop rectangular)]='No' then 2
				when a.[Herramientas Kit de Fibra (Peladora Drop rectangular)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Alcohol Isopropilico)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Alcohol Isopropilico)]='No' then 2
				when a.[Herramientas Kit de Fibra (Alcohol Isopropilico)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Paños para alcohol)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Paños para alcohol)]='No' then 2
				when a.[Herramientas Kit de Fibra (Paños para alcohol)]='Mal estado' then 3 end,
		case when a.[Herramientas Kit de Fibra (Linterna laser)]='Si' then 1
				when a.[Herramientas Kit de Fibra (Linterna laser)]='No' then 2
				when a.[Herramientas Kit de Fibra (Linterna laser)]='Mal estado' then 3 end,
		case when a.[APP instaladas (Mobbi 1)]='Si' then 1
				when a.[APP instaladas (Mobbi 1)]='No' then 2 end,
		case when a.[APP instaladas (Mobbi 2#0)]='Si' then 1
				when a.[APP instaladas (Mobbi 2#0)]='No' then 2 end,
		case when a.[APP instaladas (Whop)]='Si' then 1
				when a.[APP instaladas (Whop)]='No' then 2 end,
		case when a.[APP instaladas (Lector QR)]='Si' then 1
				when a.[APP instaladas (Lector QR)]='No' then 2 end,
		case when a.[APP instaladas (WiFi Analizer)]='Si' then 1
				when a.[APP instaladas (WiFi Analizer)]='No' then 2 end,
		case when a.[Procesos (Conocimientos de IPTV)]='Bueno' then 13
				when a.[Conocimiento uso de APP (Lector QR)]='Malo' then 15
				when a.[Conocimiento uso de APP (Lector QR)]='Regular' then 14
				when a.[Conocimiento uso de APP (Lector QR)]='Desconoce' then 16 end,
		case when a.[Procesos (Conocimientos conf HGU)]='Bueno' then 13
				when a.[Procesos (Conocimientos conf HGU)]='Malo' then 15
				when a.[Procesos (Conocimientos conf HGU)]='Regular' then 14
				when a.[Procesos (Conocimientos conf HGU)]='Desconoce' then 16 end,
		case when a.[Procesos (Conocimientos sobre Voip)]='Bueno' then 13
				when a.[Procesos (Conocimientos sobre Voip)]='Malo' then 15
				when a.[Procesos (Conocimientos sobre Voip)]='Regular' then 14
				when a.[Procesos (Conocimientos sobre Voip)]='Desconoce' then 16 end,
		case when a.[Cobre (adaptación Voip) (Alicate)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Alicate)]='No' then 2
				when a.[Cobre (adaptación Voip) (Alicate)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Pinzas )]='Si' then 1
				when a.[Cobre (adaptación Voip) (Pinzas )]='No' then 2
				when a.[Cobre (adaptación Voip) (Pinzas )]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Destornilladres)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Destornilladres)]='No' then 2
				when a.[Cobre (adaptación Voip) (Destornilladres)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Agujereadora/Mechas)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Agujereadora/Mechas)]='No' then 2
				when a.[Cobre (adaptación Voip) (Agujereadora/Mechas)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Micro Telefono)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Micro Telefono)]='No' then 2
				when a.[Cobre (adaptación Voip) (Micro Telefono)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Cable de inst interna)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Cable de inst interna)]='No' then 2
				when a.[Cobre (adaptación Voip) (Cable de inst interna)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Ficha americana)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Ficha americana)]='No' then 2
				when a.[Cobre (adaptación Voip) (Ficha americana)]='Mal estado' then 3 end,
		case when a.[Cobre (adaptación Voip) (Filtros combinados)]='Si' then 1
				when a.[Cobre (adaptación Voip) (Filtros combinados)]='No' then 2
				when a.[Cobre (adaptación Voip) (Filtros combinados)]='Mal estado' then 3 end,
		case when a.[Resultado Final]='Apto' then 1
				when a.[Resultado Final]='No apto' then 3
				when a.[Resultado Final]='Regular' then 2 end,		
		case when a.[APP instaladas (Smart WiFi)]='Si' then 1
				when a.[APP instaladas (Smart WiFi)]='No' then 2 end
		

from respuestas as a left join [10.244.89.164].TELEGESTION.dbo.usuarios as b
on a.[apellido realiz] = b.apellido join [10.244.89.164].TELEGESTION.dbo.tecnicos as c
on a.Técnico = c.nombre
where a.[apellido realiz] is not null