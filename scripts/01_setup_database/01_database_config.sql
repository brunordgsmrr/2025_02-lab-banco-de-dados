--------------------------------------------------------
--  Objetivo: Configuração do banco de dados
--  Descrição: Esse script, configurará os usuários e suas 
--  permissões
--  Requisitos: Usuário com privilégios de DBA
--------------------------------------------------------

ALTER SESSION SET "_ORACLE_SCRIPT" = true; -- Necessário para criação de usuários no Oracle 18c ou superior

--------------------------------------------------------
--  Configuração do usuário APP
--------------------------------------------------------
CREATE USER APP IDENTIFIED BY APP123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO APP;

--------------------------------------------------------
--  Configuração do usuário AUDITORIA
--------------------------------------------------------
CREATE USER AUDITORIA IDENTIFIED BY 123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO AUDITORIA;

