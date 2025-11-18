--------------------------------------------------------
--  Configuração do usuário APP
--------------------------------------------------------
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER APP IDENTIFIED BY APP123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO APP;