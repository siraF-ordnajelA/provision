create table mon_gestionados2 (
	id_gestion int not null primary key identity (1,1),
	fyhgestion smalldatetime not null,
	usuario smallint not null,
	id_recurso int not null,
	id_credencial tinyint null,
	id_equipo tinyint null,
	id_cita tinyint null,
	id_vehiculo tinyint null,
	id_epp tinyint null,
	id_presencia tinyint null,
	id_drop_plano tinyint null,
	id_drop_circular tinyint null,
	observaciones varchar (500) null,
	--Conociomiento uso APP
	mobbi tinyint null,
	mobbi20 tinyint null,
	whop tinyint null,
	Pdr tinyint null,
	escaner_qr tinyint null,
	speedtest tinyint null,
	wifianalizer tinyint null,
	Smartwifi tinyint null,
	--Herramientas Kit Fibra
	kevlar tinyint null,
	cleaver tinyint null,
	pw tinyint null,
	triple tinyint null,
	[drop] tinyint null,
	alcohol tinyint null,
	panios tinyint null,
	laser tinyint null,
	--APP instaladas
	mobbi_instalada tinyint null,
	mobbi20_instalada tinyint null,
	whop_instalada tinyint null,
	qr_instalada tinyint null,
	wifianalizer_instalada tinyint null,
	--Procesos
	iptv tinyint null,
	hgu tinyint null,
	voip tinyint null,
	--Cobre adaptación
	alicate tinyint null,
	pinzas tinyint null,
	destornilla tinyint null,
	agujereadora tinyint null,
	micro tinyint null,
	interna tinyint null,
	fichas tinyint null,
	filtros tinyint null,
	--Calificación Final
	calificacion tinyint not null)