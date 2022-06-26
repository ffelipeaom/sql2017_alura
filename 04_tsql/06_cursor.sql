--Crie um script usando um cursor para achar o valor total de todos os cr�ditos de todos os clientes.

DECLARE @LIMITECREDITO AS FLOAT
DECLARE @LIMITECREDITOACUMULADO AS FLOAT
DECLARE CURSOR1 CURSOR FOR SELECT [LIMITE DE CREDITO] FROM [TABELA DE CLIENTES]
SET @LIMITECREDITOACUMULADO = 0

OPEN CURSOR1
FETCH NEXT FROM CURSOR1 INTO @LIMITECREDITO
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @LIMITECREDITOACUMULADO = @LIMITECREDITOACUMULADO + @LIMITECREDITO
	FETCH NEXT FROM CURSOR1 INTO @LIMITECREDITO
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
PRINT @LIMITECREDITO

--Crie um script usando um cursor para achar o valor total do faturamento para um m�s e um ano.

DECLARE @QUANTIDADE INT
DECLARE @PRE�O FLOAT
DECLARE @FATURAMENTOACUMULADO FLOAT
DECLARE @MES INT
DECLARE @ANO INT
SET @MES = 1
SET @ANO = 2017

DECLARE CURSOR3 CURSOR FOR SELECT INF.QUANTIDADE, INF.PRE�O FROM
	[ITENS NOTAS FISCAIS] INF INNER JOIN
	[NOTAS FISCAIS] NF ON NF.NUMERO = INF.NUMERO
	WHERE MONTH(NF.DATA) = @MES AND YEAR(NF.DATA) = @ANO
SET @FATURAMENTOACUMULADO = 0
OPEN CURSOR3
FETCH NEXT FROM CURSOR3 INTO @QUANTIDADE, @PRE�O
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @FATURAMENTOACUMULADO = @FATURAMENTOACUMULADO + (@QUANTIDADE * @PRE�O)
	FETCH NEXT FROM CURSOR3 INTO @QUANTIDADE, @PRE�O
END
CLOSE CURSOR3
DEALLOCATE CURSOR3
PRINT @FATURAMENTOACUMULADO

--Crie uma vari�vel TABELA com um campo INT,
--use um loop para gravar 100 n�meros aleat�rios entre 0 e 1000 nesta tabela.
--Depois, liste esta tabela em uma consulta.

CREATE VIEW VW_RND AS SELECT RAND() AS VALUE
SELECT * FROM VW_RND

CREATE FUNCTION NumAleatorio(@VALOR_MIN INT, @VALOR_MAX INT) RETURNS INT
AS
BEGIN
DECLARE @RND_INT INT
DECLARE @RND_FLOAT FLOAT
SELECT @RND_FLOAT = VALUE FROM VW_RND
SET @RND_INT = ROUND(((@VALOR_MAX - @VALOR_MIN - 1) * @RND_FLOAT + @VALOR_MIN), 0)
RETURN @RND_INT
END

DECLARE @TABELA TABLE (NUMERO INT)
DECLARE @CONTADOR INT
DECLARE @CONTADORMAX INT
SET @CONTADOR = 0
SET @CONTADORMAX = 100

WHILE @CONTADOR <= @CONTADORMAX
BEGIN
	INSERT INTO @TABELA (NUMERO)
		VALUES ([dbo].[NumAleatorio](0,1000))
	SET @CONTADOR = @CONTADOR + 1
END

SELECT * FROM @TABELA

--Crie o script para obter um produto (aleat�rio) tamb�m usando a fun��o de n�mero aleat�rio.

SELECT * FROM [TABELA DE PRODUTOS]

DECLARE @PRODUTO_RND VARCHAR(12)
DECLARE @CONTADOR INT
SET @CONTADOR = 1

DECLARE @NUM_RND INT
DECLARE @VALOR_INICIAL INT
DECLARE @VALOR_FINAL INT
SET @VALOR_INICIAL = 1
SELECT @VALOR_FINAL = COUNT(*) FROM [TABELA DE PRODUTOS]
SET @NUM_RND = [dbo].[NumAleatorio](@VALOR_INICIAL, @VALOR_FINAL)

DECLARE CURSOR1 CURSOR FOR SELECT [CODIGO DO PRODUTO] FROM [TABELA DE PRODUTOS]
OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 INTO @PRODUTO_RND
WHILE @CONTADOR <= @NUM_RND
BEGIN
	FETCH NEXT FROM CURSOR1 INTO @PRODUTO_RND
	SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
SELECT @PRODUTO_RND


--Crie uma consulta no Management Studio;
--declare tr�s vari�veis que recebem o produto, cliente e vendedor;
--obtenha os valores destas vari�veis atrav�s da fun��o EntidadeAleatoria.

CREATE FUNCTION EntidadeAleatoria (@TIPO VARCHAR(12)) RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @ENTIDADE_RND VARCHAR(20)
DECLARE @TABELA TABLE (CODIGO VARCHAR(20))
DECLARE @NUM_RND INT
DECLARE @VALOR_INICIAL INT
DECLARE @VALOR_FINAL INT 
DECLARE @CONTADOR INT

IF @TIPO = 'CLIENTE'
BEGIN
	INSERT INTO @TABELA (CODIGO) SELECT CPF AS CODIGO FROM [TABELA DE CLIENTES]
END
ELSE IF @TIPO = 'VENDEDORES'
BEGIN
	INSERT INTO @TABELA (CODIGO) SELECT MATRICULA AS CODIGO FROM [TABELA DE VENDEDORES]
END
ELSE IF @TIPO = 'PRODUTOS'
BEGIN
	INSERT INTO @TABELA (CODIGO) SELECT [CODIGO DO PRODUTO] AS CODIGO FROM [TABELA DE PRODUTOS]
END

SET @CONTADOR = 1
SET @VALOR_INICIAL = 1
SELECT @VALOR_FINAL = COUNT(*) FROM @TABELA
SET @NUM_RND = [dbo].[NumAleatorio](@VALOR_INICIAL, @VALOR_FINAL)

DECLARE CURSOR1 CURSOR FOR SELECT CODIGO FROM @TABELA
OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 INTO @ENTIDADE_RND
WHILE @CONTADOR <= @NUM_RND
BEGIN
	FETCH NEXT FROM CURSOR1 INTO @ENTIDADE_RND
	SET @CONTADOR = @CONTADOR + 1
END
CLOSE CURSOR1
DEALLOCATE CURSOR1
RETURN @ENTIDADE_RND
END

SELECT
	[dbo].[EntidadeAleatoria]('CLIENTE'),
	[dbo].[EntidadeAleatoria]('PRODUTO'),
	[dbo].[EntidadeAleatoria]('VENDEDOR')