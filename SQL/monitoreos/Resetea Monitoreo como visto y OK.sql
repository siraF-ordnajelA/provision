--BANDEJA PENDIENTES GESTOR
select * from tecnicos
where nombre = 'PEREZ BORDON MAXIMILIANO'

select * from mon_gestionados2
where id_recurso = 9946

--ELIINA REPETIDO
delete from mon_gestionados2 where id_gestion in (2919,2922,2923,2924,2925,2954,2970)

update mon_gestionados2
set trabajado = 1, visto_ctta = 1
where id_gestion in (2502,2708)

--BANDEJA PENDIENTES MONITOREO
select * from mon_medallia_lista
where id_recurso = 11097

update mon_medallia_lista
set monitoreado = 1
where id_recurso = 9568

--ELIMINA PENDIENTE CONTRATA DE MEDALLIA
select * from medallia_encuestas
where id_encuesta = 77466645

delete from medallia_encuestas
where id_encuesta = 77466645