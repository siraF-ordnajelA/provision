alter procedure inserta_alarmas_olt
as

truncate table CCP.dbo.alarmas_olt

insert into CCP.dbo.alarmas_olt ([Access ID sin señal],
									[Fecha desconexión],
									[Causa desconexión],
									OLT,
									[Access ID trabajado],
									[Fecha inicio actividad],
									[Minutos de diferencia],
									Actuación,
									Técnico,
									Empresa,
									[Motivo cierre],
									Bucket,
									Gerencia,
									Jefatura,
									Celula,
									Central,
									Actualizado)

SELECT a.numero_de_abonado as [Access ID sin señal],
		a.fecha_alarma_oos as [Fecha desconexión],
		a.causa_ultima_desconexion as [Causa desconexión],
		a.nombre_segmento_1 as OLT,
		a.numero_de_abonado_2 as [Access ID trabajado],
		a.fecha_alarma_is as [Fecha inicio actividad],
		a.minutos_dif as [Minutos de diferencia],
		a.cod_actuacion as Actuación,
		a.recurso_nombre as Técnico,
		b.ctta as Empresa,
		a.tx_motivo as [Motivo cierre],
		a.bucket as Bucket,
		a.tx_gerencia as Gerencia,
		a.tx_jefatura as Jefatura,
		a.tx_celula as Celula,
		a.tx_central as Central,
		CAST (getdate() as smalldatetime)

FROM T1000.GPON_EXPRESSE.dbo.REPORTE_ALARMA_IS_OOS as a left join [10.244.89.164].BOU.dbo.tecnicos as b
on a.recurso_nombre = b.nombre