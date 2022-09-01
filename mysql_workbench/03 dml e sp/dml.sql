USE vendas_sucos;

ALTER TABLE itens_notas ADD CONSTRAINT FK_NOTAS
FOREIGN KEY (NUMERO)
REFERENCES NOTAS (NUMERO);

ALTER TABLE itens_notas ADD CONSTRAINT FK_PRODUTOS
FOREIGN KEY (CODIGO)
REFERENCES PRODUTOS (CODIGO);

INSERT INTO clientes
(CPF,NOME,ENDERECO,BAIRRO,CIDADE,ESTADO,CEP,DATA_NASCIMENTO,IDADE,SEXO,LIMITE_CREDITO,VOLUME_COMPRA,PRIMEIRA_COMPRA)
VALUES 
('1471156710','Érica Carvalho','R. Iriquitia','Jardins','São Paulo','SP','80012212','19900901',27,'F',170000,24500,0),
('19290992743','Fernando Cavalcante','R. Dois de Fevereiro','Água Santa','Rio de Janeiro','RJ','22000000','20000212',18,'M',100000,20000,1),
('2600586709','César Teixeira','Rua Conde de Bonfim','Tijuca','Rio de Janeiro','RJ','22020001','20000312',18,'M',120000,22000,0);

INSERT INTO clientes
(CPF,NOME,ENDERECO,BAIRRO,CIDADE,ESTADO,CEP,DATA_NASCIMENTO,IDADE,SEXO,LIMITE_CREDITO,VOLUME_COMPRA,PRIMEIRA_COMPRA)

SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO, CIDADE, ESTADO, CEP,DATA_DE_NASCIMENTO AS  DATA_NASCIMENTO, IDADE, SEXO,LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUME_DE_COMPRA AS VOLUME_COMPRA,PRIMEIRA_COMPRA 
 FROM sucos_vendas.tabela_de_clientes 
 WHERE CPF NOT IN (SELECT CPF FROM clientes);
 
UPDATE CLIENTES
SET ENDERECO = 'R. Jorge Emilio 23',
BAIRRO = 'Santo Amaro',
CIDADE = 'São Paulo',
ESTADO = 'SP',
CEP = '8833223'
WHERE CPF = '19290992743 '

SELECT A.CPF FROM CLIENTES A
INNER JOIN VENDEDORES B
ON A.BAIRRO = B.BAIRRO
UPDATE CLIENTES A INNER JOIN VENDEDORES B
ON A.BAIRRO = B.BAIRRO
SET A.VOLUME_COMPRA = A.VOLUME_COMPRA * 1.30

SELECT A.NUMERO FROM NOTAS A
INNER JOIN CLIENTES B ON A.CPF = B.CPF
WHERE B.IDADE <= 18
DELETE A FROM NOTAS A
INNER JOIN CLIENTES B ON A.CPF = B.CPF
WHERE B.IDADE <= 18

DELETE FROM ITENS_NOTAS;
DELETE FROM NOTAS;

DROP TABLE TAB_IDENTITY2;
CREATE TABLE TAB_IDENTITY2 (ID INT AUTO_INCREMENT, DESCRITOR VARCHAR(20), PRIMARY KEY(ID));

INSERT INTO TAB_IDENTITY2 (DESCRITOR) VALUES ('CLIENTE1');
INSERT INTO TAB_IDENTITY2 (DESCRITOR) VALUES ('CLIENTE2');
INSERT INTO TAB_IDENTITY2 (DESCRITOR) VALUES ('CLIENTE3');
INSERT INTO TAB_IDENTITY2 (ID, DESCRITOR) VALUES (NULL, 'CLIENTE4');

DELETE FROM TAB_IDENTITY2 WHERE ID = 3;

INSERT INTO TAB_IDENTITY2 (ID, DESCRITOR) VALUES (NULL, 'CLIENTE6');
INSERT INTO TAB_IDENTITY2 (ID, DESCRITOR) VALUES (NULL, 'CLIENTE7');

DELETE FROM TAB_IDENTITY2 WHERE ID = 2;

SELECT * FROM TAB_IDENTITY2

USE sucos_vendas;

ALTER TABLE itens_notas ADD CONSTRAINT FK_NOTAS
FOREIGN KEY (NUMERO)
REFERENCES NOTAS (NUMERO);