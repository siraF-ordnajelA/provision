alter procedure metricas_manual_guarda
@valor decimal(3,2),
@empresa tinyint,
@fecha varchar(10)

as

IF ((select count(*) from metricas_manuales where id_contrata=@empresa and Fecha=@fecha) > 0)
BEGIN
update metricas_manuales
set valor = @valor
where id_contrata=@empresa and Fecha=@fecha
END

ELSE
BEGIN
insert into metricas_manuales(id_contrata, nombre_metrica, Fecha, valor)
values (@empresa, 'manual_1', @fecha, @valor)
END

select 'Se ha guardado el valor correctamente.' as text