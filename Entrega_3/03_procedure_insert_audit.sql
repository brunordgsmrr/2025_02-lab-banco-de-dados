--------------------------------------------------------
--  DDL for Procedure PROC_AUDITORIA
--  Procedure para inserir registros na tabela de auditoria
--  -
--  Deve ser chamada nas triggers de auditoria quando houver
--  operações de UPDATE ou DELETE nas tabelas que se deseja auditar
--------------------------------------------------------
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