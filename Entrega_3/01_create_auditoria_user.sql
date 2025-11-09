--------------------------------------------------------
--  Configuração do usuário APP
--------------------------------------------------------
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER APP IDENTIFIED BY APP123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO APP;

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
GRANT EXECUTE ON AUDITORIA.PROC_AUDITORIA TO APP;