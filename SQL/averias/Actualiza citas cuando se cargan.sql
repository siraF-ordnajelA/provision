merge into av_averias_contrata_porc as destino
using (select [Empresa que instal�],
				count (*) as Cant
		from av_citas
		group by [Empresa que instal�]) as origen
		
on origen.[Empresa que instal�] = destino.[Empresa]

when matched then update
set destino.Citas = origen.Cant;

select * from av_averias_contrata_porc