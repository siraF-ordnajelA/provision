create table metricas_tecnico_semanal_his
(
	Semana tinyint null,
	id_ctta tinyint null,
	id_recurso int null,
	metrica_cumplidas decimal(8,6) null,
	metrica_garantias decimal(8,6) null,
	metrica_garantias_7d decimal(8,6) null,
	metrica_monitoreos decimal(8,6) null,
	metrica_diarias decimal(8,6) null,
	metrica_citas decimal(8,6) null,
	metrica_presentismo decimal(8,6) null,
	tecnologia tinyint null,
	fecha date null
)