--------------------------------------------------------
--  DDL for Sequence SEQ_AUD
--  Sequence para id da tabela de auditoria
--------------------------------------------------------
CREATE SEQUENCE "SEQ_AUD"  
MINVALUE 1 MAXVALUE 9999999999999999999999999999 
INCREMENT BY 1 START WITH 1 
NOCACHE  
NOORDER  
NOCYCLE  
NOKEEP  
NOSCALE  
GLOBAL;

--------------------------------------------------------
--  DDL for Table AUDITORIA
--  Tabela de auditoria
--------------------------------------------------------
CREATE TABLE "AUDITORIA" (
    "AUD_ID" NUMBER(6,0),
    "AUD_TABELA" VARCHAR2(30),
    "AUD_ROWID" VARCHAR2(20),
    "AUD_OPERACAO" CHAR(1),
    "AUD_COLUNA" VARCHAR2(30),
    "AUD_VALOR_ANTIGO" VARCHAR2(255),
    "AUD_VALOR_NOVO" VARCHAR2(255),
    "AUD_USU_BD" VARCHAR2(30),
    "AUD_USU_SO" VARCHAR2(255),
    "AUD_DATA" DATE
);

REM INSERTING into AUDITORIA
SET DEFINE OFF;

--------------------------------------------------------
--  Constraints for Table AUDITORIA
--  Adiciona a constraint de PK na tabela de auditoria
--------------------------------------------------------
ALTER TABLE "AUDITORIA" ADD CONSTRAINT "PK_AUD" PRIMARY KEY ("AUD_ID")
USING INDEX  ENABLE;

--------------------------------------------------------
--  DDL for Trigger TG_SEQ_AUD
--  Trigger para popular o id da tabela de auditoria
--  Sempre que houver uma inserção na tabela de auditoria
--  o id será populado com o próximo valor da sequence
--------------------------------------------------------
CREATE OR REPLACE NONEDITIONABLE TRIGGER "TG_SEQ_AUD" 
BEFORE INSERT ON AUDITORIA
FOR EACH ROW
BEGIN
    :NEW.AUD_ID := SEQ_AUD.NEXTVAL;
END;
/
ALTER TRIGGER "TG_SEQ_AUD" ENABLE;

--------------------------------------------------------
--  DDL for Procedure PROC_AUDITORIA
--  Procedure para inserir registros na tabela de auditoria
--  -
--  Deve ser chamada nas triggers de auditoria quando houver
--  operações de UPDATE ou DELETE nas tabelas que se deseja auditar
--------------------------------------------------------
set define off;

CREATE OR REPLACE NONEDITIONABLE PROCEDURE "PROC_AUDITORIA" (
    P_AUD_TABELA IN VARCHAR,
    P_AUD_ROWID IN VARCHAR,
    P_AUD_OPERACAO IN CHAR,
    P_AUD_COLUNA IN VARCHAR,
    P_AUD_VALOR_ANTIGO IN VARCHAR,
    P_AUD_VALOR_NOVO IN VARCHAR,
    P_AUD_USU_BD IN VARCHAR, 
    P_AUD_USU_SO IN VARCHAR, 
    P_AUD_DATA IN DATE
)
IS
BEGIN
    INSERT INTO AUDITORIA 
    VALUES (
        null,
        P_AUD_TABELA,
        P_AUD_ROWID,
        P_AUD_OPERACAO,
        P_AUD_COLUNA,
        P_AUD_VALOR_ANTIGO,
        P_AUD_VALOR_NOVO,
        P_AUD_USU_BD,
        P_AUD_USU_SO,
        P_AUD_DATA
    );
END;
/
