declare @peticion varchar(40)
set @peticion = 'CRM38641526_202261517277'

select * from toa_pm where [Número de Petición] = @peticion
select * from toa_ultima where [Número de Petición] = @peticion
select * from toa_primera where [Número de Petición] = @peticion
select * from bcp_toa_no_programado where [Número de Petición] = @peticion
select * from toa_no_programado where [Número de Petición] = @peticion

/*
select * from toa_pm
where [Access ID] = 1052050677
order by timestamp desc
*/