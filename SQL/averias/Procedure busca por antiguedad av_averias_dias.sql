alter procedure av_averias_dias
@dias int,
@empresa varchar (150),
@tecno tinyint

as
declare @tecnologo varchar(5)

if (@tecno = 1)
begin
set @tecnologo = 'fibra'
end

if (@tecno = 2)
begin
set @tecnologo = 'cobre'
end

if (@dias < 5)
begin
select *,
		datediff (day, [Fecha creación TOA], cast(getdate() as date)) as Dias

from av_averias
where datediff (day, [Fecha creación TOA], cast(getdate() as date)) = @dias and
		[Empresa que instaló] = @empresa and
		[Tipo de Acceso] = @tecnologo
end

else
select *,
		datediff (day, [Fecha creación TOA], cast(getdate() as date)) as Dias

from av_averias
where datediff (day, [Fecha creación TOA], cast(getdate() as date)) > 4 and
		[Empresa que instaló] = @empresa and
		[Tipo de Acceso] = @tecnologo