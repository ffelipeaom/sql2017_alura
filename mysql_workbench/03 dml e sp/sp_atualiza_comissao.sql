CREATE DEFINER=`root`@`localhost` PROCEDURE `atualiza_comissao`(vPercent FLOAT)
BEGIN
UPDATE tabela_de_vendedores SET percentual_comissao = percentual_comissao * (1 + vPercent);
END