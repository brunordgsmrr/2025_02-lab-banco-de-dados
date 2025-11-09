--------------------------------------------------------
--  Script para teste de Auditoria
--  Arquivo criado - Sexta-feira-Maio-19-2023
--------------------------------------------------------

--------------------------------------------------------
--  DDL for Sequence SEQ_TESTE
--------------------------------------------------------
CREATE SEQUENCE "SEQ_TESTE"
MINVALUE 1 MAXVALUE 9999999999999999999999999999
INCREMENT BY 1 START WITH 1
NOCACHE
NOORDER
NOCYCLE
NOKEEP
NOSCALE
GLOBAL;

--------------------------------------------------------
--  DDL for Table HTESTE
--------------------------------------------------------
CREATE TABLE "HTESTE" (
    "TESTE_ID" NUMBER(6,0), 
    "TESTE_NOME" VARCHAR2(100), 
    "TESTE_DATA_HIST" DATE
);

--------------------------------------------------------
--  DDL for Table TESTE
--------------------------------------------------------
CREATE TABLE "TESTE" (
    "TESTE_ID" NUMBER(6,0),
    "TESTE_NOME" VARCHAR2(100)
);

--------------------------------------------------------
--  Comandos para criar comentarios na linha de comando SQL*Plus
--------------------------------------------------------
REM INSERTING into HTESTE
SET DEFINE OFF;
REM INSERTING into TESTE
SET DEFINE OFF;

--------------------------------------------------------
--  DDL for Trigger TG_AUD_TESTE
--------------------------------------------------------
CREATE OR REPLACE NONEDITIONABLE TRIGGER "TG_AUD_TESTE" 
AFTER UPDATE OR DELETE ON HTESTE
FOR EACH ROW
DECLARE
    V_USU_BD VARCHAR2(30);
    V_USU_SO VARCHAR2(255) := SYS_CONTEXT('USERENV','OS_USER');
    V_TP_OPERACAO CHAR(1);
    V_ROWID VARCHAR2(20);
    V_TABELA VARCHAR2(30) := 'HTESTE';
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
ALTER TRIGGER "TG_AUD_TESTE" ENABLE;