--RESTA 2 SEMANAS DESDE DOMINGO
SELECT DATEADD(wk,DATEDIFF(wk,7,'20220220'),-8)

--SELECCIONA SEMANA DEL MES (DOMINGO 1ER DIA DE LA SEMANA)
declare @date datetime = '20220123'
select (DATEPART(day,@date)-1)/7 + 1

-- RESTA 2 SEMANAS Y PRUEBA SI ES LA PRIMER SEMANA DEL MES
declare @date date = (SELECT DATEADD(wk,DATEDIFF(wk,7,'20220123'),-8))

IF((select (DATEPART(day,@date)-1)/7 + 1) > 1)
BEGIN
select @date as Fecha, 'No es la primer semana del mes' as Leyenda
END
ELSE
BEGIN
select @date as Fecha, 'Es la primer semana del mes' as Leyenda
END