use CCP

select a.DIA,
		a.TIPO_CITA,
		a.APPT_NUMBER,
		a.[status],
		a.date_original,
		a.[date],
		a.XA_WORK_TYPE,
		a.XA_TECHNICAL_VALIDATION,
		a.XA_ACCESS_TECHNOLOGY,
		a.status_final,
		a.MOTIVO_TOA,
		a.RESOURCE_ID,
		a.CITADO,
		a.NO_CUMPLIDO,
		a.CUMPLIDO,
		b.nombre,
		b.ctta

from CEAWEBVM.ODS.dbo.citas_del_dia as a left join [10.249.15.194\DATAFLOW].TELEGESTION.dbo.tecnicos as b
on a.RESOURCE_ID = b.dni
where a.DIA between '20210901' and '20210930' and
		a.XA_ACCESS_TECHNOLOGY = 'FIBRA'