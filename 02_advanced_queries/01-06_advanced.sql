
SELECT *  FROM [ITENS NOTAS FISCAIS] 
WHERE [QUANTIDADE] > 60 AND [PREÇO] <= 3

--Quantos clientes possuem o último sobrenome Mattos?

SELECT * FROM [TABELA DE CLIENTES] WHERE
NOME LIKE '%Mattos'

--Quantos bairros diferentes da cidade do Rio de Janeiro possuem clientes?

SELECT DISTINCT BAIRRO FROM [TABELA DE CLIENTES]
WHERE CIDADE = 'Rio de Janeiro'

--Queremos obter as 10 primeiras vendas do dia 01/01/2017.
--Qual seria o comando SQL para obter este resultado?

SELECT TOP 10 * FROM [NOTAS FISCAIS] 
WHERE [DATA] = '2017-01-01'

--Qual foi a maior venda do produto "Linha Refrescante - 1 Litro - Morango/Limão", em quantidade?

SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [NOME DO PRODUTO] = 'Linha Refrescante - 1 Litro - Morango/Limão'

SELECT * FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
ORDER BY QUANTIDADE DESC

--Quantos itens de venda existem com a maior quantidade de venda para o produto '1101035'?

SELECT COUNT(*) FROM [ITENS NOTAS FISCAIS]
WHERE [CODIGO DO PRODUTO] = '1101035'
AND QUANTIDADE = 99

--Quais são os clientes que fizeram mais de 2000 compras em 2016?

SELECT CPF, COUNT(*) FROM [NOTAS FISCAIS] 
WHERE YEAR(DATA) = 2016 
GROUP BY CPF 
HAVING COUNT(*) > 2000

--Veja o ano de nascimento dos clientes e classifique-os como:
--nascidos antes de 1990 são adultos, nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças.
--Liste o nome do cliente e esta classificação.

SELECT [NOME],
CASE
    WHEN YEAR([DATA DE NASCIMENTO]) < 1990 THEN 'Adulto'
    WHEN YEAR([DATA DE NASCIMENTO]) between 1990 and 1995 THEN 'Jovem'
    ELSE 'Criança' END AS [Classificação Etária]
 FROM [TABELA DE CLIENTES]

--Obtenha o faturamento anual da empresa.

SELECT YEAR(DATA), SUM (QUANTIDADE * [PREÇO]) AS FATURAMENTO
FROM [NOTAS FISCAIS] NF INNER JOIN [ITENS NOTAS FISCAIS] INF 
ON NF.NUMERO = INF.NUMERO
GROUP BY YEAR(DATA)

---subqueries
SELECT CPF, COUNT(*) FROM [NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF
HAVING COUNT(*) > 2000
---is equal to
SELECT X.CPF, X.CONTADOR FROM 
(SELECT CPF, COUNT(*) AS CONTADOR FROM [NOTAS FISCAIS]
WHERE YEAR(DATA) = 2016
GROUP BY CPF) X WHERE X.CONTADOR > 2000

--Faça uma consulta que lista o nome do cliente e o endereço completo (com rua, bairro, cidade e estado).

SELECT NOME, CONCAT([ENDERECO 1], ' ', BAIRRO, ' ', CIDADE, ' ', ESTADO) AS COMPLETO
FROM [TABELA DE CLIENTES]

--Crie uma consulta que mostre o nome e a idade dos clientes.

SELECT NOME, DATEDIFF(YEAR, [DATA DE NASCIMENTO], GETDATE()) AS IDADE
FROM [TABELA DE CLIENTES]

--Calcule o valor do imposto pago no ano de 2016, arredondando para o menor inteiro.

SELECT YEAR(DATA), FLOOR(SUM(IMPOSTO * (QUANTIDADE * PREÇO))) 
FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF ON NF.NUMERO = INF.NUMERO
WHERE YEAR(DATA) = 2016
GROUP BY YEAR(DATA)

--Construir um SQL cujo resultado seja, para cada cliente: **"O cliente João da Silva faturou 120000 no ano de 2016".
--Somente para o ano de 2016.

SELECT CONCAT('O cliente ', TC.NOME, ' faturou ', 
CONVERT(VARCHAR, CONVERT(DECIMAL(15,2), SUM(INF.QUANTIDADE * INF.[PREÇO]))), ' no ano ',   CONVERT(VARCHAR, YEAR(NF.DATA))) AS SENTENCA FROM [NOTAS FISCAIS] NF
INNER JOIN [ITENS NOTAS FISCAIS] INF ON NF.NUMERO = INF.NUMERO
INNER JOIN [TABELA DE CLIENTES] TC ON NF.CPF = TC.CPF
WHERE YEAR(DATA) = 2016
GROUP BY TC.NOME, YEAR(DATA)

--Modifique o relatório, mas agora para ver o ranking das vendas por tamanho.

SELECT AUX1.TAMANHO, AUX1.ANO, CONVERT(DECIMAL(15,2), AUX1.FATURAMENTO) AS FATURAMENTO, 
CONVERT(VARCHAR, CONVERT(DECIMAL(15,2),(AUX1.FATURAMENTO/AUX2.TOTAL) * 100)) + ' %' 
AS PERCENTUAL FROM
(SELECT TP.TAMANHO, YEAR(NF.DATA) AS ANO, SUM (INF.QUANTIDADE * INF.PREÇO) AS FATURAMENTO
FROM [ITENS NOTAS FISCAIS] INF INNER JOIN [TABELA DE PRODUTOS] TP
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF 
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY TP.TAMANHO, YEAR(NF.DATA)) AUX1
INNER JOIN (SELECT YEAR(NF.DATA) AS ANO, SUM (INF.QUANTIDADE * INF.PREÇO) AS TOTAL
FROM [ITENS NOTAS FISCAIS] INF INNER JOIN [TABELA DE PRODUTOS] TP
ON TP.[CODIGO DO PRODUTO] = INF.[CODIGO DO PRODUTO]
INNER JOIN [NOTAS FISCAIS] NF 
ON NF.NUMERO = INF.NUMERO
WHERE YEAR(NF.DATA) = 2016
GROUP BY YEAR(NF.DATA)) AUX2
ON AUX1.ANO = AUX2.ANO
ORDER BY AUX1.FATURAMENTO DESC