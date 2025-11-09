truque para trabalhar com um usuario diferente, sem trabalhar com os containers do oracle

alter session set "_ORACLE_SCRIPT" = true;

volta para false ao encerrar sessão


criar o usuario 

create user APP identified by APP123 quota UNLIMITED on users;

grant connect, resource to APP;



Importa os dados e configura

CREATE SEQUENCE SEQ_<NOME DA TABELA>_ID NOCACHE;


Criando a tabela de um campo multivalorado

-- TESTES
-- SELECT SEQ_MUNICIPIOS_ID.NEXTVAL AS MUN_ID, DADOS_2.MUNICÍPIO FROM (SELECT DISTINCT MUNICÍPIO FROM DADOS) DADOS_2;
-- ALTER SEQUENCE SEQ_MUNICIPIOS_ID RESTART;


CRATE TABLE EDITORAS AS 
SELECT 
	SEQ_EDT_ID.NEXTVAL AS EDT_ID, 
	DADOS_2.EDITORA 
FROM 
	(SELECT DISTINCT EDITORA 
	FROM DADOS) DADOS_2;

ALTER SEQUENCE SEQ_EDT_ID RESTART;


