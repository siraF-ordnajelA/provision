alter view vw_metricas_ctta

as

select a.Fecha,
		a.id_ctta,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.tecnologia,
		a.metrica_presentismo,
		a.metrica_garantias_7d,
		a.manual_1,
		a.central,
		b.region_mop,
		b.distrito

from metricas_ctta as a left join region_mop as b
on a.central = b.central
where a.central <> 0

/*
select a.Fecha,
		a.id_ctta,
		a.metrica_cumplidas,
		a.metrica_garantias,
		a.metrica_monitoreos,
		a.metrica_diarias,
		a.metrica_citas,
		a.tecnologia,
		a.metrica_presentismo,
		a.metrica_garantias_7d,
		a.manual_1,
		a.central,
		b.GERENCIA_PROV,
		b.DISTRITO_PROV,
		b.CENT_DESCRIP_COTA

from metricas_ctta as a left join centrales2 as b
on a.central = b.CENT_ID
*/