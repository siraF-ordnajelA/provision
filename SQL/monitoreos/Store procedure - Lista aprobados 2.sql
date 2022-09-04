alter procedure mon_lista_aprobados
as

select Tipo,
		ARGENCOBRA,
		[COMFICA ARGENTINA],
		NG,
		PLANTEL,
		RADIOTRONICA,
		RETESAR,
		TASA,
		TEAMTEL,
		[TECN Y CABLEADOS SA],
		VALTELLINA,
		Fecha

from mon_aptos
where fecha = (select max (Fecha) from mon_aptos)