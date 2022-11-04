insert into averias_motivo (appt_number,
				Fecha,
				aworktype,
				estado,
				complete_reason,
				not_done_reason,
				dni,
				nombre,
				empresa,
				comentario,
				central)

select appt_number,
		[date],
		aworktype,
		[status],
		A_COMPLETE_REASON,
		A_NOT_DONE_REASON,
		resource_id,
		tx_nombre,
		XR_COMPANY_NAME,
		A_END_ACTIVITY_COMMENT,
		XA_CENTRAL
		
from ceawebvm.ods.dbo.cierres_correctivo_contrata_90_dias
--where [status] = 'complete'