alter procedure lista_usuarios
@opc tinyint,
@id_usuario tinyint

as

IF (@opc = 0)
BEGIN
select id_usr, apellido from usuarios
where centro = 'TASA'
order by apellido
END

IF (@opc = 1)
BEGIN
select id_usr, apellido from usuarios
where id_usr = @id_usuario
END