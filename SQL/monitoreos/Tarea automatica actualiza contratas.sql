truncate table contratas

insert into contratas (descripcion_contrata)

select ctta from bou.dbo.tecnicos
group by ctta
order by ctta

--select * from contratas