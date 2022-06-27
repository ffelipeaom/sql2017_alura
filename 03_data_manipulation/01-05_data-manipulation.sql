
--Crie a tabela CLIENTES por linha de comando SQL.

CREATE TABLE [dbo].[CLIENTES2](
    [CPF] VARCHAR(11) NOT NULL,
    [NOME] VARCHAR(50) NULL,
    [ENDERE�O] VARCHAR(100) NULL,
    [BAIRRO] VARCHAR(50) NULL,
    [CIDADE] VARCHAR(50) NULL,
    [ESTADO] VARCHAR(50) NULL,
    [CEP] VARCHAR(8) NULL,
    [DATA NASCIMENTO] DATE NULL,
    [IDADE] INT NULL,
    [SEXO] VARCHAR(1),
    [LIMITE DE CR�DITO] FLOAT,
    [VOLUME DE COMPRA] FLOAT,
    [PRIMEIRA COMPRA] BIT, 
    CONSTRAINT [PK_CLIENTES2] 
        PRIMARY KEY CLUSTERED ([CPF]))

--Com o script de cria��o da tabela NOTAS,
--edite-o para criar a tabela de itens de notas fiscais, conforme:
---N�mero (PK) e (FK - Tabela de Vendas) - Varchar(5)
---C�digo Produto (PK) e (FK - Tabela de Produtos) - Varchar(10)
---Quantidade - Int32
---Pre�o - Float
--USE [SUCOS_VENDAS]
--GO

--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

--CREATE TABLE [dbo].[ITENS VENDIDOS](
--    [N�MERO] VARCHAR(5) NOT NULL,
--    [C�DIGO] VARCHAR(10) NOT NULL,
--    [QUANTIDADE] INT NULL,
--    [PRE�O] FLOAT NULL, 
--CONSTRAINT [PK_ITENS_VENDIDOS] PRIMARY KEY CLUSTERED (
--    [N�MERO] ASC, [C�DIGO] ASC
--) WITH (
--    PAD_INDEX = OFF, 
--    STATISTICS_NORECOMPUTE = OFF, 
--    IGNORE_DUP_KEY = OFF, 
--    ALLOW_ROW_LOCKS = ON, 
--    ALLOW_PAGE_LOCKS = ON
--) ON [PRIMARY]) ON [PRIMARY]
--GO

--ALTER TABLE [dbo].[ITENS VENDIDOS]  WITH CHECK ADD  
--CONSTRAINT [FK_ITENS VENDIDOS_NOTAS] FOREIGN KEY([N�MERO])
--REFERENCES [dbo].[NOTAS] ([N�MERO])
--GO

--ALTER TABLE [dbo].[ITENS VENDIDOS] 
--CHECK CONSTRAINT [FK_ITENS VENDIDOS_NOTAS]
--GO

--ALTER TABLE [dbo].[ITENS VENDIDOS]  WITH CHECK ADD  
--CONSTRAINT [FK_ITENS VENDIDOS_TABELA DE PRODUTOS] FOREIGN KEY([C�DIGO])
--REFERENCES [dbo].[TABELA DE PRODUTOS] ([C�DIGO])
--GO

--ALTER TABLE [dbo].[ITENS VENDIDOS] 
--CHECK CONSTRAINT [FK_ITENS VENDIDOS_TABELA DE PRODUTOS]
--GO


--Inclua registros na tabela de clientes:

INSERT INTO [dbo].[CLIENTES2] ([CPF], [NOME], [ENDERE�O], 
    [BAIRRO], [CIDADE], [ESTADO], [CEP], [DATA NASCIMENTO], 
    [IDADE], [SEXO], [LIMITE DE CR�DITO], [VOLUME DE COMPRA], 
    [PRIMEIRA COMPRA])
VALUES ('1471156710', '�rica Carvalho', 'R. Iriquitia', 'Jardins', 'S�o Paulo', 
        'SP', '80012212', '19900901', 27, 'F', 170000, 24500,0), 
    ('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', '�gua Santa', 
        'Rio de Janeiro', 'RJ', '22000000', '20000212', 18, 'M', 100000, 20000, 1), 
    ('2600586709', 'C�sar Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 
        'Rio de Janeiro', 'RJ', '22020001', '20000312', 18, 'M', 120000, 22000, 0)


--Inclua todos os clientes na tabela CLIENTES baseados nos registros da tabela TABELA DE CLIENTES.

INSERT INTO CLIENTES2 ([CPF],[NOME],[ENDERE�O],[BAIRRO],
    [CIDADE],[ESTADO],[CEP],[DATA NASCIMENTO],[IDADE],
    [SEXO],[LIMITE DE CR�DITO],[VOLUME DE COMPRA],[PRIMEIRA COMPRA])
SELECT [CPF],[NOME],[ENDERECO 1] AS ENDERE�O,[BAIRRO],[CIDADE],[ESTADO],
    [CEP],[DATA DE NASCIMENTO],[IDADE],[SEXO],[LIMITE DE CREDITO],
    [VOLUME DE COMPRA],[PRIMEIRA COMPRA]
FROM [SUCOS_VENDAS].[dbo].[TABELA DE CLIENTES] 
    WHERE [CPF] NOT IN ('1471156710','19290992743','2600586709')

SELECT * FROM CLIENTES2

--Modifique o endere�o do cliente 19290992743 para R. Jorge Emilio 23, em Santo Amaro, S�o Paulo, SP, CEP 8833223.

UPDATE [dbo].[CLIENTES2] SET 
    [ENDERE�O] = 'R. Jorge Emilio 23',
    [BAIRRO] = 'Santo Amaro',
    [CIDADE] = 'S�o Paulo',
    [ESTADO] = 'SP',
    [CEP] = '8833223'
WHERE [CPF] = '19290992743'

--Altere o volume de compra em 20% dos clientes do estado do Rio de Janeiro.
UPDATE [dbo].[CLIENTES2]
    SET [VOLUME DE COMPRA] = [VOLUME DE COMPRA] * 1.2
WHERE [ESTADO] = 'RJ'

--Aumentar em 30% o volume de compra dos clientes que possuem, em seus endere�os, bairros onde os vendedores possuam escrit�rios.
UPDATE A SET A.[VOLUME DE COMPRA] = 
    A.[VOLUME DE COMPRA] * 1.30
FROM [dbo].[CLIENTES2] A 
INNER JOIN [dbo].[TABELA DE VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO]

--
MERGE INTO [DBO].[CLIENTES2] A
USING [DBO].[TABELA DE VENDEDORES] B
ON A.[BAIRRO] = B.[BAIRRO]
WHEN MATCHED THEN
UPDATE SET A.[VOLUME DE COMPRA] = 
    A.[VOLUME DE COMPRA] * 1.30;

--Exclua as notas fiscais (apenas o cabe�alho) cujos clientes tenham menos que 18 anos.

DELETE A FROM [NOTAS FISCAIS] A
INNER JOIN [CLIENTES2] B ON A.[CPF] = B.[CPF] 
WHERE B.[IDADE] < 18

--Construa uma TRIGGER, de nome TG_CLIENTES_IDADE, que atualize as idades dos clientes, na tabela de clientes,
--toda vez que a tabela sofrer uma inclus�o, altera��o ou exclus�o.

CREATE TRIGGER TG_CLIENTES_IDADE
ON [CLIENTES2]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
UPDATE [CLIENTES2] SET [IDADE] = 
    DATEDIFF(YEAR, [DATA NASCIMENTO], GETDATE());
END;




