create table Q4s_semanal (Semana tinyint null,
							id_contrata tinyint null,
							Tecnico varchar(150) null,
							id_tecnico smallint null,
							Instalaciones smallint null,
							Garantias_30d smallint null,
							Garantias_7d smallint null,
							Monitoreos tinyint null,
							[No Realizado] smallint null,
							Suspendido smallint null,
							dias_trabajo tinyint null,
							prom_diarias decimal(5,2) null,
							[Monitoreos Apto] tinyint null,
							tecnologia varchar(12) null)