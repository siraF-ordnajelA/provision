alter procedure news_lista
@opata tinyint
as

if (@opata = 1)
select * from novedades
where fecha >= cast (getdate()-30 as date)

if (@opata = 2)
select * from novedades
order by Fecha desc