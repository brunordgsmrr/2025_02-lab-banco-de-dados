------------------------------------------------------------------------
-- APLICAÇÃO
------------------------------------------------------------------------
UPDATE H_ACIDENTES SET H_ACD_SENTIDO = 'LESTE' WHERE H_ACD_SENTIDO = 'NORTE' AND H_ACD_MARCO_QM = 999;

UPDATE H_ACIDENTES SET H_ACD_SENTIDO = 'SUL' WHERE H_ACD_SENTIDO = 'LESTE' AND H_ACD_MARCO_QM = 999;

UPDATE H_ACIDENTES SET H_ACD_MARCO_QM = 510 WHERE H_ACD_SENTIDO = 'SUL' AND H_ACD_MARCO_QM = 999;


------------------------------------------------------------------------
-- AUDITOR
------------------------------------------------------------------------
SELECT * FROM AUDITORIA;


------------------------------------------------------------------------
-- Objetivo: Atualiza um valor na tabela corrente para enviar para a  
-- tabela de historiamento
-- Usuario: APLICAÇÃO
------------------------------------------------------------------------
UPDATE ACIDENTES SET ACD_SENTIDO = 'LESTE' WHERE ACD_ID = 127575;
SELECT * FROM H_ACIDENTES ORDER BY H_ACD_CREATED_AT DESC;

------------------------------------------------------------------------
-- Objetivo: Atualiza um valor na tabela de historiamento para exceutar 
-- o trigger de auditoria
-- Usuario: APLICAÇÃO
------------------------------------------------------------------------
UPDATE H_ACIDENTES SET H_ACD_SENTIDO = 'SUL' WHERE H_ACD_ID = 127575;
