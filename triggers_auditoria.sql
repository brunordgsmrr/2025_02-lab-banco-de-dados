--------------------------------------------------------
--  DDL for Trigger TG_AUD_ACD
--------------------------------------------------------
CREATE OR REPLACE NONEDITIONABLE TRIGGER "TG_AUD_ACD" 
AFTER UPDATE OR DELETE ON ACIDENTES
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR(30);
    V_USU_SO VARCHAR(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR(20);
    V_TABELA VARCHAR(30) := 'ACIDENTES';
BEGIN
    SELECT USER INTO V_USU_BD FROM DUAL;
    V_ROWID := :OLD.ROWID;
    IF DELETING THEN
        V_TP_OPERACAO := 'D';
        AUDITORIA.PROC_AUDITORIA(
            V_TABELA,
            V_ROWID,
            V_TP_OPERACAO,
            NULL,
            NULL,
            NULL,
            V_USU_BD,
            V_USU_SO,
            SYSDATE
        );
    ELSE
        V_TP_OPERACAO := 'U';
        IF (:NEW.TESTE_ID <> :OLD.TESTE_ID) THEN
            AUDITORIA.PROC_AUDITORIA(
                V_TABELA,
                V_ROWID,
                V_TP_OPERACAO,
                'TESTE_ID',
                :OLD.TESTE_ID,
                :NEW.TESTE_ID,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.TESTE_NOME <> :OLD.TESTE_NOME) THEN
            AUDITORIA.PROC_AUDITORIA(
                V_TABELA,
                V_ROWID,
                V_TP_OPERACAO,
                'TESTE_NOME',
                :OLD.TESTE_NOME,
                :NEW.TESTE_NOME,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
        IF (:NEW.TESTE_DATA_HIST <> :OLD.TESTE_DATA_HIST) THEN
            AUDITORIA.PROC_AUDITORIA(
                V_TABELA,
                V_ROWID,
                V_TP_OPERACAO,
                'TESTE_DATA_HIST',
                :OLD.TESTE_DATA_HIST,
                :NEW.TESTE_DATA_HIST,
                V_USU_BD,
                V_USU_SO,
                SYSDATE
            );
        END IF;
    END IF;
END;
/