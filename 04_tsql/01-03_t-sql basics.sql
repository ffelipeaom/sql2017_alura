--Crie 4 variáveis com as características abaixo:
--Nome: Cliente. Tipo: Caracteres com 10 posições. Valor: João
--Nome: Idade. Tipo: Inteiro. Valor: 10
--Nome: DataNascimento. Tipo: Data. Valor: 10/01/2007
--Nome: Custo. Tipo: Número com casas decimais. Valor: 10,23

DECLARE @CLIENTE VARCHAR(10), @IDADE INT, @NASCIMENTO DATE, @CUSTO FLOAT

SET @CLIENTE = 'João'
SET @IDADE = '10'
SET @NASCIMENTO = '20070110'
SET @CUSTO = '10.23'

PRINT @CLIENTE
PRINT @IDADE
PRINT @NASCIMENTO
PRINT @CUSTO

--Crie uma variável chamada NUMNOTAS e atribua a ela o número de notas fiscais do dia 01/01/2017.
--Mostre na saída do script o valor da variável.

DECLARE @NUMNOTAS INT

SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
	WHERE DATA = '20170101'
PRINT @NUMNOTAS

--Crie um script que, baseado em uma data, conte o número de notas fiscais.
--Se houver mais de 70 notas, exiba a mensagem "Muita nota".
--Se não, exiba a mensagem "Pouca nota". Exiba também o número de notas.

DECLARE @NUMNOTAS INT
DECLARE @DATANOTA DATE
SET @DATANOTA = '20170102'
SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
	WHERE DATA = @DATANOTA
IF @NUMNOTAS > 70
	PRINT 'Muita notas'
ELSE
	PRINT 'Poucas notas'
PRINT @NUMNOTAS

--Em vez de testar com a variável @NUMNOTAS, use a própria consulta SQL na condição de teste.

DECLARE @DATANOTA DATE
SET @DATANOTA = '20170102'
IF (SELECT COUNT(*) FROM [NOTAS FISCAIS] WHERE DATA = @DATANOTA) > 70
	PRINT 'Muita notas'
ELSE
	PRINT 'Poucas notas'

--Faça um script que, a partir do dia 01/01/2017, conte o número de notas fiscais até o dia 10/01/2017.
--Imprima a data e o número de notas fiscais.

DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT
SET @DATAINICIAL = '20170101'
SET @DATAFINAL = '20170110'
WHILE @DATAINICIAL <= @DATAFINAL
BEGIN
	SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATAINICIAL
	PRINT
	CONVERT(VARCHAR(10), @DATAINICIAL) + ' : ' +
	CONVERT(VARCHAR(10), @NUMNOTAS)
	SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END

--Inclua o dia e o número de notas em uma tabela.

IF OBJECT_ID('TABELANOTAS', 'U') IS NOT NULL
	DROP TABLE TABELANOTAS
CREATE TABLE TABELANOTAS ([DATA] DATE, [NUMNOTAS] INT)

DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
DECLARE @NUMNOTAS INT
SET @DATAINICIAL = '20170101'
SET @DATAFINAL = '20170110'
WHILE @DATAINICIAL <= @DATAFINAL
BEGIN
	SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
		WHERE DATA = @DATAINICIAL
	INSERT INTO TABELANOTAS(DATA, NUMNOTAS)
		VALUES (@DATAINICIAL, @NUMNOTAS)
	PRINT
	CONVERT(VARCHAR(10), @DATAINICIAL) + ' : ' +
	CONVERT(VARCHAR(10), @NUMNOTAS)
	SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END
SELECT * FROM TABELANOTAS

--Transforme este script em uma função onde passamos a data como parâmetro e retornamos o número de notas.
--DECLARE @NUMNOTAS INT
--SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
--    WHERE DATA = '20170101'
--PRINT @NUMNOTAS
--Chame esta função de NumeroNotas.
--Após a sua criação, teste seu uso com um SELECT.

CREATE FUNCTION NUMERONOTAS(@DATA DATE) RETURNS INT
AS
BEGIN
DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
    WHERE DATA = @DATA
RETURN @NUMNOTAS
END

SELECT [dbo].[NUMERONOTAS]('20170101')

--Script usando a função NumeroNotas no momento de inserir dados na tabela.
--Execute o SELECT para exibir os dados.

IF OBJECT_ID('TABELANOTAS','U') IS NOT NULL
	DROP TABLE TABELANOTAS
CREATE TABLE TABELANOTAS (DATA DATE, NUMNOTAS INT)
DECLARE @DATAINICIAL DATE
DECLARE @DATAFINAL DATE
SET @DATAINICIAL = '20170101'
SET @DATAFINAL = '20170110'

WHILE @DATAINICIAL <= @DATAFINAL
BEGIN
	INSERT INTO TABELANOTAS (DATA, NUMNOTAS) 
		VALUES (@DATAINICIAL, [dbo].[NUMERONOTAS](@DATAINICIAL))
   SELECT @DATAINICIAL = DATEADD(DAY, 1, @DATAINICIAL)
END
SELECT * FROM TABELANOTAS

--Transforme isto em uma função chamada FuncTabelaNotas, onde o resultado é a consulta:
--SELECT DISTINCT DATA, [dbo].[NUMERONOTAS](DATA) AS NUMERO 
--    FROM [NOTAS FISCAIS] WHERE DATA >= ‘20170101’ 
--        AND DATA <= ‘20170110’
--Ela irá retornar o número de notas fiscais entre duas datas.
--Lembrando que a data inicial e final serão parâmetros desta função.
--Depois, teste a função através de um SELECT.

CREATE FUNCTION FUNCTABELANOTAS(
	@DATAINICIAL AS DATE,
	@DATAFINAL AS DATE
) RETURNS TABLE
RETURN SELECT DISTINCT DATA, [dbo].[NUMERONOTAS](DATA) AS NUMERO
	FROM [NOTAS FISCAIS] WHERE DATA >= @DATAINICIAL
	AND DATA <= @DATAFINAL

SELECT * FROM [dbo].[FUNCTABELANOTAS]('20170101', '20170110')

--SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS] 
--    WHERE DATA >= '20170101' AND DATA <= '20170110'
--GROUP BY DATA
--Retorna o número de notas entre duas datas.
--Modifique a função FuncTabelaNotas para que utilize esta consulta acima.

ALTER FUNCTION FUNCTABELANOTAS(
	@DATAINICIAL AS DATE,
	@DATAFINAL AS DATE
) RETURNS TABLE
RETURN SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
	WHERE DATA >= @DATAINICIAL AND DATA <= @DATAFINAL
GROUP BY DATA

SELECT * FROM [dbo].[FUNCTABELANOTAS]('20170101', '20170110')

