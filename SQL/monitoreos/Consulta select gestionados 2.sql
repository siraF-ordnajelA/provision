CREATE PROCEDURE lista_gestionados2

as

select mon_gestionados_contrata.red_monitor as MONITOR,
		mon_gestionados_contrata.fyhgestion as [FECHA GESTION],
		contratas.descripcion_contrata as CONTRATISTA,
		mon_gestionados_contrata.sub_contrata as [SUB CONTRATISTA],
		mon_gestionados_contrata.domicilio as DOMICILIO,
		mon_gestionados_contrata.cant_sup as SUPERVISORES,
		mon_gestionados_contrata.cant_tec as TECNICOS,
		mon_gestionados_contrata.nom_supervisor as [NOMBRE DEL SUPERVISOR],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_1) as [BANDA ANCHA - PREGUNTA 1],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_2) as [BANDA ANCHA - PREGUNTA 2],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_3) as [BANDA ANCHA - PREGUNTA 3],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_4) as [BANDA ANCHA - PREGUNTA 4],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_5) as [BANDA ANCHA - PREGUNTA 5],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_6) as [BANDA ANCHA - PREGUNTA 6],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_7) as [BANDA ANCHA - PREGUNTA 7],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_8) as [BANDA ANCHA - PREGUNTA 8],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_9) as [BANDA ANCHA - PREGUNTA 9],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_10) as [BANDA ANCHA - PREGUNTA 10],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_11) as [BANDA ANCHA - PREGUNTA 11],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_12) as [BANDA ANCHA - PREGUNTA 12],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = BA_13) as [BANDA ANCHA - PREGUNTA 13],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = VOIP_1) as [VOIP - PREGUNTA 1],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = VOIP_2) as [VOIP - PREGUNTA 2],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = MP_1) as [MOVISTAR PLAY - PREGUNTA 1],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = MP_2) as [MOVISTAR PLAY - PREGUNTA 2],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = MP_3) as [MOVISTAR PLAY - PREGUNTA 3],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = MP_4) as [MOVISTAR PLAY - PREGUNTA 4],
		(select descripcion_resp from mon_respuestas_contrata where id_resp = MP_5) as [MOVISTAR PLAY - PREGUNTA 5],
		mon_gestionados_contrata.observaciones as OBSERVACIONES

from mon_gestionados_contrata left join contratas
on mon_gestionados_contrata.id_contrata = contratas.id_contrata
order by mon_gestionados_contrata.fyhgestion desc