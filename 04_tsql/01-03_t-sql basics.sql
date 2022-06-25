--Crie 4 vari�veis com as caracter�sticas abaixo:
--Nome: Cliente. Tipo: Caracteres com 10 posi��es. Valor: Jo�o
--Nome: Idade. Tipo: Inteiro. Valor: 10
--Nome: DataNascimento. Tipo: Data. Valor: 10/01/2007
--Nome: Custo. Tipo: N�mero com casas decimais. Valor: 10,23

DECLARE @CLIENTE VARCHAR(10), @IDADE INT, @NASCIMENTO DATE, @CUSTO FLOAT

SET @CLIENTE = 'Jo�o'
SET @IDADE = '10'
SET @NASCIMENTO = '20070110'
SET @CUSTO = '10.23'

PRINT @CLIENTE
PRINT @IDADE
PRINT @NASCIMENTO
PRINT @CUSTO

--Crie uma vari�vel chamada NUMNOTAS e atribua a ela o n�mero de notas fiscais do dia 01/01/2017.
--Mostre na sa�da do script o valor da vari�vel.

DECLARE @NUMNOTAS INT

SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS]
	WHERE DATA = '20170101'
PRINT @NUMNOTAS

--Crie um script que, baseado em uma data, conte o n�mero de notas fiscais.
--Se houver mais de 70 notas, exiba a mensagem "Muita nota".
--Se n�o, exiba a mensagem "Pouca nota". Exiba tamb�m o n�mero de notas.

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

--Em vez de testar com a vari�vel @NUMNOTAS, use a pr�pria consulta SQL na condi��o de teste.

DECLARE @DATANOTA DATE
SET @DATANOTA = '20170102'
IF (SELECT COUNT(*) FROM [NOTAS FISCAIS] WHERE DATA = @DATANOTA) > 70
	PRINT 'Muita notas'
ELSE
	PRINT 'Poucas notas'

--Fa�a um script que, a partir do dia 01/01/2017, conte o n�mero de notas fiscais at� o dia 10/01/2017.
--Imprima a data e o n�mero de notas fiscais.

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

--Inclua o dia e o n�mero de notas em uma tabela.

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

--Transforme este script em uma fun��o onde passamos a data como par�metro e retornamos o n�mero de notas.
--DECLARE @NUMNOTAS INT
--SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
--    WHERE DATA = '20170101'
--PRINT @NUMNOTAS
--Chame esta fun��o de NumeroNotas.
--Ap�s a sua cria��o, teste seu uso com um SELECT.

CREATE FUNCTION NUMERONOTAS(@DATA DATE) RETURNS INT
AS
BEGIN
DECLARE @NUMNOTAS INT
SELECT @NUMNOTAS = COUNT(*) FROM [NOTAS FISCAIS] 
    WHERE DATA = @DATA
RETURN @NUMNOTAS
END

SELECT [dbo].[NUMERONOTAS]('20170101')

--Script usando a fun��o NumeroNotas no momento de inserir dados na tabela.
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

--Transforme isto em uma fun��o chamada FuncTabelaNotas, onde o resultado � a consulta:
--SELECT DISTINCT DATA, [dbo].[NUMERONOTAS](DATA) AS NUMERO 
--    FROM [NOTAS FISCAIS] WHERE DATA >= �20170101� 
--        AND DATA <= �20170110�
--Ela ir� retornar o n�mero de notas fiscais entre duas datas.
--Lembrando que a data inicial e final ser�o par�metros desta fun��o.
--Depois, teste a fun��o atrav�s de um SELECT.

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
--Retorna o n�mero de notas entre duas datas.
--Modifique a fun��o FuncTabelaNotas para que utilize esta consulta acima.

ALTER FUNCTION FUNCTABELANOTAS(
	@DATAINICIAL AS DATE,
	@DATAFINAL AS DATE
) RETURNS TABLE
RETURN SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
	WHERE DATA >= @DATAINICIAL AND DATA <= @DATAFINAL
GROUP BY DATA

SELECT * FROM [dbo].[FUNCTABELANOTAS]('20170101', '20170110')

