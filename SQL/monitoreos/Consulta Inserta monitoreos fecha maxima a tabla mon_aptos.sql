--INSERTA NUEVA FECHA
insert into mon_aptos (tipo, Fecha)
values ('Apto', cast (getdate() as date)), ('Regular', cast (getdate() as date)), ('No Apto', cast (getdate() as date))

create table #tempo (Contrata varchar (150), Tecnico varchar (255), Resultado varchar (10), fecha smalldatetime)

--INSERTO CONSULTA
insert into #tempo (Contrata, Tecnico, Resultado, fecha)

select a.Contratista,
		a.[Nombre del Tecnico],
		b.[Resultado Final],
		a.f

from (select Contratista,
		[Nombre del Tecnico],
		MAX ([Fecha de carga]) as f

from mon_lista_gestionados_tecnico
where [Nombre del Tecnico] <> 'INGRESANTE'
group by Contratista, [Nombre del Tecnico]) as a join mon_lista_gestionados_tecnico as b
on a.Contratista = b.Contratista and
	a.[Nombre del Tecnico] = b.[Nombre del Tecnico] and
	a.f = b.[Fecha de carga]

--SELECCION POR CONTRATA
/*
SELECT Contrata as Empresa,
		Resultado,
		count (*) as Cant

FROM #tempo
group by Contrata, Resultado
order by Contrata, Resultado
*/


--ARGENCOBRA
update mon_aptos
set ARGENCOBRA = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'ARGENCOBRA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set ARGENCOBRA = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'ARGENCOBRA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set ARGENCOBRA = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'ARGENCOBRA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set ARGENCOBRA = 0
where Fecha = cast (getdate() as date) and ARGENCOBRA is null

--COMFICA ARGENTINA
update mon_aptos
set [COMFICA ARGENTINA] = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'COMFICA ARGENTINA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set [COMFICA ARGENTINA] = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'COMFICA ARGENTINA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set [COMFICA ARGENTINA] = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'COMFICA ARGENTINA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set [COMFICA ARGENTINA] = 0
where Fecha = cast (getdate() as date) and [COMFICA ARGENTINA] is null

--NG
update mon_aptos
set NG = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'NG' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set NG = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'NG' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set NG = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'NG' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set NG = 0
where Fecha = cast (getdate() as date) and NG is null

--PLANTEL
update mon_aptos
set PLANTEL = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'PLANTEL' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set PLANTEL = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'PLANTEL' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set PLANTEL = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'PLANTEL' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set PLANTEL = 0
where Fecha = cast (getdate() as date) and PLANTEL is null

--RADIOTRONICA
update mon_aptos
set RADIOTRONICA = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'RADIOTRONICA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set RADIOTRONICA = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'RADIOTRONICA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set RADIOTRONICA = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'RADIOTRONICA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set RADIOTRONICA = 0
where Fecha = cast (getdate() as date) and RADIOTRONICA is null

--RETESAR
update mon_aptos
set RETESAR = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'RETESAR' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set RETESAR = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'RETESAR' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set RETESAR = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'RETESAR' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set RETESAR = 0
where Fecha = cast (getdate() as date) and RETESAR is null

--TASA
update mon_aptos
set TASA = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'TASA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set TASA = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'TASA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set TASA = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'TASA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set TASA = 0
where Fecha = cast (getdate() as date) and TASA is null

--TEAMTEL
update mon_aptos
set TEAMTEL = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'TEAMTEL' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set TEAMTEL = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'TEAMTEL' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set TEAMTEL = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'TEAMTEL' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set TEAMTEL = 0
where Fecha = cast (getdate() as date) and TEAMTEL is null

--TECN Y CABLEADOS SA
update mon_aptos
set [TECN Y CABLEADOS SA] = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'TECN Y CABLEADOS SA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set [TECN Y CABLEADOS SA] = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'TECN Y CABLEADOS SA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set [TECN Y CABLEADOS SA] = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'TECN Y CABLEADOS SA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set [TECN Y CABLEADOS SA] = 0
where Fecha = cast (getdate() as date) and [TECN Y CABLEADOS SA] is null

--VALTELLINA
update mon_aptos
set VALTELLINA = (select count (*) FROM #tempo where Resultado = 'Apto' and Contrata = 'VALTELLINA' group by Contrata, Resultado)
where Tipo = 'Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set VALTELLINA = (select count (*) FROM #tempo where Resultado = 'Regular' and Contrata = 'VALTELLINA' group by Contrata, Resultado)
where Tipo = 'Regular' and Fecha = cast (getdate() as date)
update mon_aptos
set VALTELLINA = (select count (*) FROM #tempo where Resultado = 'No Apto' and Contrata = 'VALTELLINA' group by Contrata, Resultado)
where Tipo = 'No Apto' and Fecha = cast (getdate() as date)
update mon_aptos
set VALTELLINA = 0
where Fecha = cast (getdate() as date) and VALTELLINA is null