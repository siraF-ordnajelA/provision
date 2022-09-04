alter procedure mon_devuelve_a_medallia
@id_medallia int,
@id_gestion int

as

update mon_medallia_lista
set monitoreado = 0
where id_medallia = @id_medallia

update mon_gestionados2
set trabajado = 1
where id_gestion = @id_gestion