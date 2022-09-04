ALTER PROCEDURE lista_gestionados

as

select * from mon_lista_gestionados_tecnico
where [Fecha de carga] > '20191231'
order by [Fecha de carga] desc