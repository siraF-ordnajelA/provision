select * from garantias_cbo_motivo
order by motivo
select * from garantias_cbo_submotivo
order by submotivo


select * from garantias_cbo_submotivo
where id_motivo = 9
order by submotivo

insert into garantias_cbo_submotivo (id_motivo, submotivo)
values (6,'DATOS ND'),
(2,'ADECUACION - VOIP')

update garantias_cbo_submotivo
set submotivo = 'PROVISIÓN - VOIP'
where id_submotivo = 24

delete from garantias_cbo_submotivo
where id_submotivo in (39,46,47)