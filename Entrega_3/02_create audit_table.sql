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

--------------------------------------------------------
--  Constraints for Table AUDITORIA
--  Adiciona a constraint de PK na tabela de auditoria
--------------------------------------------------------
ALTER TABLE "AUDITORIA" ADD CONSTRAINT "PK_AUD" PRIMARY KEY ("AUD_ID")
USING INDEX  ENABLE;