-- TESTE DA AUDITORIA

----------------------------------------------------------------------------------------------
-- Usuario: APP
----------------------------------------------------------------------------------------------
-- Alterando os valores do banco de historiamento para 
-- envia-los para ao bando de auditoria
SELECT H_ACD_ID, H_ACD_SENTIDO, H_ACD_DTHR_OC, H_ACD_TIPO_PISTA, H_ACD_ROD_ID, H_ACD_CREATED_AT 
FROM H_ACIDENTES ORDER BY H_ACD_CREATED_AT DESC;

UPDATE H_ACIDENTES SET H_ACD_SENTIDO = 'SUL' WHERE H_ACD_CREATED_AT = '14/11/25 17:49:51,471000000'; -- VALORES ALTERADO
UPDATE H_ACIDENTES SET H_ACD_TIPO_PISTA = 'ACESSO' WHERE H_ACD_CREATED_AT = '14/11/25 17:49:51,471000000'; -- VALORES ALTERADO
UPDATE H_ACIDENTES SET H_ACD_ROD_ID = 294 WHERE H_ACD_CREATED_AT = '14/11/25 17:49:51,471000000'; -- VALORES ALTERADO

----------------------------------------------------------------------------------------------
-- Usuario: AUDITORIA
----------------------------------------------------------------------------------------------
SELECT * FROM auditoria;


SELECT * FROM ACIDENTES ORDER BY ACD_ID DESC;
