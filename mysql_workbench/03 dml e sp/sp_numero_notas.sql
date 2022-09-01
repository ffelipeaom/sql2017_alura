CREATE FUNCTION `numero_notas` (DATA DATE)
RETURNS INTEGER
BEGIN
DECLARE NUMNOTAS INT;
SELECT COUNT(*) INTO NUMNOTAS FROM notas_fiscais WHERE DATA_VENDA = DATA;
RETURN NUMNOTAS;
END