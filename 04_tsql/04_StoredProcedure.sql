--Crie uma stored procedure chamada BuscaPorEntidadesCompleta
--Acrescente a entidade PRODUTOS.
--Das entidades, liste apenas os seus identificadores e os seus nomes.

SELECT * FROM [TABELA DE PRODUTOS]

CREATE PROCEDURE BUSCAPORENTIDADESCOMPLETA @ENTIDADE AS VARCHAR(10)
AS
BEGIN
IF @ENTIDADE = 'CLIENTES'
    SELECT
		[CPF] AS IDENTIFICADOR,
		[NOME] AS DESCRITOR, 
        [BAIRRO] AS BAIRRO
		FROM [TABELA DE CLIENTES]
ELSE IF @ENTIDADE = 'VENDEDORES'
    SELECT
		[MATRICULA] AS IDENTIFICADOR,
		[NOME] AS DESCRITOR, 
        [BAIRRO] AS BAIRRO
		FROM [TABELA DE VENDEDORES]
ELSE IF @ENTIDADE = 'PRODUTOS'
	SELECT
		[CODIGO DO PRODUTO] AS IDENTIFICADOR,
		[NOME DO PRODUTO] AS DESCRITOR
		FROM [TABELA DE PRODUTOS]
END

EXEC BUSCAPORENTIDADESCOMPLETA @ENTIDADE = 'PRODUTOS'

--Faça uma stored procedure que terá como entrada de dados:
--Mês, Ano, Alíquota, Tipo de Produto (Garrafas, Lata ou PET)
--Ela irá modificar:
--a alíquota para a alíquota informada na entrada da stored procedure,
--para as vendas de todas as notas fiscais no mês/ano informados,
--para todos os produtos do tipo informado.

CREATE PROCEDURE AtualizaImposto
	@MES AS INT,
	@ANO AS INT, 
	@EMBALAGEM AS VARCHAR(10),
	@IMPOSTO AS FLOAT
AS
UPDATE NF SET NF.IMPOSTO = @IMPOSTO FROM [NOTAS FISCAIS] NF
    INNER JOIN [ITENS NOTAS FISCAIS] INF 
        ON NF.NUMERO = INF.NUMERO
    INNER JOIN [TABELA DE PRODUTOS] TP 
        ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
    WHERE MONTH(NF.DATA) = @MES AND YEAR(NF.DATA) = @ANO 
        AND TP.EMBALAGEM = @EMBALAGEM

EXEC AtualizaImposto @MES = 2, @ANO = 2017, @EMBALAGEM = 'PET', @IMPOSTO = 0.12

--Construa uma SP que retorne o número de notas fiscais por dia, baseada na lista de dias passada como parâmetro.

CREATE TYPE ListaDatas as TABLE (
    DATANOTA date NOT NULL
)

CREATE PROCEDURE ListaNumeroNotas @ListaDatas
    AS ListaDatas READONLY AS
SELECT DATA, COUNT(*) AS NUMERO FROM [NOTAS FISCAIS]
    WHERE DATA IN (SELECT DATANOTA FROM @ListaDatas)
GROUP BY DATA

DECLARE @ListaDatas AS ListaDatas
INSERT INTO @ListaDatas (DATANOTA) VALUES ('20180101'), 
    ('20180102'), ('20180103')
EXEC ListaNumeroNotas @ListaDatas = @ListaDatas

--Construa uma SP (nome NumNotasSP) cujos parâmetros são:
--uma data passada como valor, e o número de notas, passado como referência.
--Depois, faça um script onde, na variável @NUMNOTAS, some as notas do dia 01/01/2017 e 02/01/2017.

CREATE PROCEDURE NumNotasSP
	@DATA AS DATE,
	@NUMNOTAS AS INT OUTPUT
AS
BEGIN
	DECLARE @NUMNOTASLOCAL AS INT
	SELECT @NUMNOTASLOCAL = COUNT(*)
		FROM [NOTAS FISCAIS] WHERE [DATA] = @DATA
	SET @NUMNOTAS = @NUMNOTAS + @NUMNOTASLOCAL
END

DECLARE @DATA DATE
DECLARE @NUMNOTAS INT
SET @NUMNOTAS = 0
SET @DATA = '20170101'
EXEC NumNotasSP @DATA = @DATA, @NUMNOTAS = @NUMNOTAS OUTPUT
SET @DATA = '20170102'
EXEC NumNotasSP @DATA = @DATA, @NUMNOTAS = @NUMNOTAS OUTPUT
PRINT @NUMNOTAS

