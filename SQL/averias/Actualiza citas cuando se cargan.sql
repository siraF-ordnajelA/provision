merge into av_averias_contrata_porc as destino
using (select [Empresa que instaló],
				count (*) as Cant
		from av_citas
		group by [Empresa que instaló]) as origen
		
on origen.[Empresa que instaló] = destino.[Empresa]

when matched then update
set destino.Citas = origen.Cant;

select * from av_averias_contrata_porc