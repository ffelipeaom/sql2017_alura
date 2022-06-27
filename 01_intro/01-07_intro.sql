--Crie esta tabela no banco de dados SUCOS_VENDAS:
--Nome da tabela deve ser TABELA DE VENDEDORES
--O campo matr�cula do vendedor (nome do campo MATRICULA), deve ser uma string de 5 posi��es.
--O nome do vendedor (nome do campo NOME) deve ser uma string de 100 posi��es.
--Percentual de comiss�o (nome do campo PERCENTUAL COMISS�O) representa o percentual de comiss�o que o vendedor ganha sobre cada venda.

CREATE TABLE [TABELA DE VENDEDORES2]
( [MATRICULA] varchar(5),
[NOME] varchar(100),
[PERCENTUAL COMISS�O] float)

DROP TABLE [TABELA DE VENDEDORES2]

--Criar um vendedor na tabela de vendedores. A informa��o � a seguinte:
--Matr�cula - 00235; Nome: M�rcio Almeida Silva; Comiss�o: 8%
--Matr�cula - 00236; Nome: Cl�udia Morais; Comiss�o: 8%

INSERT INTO [TABELA DE VENDEDORES2]
([MATRICULA], [NOME], [PERCENTUAL COMISS�O])
VALUES
('00235','M�rcio Almeida Silva',0.08);

INSERT INTO [TABELA DE VENDEDORES2]
([MATRICULA], [NOME], [PERCENTUAL COMISS�O])
VALUES
('00236','Cl�udia Morais',0.08);

--Cria��o dos dois vendedores em um �nico comando
INSERT INTO [TABELA DE VENDEDORES]
([MATRICULA], [NOME], [PERCENTUAL COMISS�O])
VALUES
('00235','M�rcio Almeida Silva',0.08),
('00236','Cl�udia Morais',0.08);

--Efetue estas corre��es na base de dados:
--M�rcio Almeida Silva (00235) recebeu aumento e sua comiss�o passou a ser de 11%
--Cl�udia Morais (00236) reclamou que seu nome real � Cl�udia Morais Sousa.

UPDATE [TABELA DE VENDEDORES2] SET [PERCENTUAL COMISS�O] = 0.11
WHERE [MATRICULA] = '00235';

UPDATE [TABELA DE VENDEDORES2] SET [NOME] = 'Cl�udia Morais Sousa'
WHERE [MATRICULA] = '00236'

--M�rcio Almeida Silva (00235) foi demitido. Retire-o da tabela de vendedores.

DELETE FROM [TABELA DE VENDEDORES2] WHERE [MATRICULA] = '00235';

--Inclua o vendedor Alberto de S� Verneck, matr�cula 00239, com comiss�o de 8%.

INSERT INTO [TABELA DE VENDEDORES2]
([NOME], 
[MATRICULA],
[PERCENTUAL COMISS�O])
VALUES
('Alberto de S� Verneck','00239',0.08);

SELECT * FROM [TABELA DE VENDEDORES2]

DELETE FROM [TABELA DE VENDEDORES2] 
WHERE [PERCENTUAL COMISS�O] IS NULL

--Altere a tabela TABELA DE VENDEDORES, Usando o campo MATRICULA como chave prim�ria.

ALTER TABLE [TABELA DE VENDEDORES2]
ADD CONSTRAINT PK_TABELA_DE_VENDEDORES2
PRIMARY KEY CLUSTERED ([MATRICULA])

ALTER TABLE [TABELA DE VENDEDORES2]
ALTER COLUMN [PERCENTUAL COMISS�O]
FLOAT NOT NULL;

--1) Apague a tabela existente.
--2) Crie uma nova [TABELA DE VENDEDORES].
---Nome da tabela deve ser TABELA DE VENDEDORES.
---Vendedor tem como chave o n�mero interno da matr�cula (Nome do campo MATRICULA) que deve ser um texto de 5 posi��es que n�o pode ser NULL.
---O nome do vendedor (Nome do campo NOME) deve ser um texto de 100 posi��es.
---% de comiss�o. Este campo (Nome do campo PERCENTUAL COMISS�O) representa quantos % de comiss�o o vendedor ganha sobre cada venda e n�o pode ser NULL.
--3) Inclua o vendedor Alberto de S� Verneck, matr�cula 00239, com comiss�o de 8%.
--4) Visualize a tabela.

USE [SUCOS_VENDAS] -- Conecta o banco de dados

DROP TABLE [TABELA DE VENDEDORES2]; 

CREATE TABLE [TABELA DE VENDEDORES2](
    [MATRICULA] [varchar](20) NOT NULL,
    [NOME] [varchar](100) NULL,
    [PERCENTUAL COMISS�O] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TABELA_DE_VENDEDORES2] PRIMARY KEY CLUSTERED ([MATRICULA]));

INSERT INTO [TABELA DE VENDEDORES2]
([NOME], 
[MATRICULA],
[PERCENTUAL COMISS�O])
VALUES
('Alberto de S� Verneck','00239',0.08);

SELECT * FROM [TABELA DE VENDEDORES2];

--Visualize a tabela [TABELA DE VENDEDORES] mostrando o campo MATRICULA com o alias IDENTIFICADOR
--e o campo NOME com o alias NOME DO VENDEDOR.

SELECT [MATRICULA] AS IDENTIFICADOR
      ,[NOME] AS [NOME DO VENDEDOR]
FROM [TABELA DE VENDEDORES2];

--Na tabela [TABELA DE VENDEDORES] aumente em 10% o percentual de comiss�o do vendedor com matr�cula igual a 00239.

UPDATE [TABELA DE VENDEDORES2] 
SET [PERCENTUAL COMISS�O] = 1.1 * [PERCENTUAL COMISS�O]
WHERE [MATRICULA] = '00239';

SELECT * FROM [TABELA DE VENDEDORES2] 
WHERE [PERCENTUAL COMISS�O] > 0.10;

SELECT * FROM [TABELA DE VENDEDORES2] 
WHERE MATRICULA = 00236 OR [PERCENTUAL COMISS�O] > 0.09;