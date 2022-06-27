--Crie esta tabela no banco de dados SUCOS_VENDAS:
--Nome da tabela deve ser TABELA DE VENDEDORES
--O campo matrícula do vendedor (nome do campo MATRICULA), deve ser uma string de 5 posições.
--O nome do vendedor (nome do campo NOME) deve ser uma string de 100 posições.
--Percentual de comissão (nome do campo PERCENTUAL COMISSÃO) representa o percentual de comissão que o vendedor ganha sobre cada venda.

CREATE TABLE [TABELA DE VENDEDORES2]
( [MATRICULA] varchar(5),
[NOME] varchar(100),
[PERCENTUAL COMISSÃO] float)

DROP TABLE [TABELA DE VENDEDORES2]

--Criar um vendedor na tabela de vendedores. A informação é a seguinte:
--Matrícula - 00235; Nome: Márcio Almeida Silva; Comissão: 8%
--Matrícula - 00236; Nome: Cláudia Morais; Comissão: 8%

INSERT INTO [TABELA DE VENDEDORES2]
([MATRICULA], [NOME], [PERCENTUAL COMISSÃO])
VALUES
('00235','Márcio Almeida Silva',0.08);

INSERT INTO [TABELA DE VENDEDORES2]
([MATRICULA], [NOME], [PERCENTUAL COMISSÃO])
VALUES
('00236','Cláudia Morais',0.08);

--Criação dos dois vendedores em um único comando
INSERT INTO [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISSÃO])
VALUES
('00235','Márcio Almeida Silva',0.08),
('00236','Cláudia Morais',0.08);

--Efetue estas correções na base de dados:
--Márcio Almeida Silva (00235) recebeu aumento e sua comissão passou a ser de 11%
--Cláudia Morais (00236) reclamou que seu nome real é Cláudia Morais Sousa.

UPDATE [TABELA DE VENDEDORES2] SET [PERCENTUAL COMISSÃO] = 0.11
WHERE [MATRICULA] = '00235';

UPDATE [TABELA DE VENDEDORES2] SET [NOME] = 'Cláudia Morais Sousa'
WHERE [MATRICULA] = '00236'

--Márcio Almeida Silva (00235) foi demitido. Retire-o da tabela de vendedores.

DELETE FROM [TABELA DE VENDEDORES2] WHERE [MATRICULA] = '00235';

--Inclua o vendedor Alberto de Sá Verneck, matrícula 00239, com comissão de 8%.

INSERT INTO [TABELA DE VENDEDORES2]
([NOME], 
[MATRICULA],
[PERCENTUAL COMISSÃO])
VALUES
('Alberto de Sá Verneck','00239',0.08);

SELECT * FROM [TABELA DE VENDEDORES2]

DELETE FROM [TABELA DE VENDEDORES2] 
WHERE [PERCENTUAL COMISSÃO] IS NULL

--Altere a tabela TABELA DE VENDEDORES, Usando o campo MATRICULA como chave primária.

ALTER TABLE [TABELA DE VENDEDORES2]
ADD CONSTRAINT PK_TABELA_DE_VENDEDORES2
PRIMARY KEY CLUSTERED ([MATRICULA])

ALTER TABLE [TABELA DE VENDEDORES2]
ALTER COLUMN [PERCENTUAL COMISSÃO]
FLOAT NOT NULL;

--1) Apague a tabela existente.
--2) Crie uma nova [TABELA DE VENDEDORES].
---Nome da tabela deve ser TABELA DE VENDEDORES.
---Vendedor tem como chave o número interno da matrícula (Nome do campo MATRICULA) que deve ser um texto de 5 posições que não pode ser NULL.
---O nome do vendedor (Nome do campo NOME) deve ser um texto de 100 posições.
---% de comissão. Este campo (Nome do campo PERCENTUAL COMISSÃO) representa quantos % de comissão o vendedor ganha sobre cada venda e não pode ser NULL.
--3) Inclua o vendedor Alberto de Sá Verneck, matrícula 00239, com comissão de 8%.
--4) Visualize a tabela.

USE [SUCOS_VENDAS] -- Conecta o banco de dados

DROP TABLE [TABELA DE VENDEDORES2]; 

CREATE TABLE [TABELA DE VENDEDORES2](
    [MATRICULA] [varchar](20) NOT NULL,
    [NOME] [varchar](100) NULL,
    [PERCENTUAL COMISSÃO] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TABELA_DE_VENDEDORES2] PRIMARY KEY CLUSTERED ([MATRICULA]));

INSERT INTO [TABELA DE VENDEDORES2]
([NOME], 
[MATRICULA],
[PERCENTUAL COMISSÃO])
VALUES
('Alberto de Sá Verneck','00239',0.08);

SELECT * FROM [TABELA DE VENDEDORES2];

--Visualize a tabela [TABELA DE VENDEDORES] mostrando o campo MATRICULA com o alias IDENTIFICADOR
--e o campo NOME com o alias NOME DO VENDEDOR.

SELECT [MATRICULA] AS IDENTIFICADOR
      ,[NOME] AS [NOME DO VENDEDOR]
FROM [TABELA DE VENDEDORES2];

--Na tabela [TABELA DE VENDEDORES] aumente em 10% o percentual de comissão do vendedor com matrícula igual a 00239.

UPDATE [TABELA DE VENDEDORES2] 
SET [PERCENTUAL COMISSÃO] = 1.1 * [PERCENTUAL COMISSÃO]
WHERE [MATRICULA] = '00239';

SELECT * FROM [TABELA DE VENDEDORES2] 
WHERE [PERCENTUAL COMISSÃO] > 0.10;

SELECT * FROM [TABELA DE VENDEDORES2] 
WHERE MATRICULA = 00236 OR [PERCENTUAL COMISSÃO] > 0.09;