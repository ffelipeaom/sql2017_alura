CREATE DEFINER=`root`@`localhost` PROCEDURE `Comparativo_Vendas`(DataInicial DATE, DataFinal DATE)
BEGIN
DECLARE FaturamentoInicial FLOAT;
DECLARE FaturamentoFinal FLOAT;
DECLARE Variacao float;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoInicial FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataInicial;
SELECT SUM(B.QUANTIDADE * B.PRECO) INTO FaturamentoFinal FROM 
NOTAS_FISCAIS A INNER JOIN ITENS_NOTAS_FISCAIS B
ON A.NUMERO = B.NUMERO
WHERE A.DATA_VENDA = DataFinal ;
SET Variacao = ((FaturamentoFinal / FaturamentoInicial) -1) * 100;
IF Variacao > 10 THEN
SELECT 'Verde';
ELSEIF Variacao >= -10 AND Variacao <= 10 THEN
SELECT 'Amarelo';
ELSE
SELECT 'Vermelho';
END IF;   

END