--------------------------------------------------------
--  DDL for Trigger TG_SEQ_AUD
--  Trigger para popular o id da tabela de auditoria
--  Sempre que houver uma inserção na tabela de auditoria
--  o id será populado com o próximo valor da sequence
--------------------------------------------------------
CREATE OR REPLACE NONEDITIONABLE TRIGGER "TRG_SEQ_AUD" 
BEFORE INSERT ON AUDITORIA
FOR EACH ROW
BEGIN
    :NEW.AUD_ID := SEQ_AUD.NEXTVAL;
END;
/
ALTER TRIGGER "TRG_SEQ_AUD" ENABLE;