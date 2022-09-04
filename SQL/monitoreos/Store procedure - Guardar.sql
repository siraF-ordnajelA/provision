alter procedure carga_monitoreo
@opcion tinyint,
@id_pendiente int,
@usuario smallint,
@tecnico smallint,
@fecha_manual varchar(10),
@ape_tecnico varchar(80),
@nom_tecnico varchar(80),
@dni_tec varchar (9),
@ctta_tec varchar (150),
@campo tinyint,
@credencial tinyint,
@equipo tinyint,
@valcita tinyint,
@vehiculo_estado tinyint,
@vehiculo_identif tinyint,
@vehiculo_escalera tinyint,
@vehiculo_porta tinyint,
@vehiculo_patente varchar(8),
@contex_insta tinyint,
@kit_sano tinyint,
@epp tinyint,
@vestimenta tinyint,
@metodo tinyint,
@drop_plano tinyint,
@drop_circu tinyint,
@obs varchar(500),
@mobbi tinyint,
@mobbi20 tinyint,
@whop tinyint,
@pdr tinyint,
@qr tinyint,
@analizer tinyint,
@smart tinyint,
@kevlar tinyint,
@cleaver tinyint,
@pw tinyint,
@triple tinyint,
@drop tinyint,
@alcohol tinyint,
@panios tinyint,
@laser tinyint,
@mobbi_insta tinyint,
@mobbi20_insta tinyint,
@whop_insta tinyint,
@qr_insta tinyint,
@pdr_insta tinyint,
@analizer_insta tinyint,
@smart_insta tinyint,
@iptv tinyint,
@hgu tinyint,
@voip tinyint,
@alicate tinyint,
@pinzas tinyint,
@destornilla tinyint,
@agu tinyint,
@micro tinyint,
@interna tinyint,
@ficha tinyint,
@filtro tinyint,
@martillo tinyint,
@pela_cable tinyint,
@alargue tinyint,
@calificacione tinyint

as

declare @id_tec_ing int

IF (@tecnico = 0)
BEGIN
insert into tecnicos_ingresantes (Apellido, Nombre, Ctta, Dni)
values (@ape_tecnico, @nom_tecnico, @ctta_tec, @dni_tec)

set @id_tec_ing = (select top 1 id_ingresante from tecnicos_ingresantes where Apellido = @ape_tecnico and Nombre = @nom_tecnico order by id_ingresante desc)

insert into mon_gestionados2 (fyhgestion,
	usuario,
	id_recurso,
	fyhmonitoreo,
	id_credencial,
	id_campo,
	id_equipo,
	id_cita,
	id_vehiculo,
	vehiculo_identificacion,
	vehiculo_escalera,
	vehiculo_porta_escalera,
	vehiculo_patente,
	covid19_contexto,
	covid19_kit,
	id_epp,
	id_presencia,
	metodo_constr,
	id_drop_plano,
	id_drop_circular,
	observaciones,
	--Conociomiento uso APP
	mobbi,
	mobbi20,
	whop,
	Pdr,
	escaner_qr,
	wifianalizer,
	Smartwifi,
	--Herramientas Kit Fibra
	kevlar,
	cleaver,
	pw,
	triple,
	[drop],
	alcohol,
	panios,
	laser,
	--APP instaladas
	mobbi_instalada,
	mobbi20_instalada,
	whop_instalada,
	qr_instalada,
	pdr_instalada,
	wifianalizer_instalada,
	smart_instalada,
	--Procesos
	iptv,
	hgu,
	voip,
	--Cobre adaptación
	alicate,
	pinzas,
	destornilla,
	agujereadora,
	micro,
	interna,
	fichas,
	filtros,
	martillo,
	pela_cable,
	alargue,
	--Calificación Final
	calificacion,
	--Bandera tecnico Ingresante
	flag_ingresante,
	trabajado)
      
values (cast (getdate() as smalldatetime),
		@usuario,
		@id_tec_ing,
		@fecha_manual,
		@credencial,
		@campo,
		@equipo,
		@valcita,
		@vehiculo_estado,
		@vehiculo_identif,
		@vehiculo_escalera,
		@vehiculo_porta,
		@vehiculo_patente,
		@contex_insta,
		@kit_sano,
		@epp,
		@vestimenta,
		@metodo,
		@drop_plano,
		@drop_circu,
		@obs,
		@mobbi,
		@mobbi20,
		@whop,
		@pdr,
		@qr,
		@analizer,
		@smart,
		@kevlar,
		@cleaver,
		@pw,
		@triple,
		@drop,
		@alcohol,
		@panios,
		@laser,
		@mobbi_insta,
		@mobbi20_insta,
		@whop_insta,
		@qr_insta,
		@pdr_insta,
		@analizer_insta,
		@smart_insta,
		@iptv,
		@hgu,
		@voip,
		@alicate,
		@pinzas,
		@destornilla,
		@agu,
		@micro,
		@interna,
		@ficha,
		@filtro,
		@martillo,
		@pela_cable,
		@alargue,
		@calificacione,
		1,
		0)
END

ELSE
BEGIN
insert into mon_gestionados2 (fyhgestion,
	usuario,
	id_recurso,
	fyhmonitoreo,
	--apellido_tec,
	--nombre_tec,
	id_credencial,
	id_campo,
	id_equipo,
	id_cita,
	id_vehiculo,
	vehiculo_identificacion,
	vehiculo_escalera,
	vehiculo_porta_escalera,
	vehiculo_patente,
	covid19_contexto,
	covid19_kit,
	id_epp,
	id_presencia,
	metodo_constr,
	id_drop_plano,
	id_drop_circular,
	observaciones,
	--Conociomiento uso APP
	mobbi,
	mobbi20,
	whop,
	Pdr,
	escaner_qr,
	wifianalizer,
	Smartwifi,
	--Herramientas Kit Fibra
	kevlar,
	cleaver,
	pw,
	triple,
	[drop],
	alcohol,
	panios,
	laser,
	--APP instaladas
	mobbi_instalada,
	mobbi20_instalada,
	whop_instalada,
	qr_instalada,
	pdr_instalada,
	wifianalizer_instalada,
	smart_instalada,
	--Procesos
	iptv,
	hgu,
	voip,
	--Cobre adaptación
	alicate,
	pinzas,
	destornilla,
	agujereadora,
	micro,
	interna,
	fichas,
	filtros,
	martillo,
	pela_cable,
	alargue,
	--Calificación Final
	calificacion,
	--Bandera tecnico Ingresante
	flag_ingresante,
	trabajado)
      
values (cast (getdate() as smalldatetime),
		@usuario,
		@tecnico,
		@fecha_manual,
		--@ape_tecnico,
		--@nom_tecnico,
		@credencial,
		@campo,
		@equipo,
		@valcita,
		@vehiculo_estado,
		@vehiculo_identif,
		@vehiculo_escalera,
		@vehiculo_porta,
		@vehiculo_patente,
		@contex_insta,
		@kit_sano,
		@epp,
		@vestimenta,
		@metodo,
		@drop_plano,
		@drop_circu,
		@obs,
		@mobbi,
		@mobbi20,
		@whop,
		@pdr,
		@qr,
		@analizer,
		@smart,
		@kevlar,
		@cleaver,
		@pw,
		@triple,
		@drop,
		@alcohol,
		@panios,
		@laser,
		@mobbi_insta,
		@mobbi20_insta,
		@whop_insta,
		@qr_insta,
		@pdr_insta,
		@analizer_insta,
		@smart_insta,
		@iptv,
		@hgu,
		@voip,
		@alicate,
		@pinzas,
		@destornilla,
		@agu,
		@micro,
		@interna,
		@ficha,
		@filtro,
		@martillo,
		@pela_cable,
		@alargue,
		@calificacione,
		0,
		0)
END

IF (@opcion = 2)
BEGIN
declare @id_monitoreo int
set @id_monitoreo = (select top 1 id_gestion from mon_gestionados2 order by fyhgestion desc) 

update mon_medallia_lista
set monitoreado = 1,
	id_monitoreo = @id_monitoreo
where id_pendiente = @id_pendiente

update mon_gestionados2
set id_medallia = @id_pendiente
where id_gestion = @id_monitoreo
END

IF (@opcion = 3)
BEGIN
update mon_gestionados2
set trabajado = 1
where id_gestion = @id_pendiente
END