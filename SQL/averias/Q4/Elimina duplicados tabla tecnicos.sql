DELETE T FROM
(SELECT Row_Number() Over(Partition By dni, ctta ORDER BY nombre, id_tecnico desc) AS RowNumber,* FROM tecnicos) T
WHERE T.RowNumber > 1