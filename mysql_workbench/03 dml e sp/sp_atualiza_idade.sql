CREATE DEFINER=`root`@`localhost` PROCEDURE `atualiza_idade`()
BEGIN
UPDATE tabela_de_clientes set idade =  TIMESTAMPDIFF(YEAR, data_de_nascimento, CURDATE());
END