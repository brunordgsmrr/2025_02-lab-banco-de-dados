--------------------------------------------------------
--  Configuração do usuário AUDITORIA
--------------------------------------------------------
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER AUDITORIA IDENTIFIED BY 123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO AUDITORIA;

--------------------------------------------------------
--  Garantir permissão de execução da procedure de auditoria
--------------------------------------------------------
GRANT CREATE ANY TRIGGER TO AUDITORIA;
GRANT CREATE ANY PROCEDURE TO AUDITORIA;
GRANT EXECUTE ANY PROCEDURE TO AUDITORIA;