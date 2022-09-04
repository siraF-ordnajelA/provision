alter procedure av_historico_barras
@empresa varchar (50),
@anio varchar(4)

as

if (@empresa = '' or @empresa is null or @empresa = 'TASA')
begin
select * from av_garantias_historico
where Empresa <> 'PANAVISION' and Empresa <> 'GLOBAL' and Anio = datepart (year, getdate())
order by Empresa
end

if (@empresa = 'GLOBO' and @anio = 1)
begin
select * from av_garantias_historico
where Empresa = 'GLOBAL'  and Anio = datepart (year, getdate())
end

if (@empresa = 'GLOBO' and @anio > 1)
begin
select * from av_garantias_historico
where Empresa = 'GLOBAL'  and Anio = @anio
end

if (@empresa <> 'GLOBO' and @empresa <> 'TASA' and @empresa <> '' and @empresa is not null)
begin
select * from av_garantias_historico
where Empresa = @empresa and Empresa <> 'GLOBAL' and Anio = datepart (year, getdate())
order by Empresa
end