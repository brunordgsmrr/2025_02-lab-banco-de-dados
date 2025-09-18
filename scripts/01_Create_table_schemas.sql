-- Cria tabela: Municípios - OK
-- Cria tabela: Condições climaticas - OK
-- Cria tabela: Concessionarias - OK
-- Cria tabela: Rodovias - OK
-- Cria tabela: Tipos acidentes - OK
-- Cria tabela: Acidentes - OK
-- Cria tabela: Tipos veiculos - OK
-- Cria tabela: Veiculos envolvidos - OK

-- DROP TABLE VEICULOS_ENVOLVIDOS;
-- DROP TABLE ACIDENTES;
-- DROP TABLE TIPOS_VEICULOS;
-- DROP TABLE TIPOS_ACIDENTES;
-- DROP TABLE RODOVIAS;
-- DROP TABLE CONCESSIONARIAS;
-- DROP TABLE CONDICOES_CLIMATICAS;
-- DROP TABLE MUNICIPIOS;

CREATE TABLE MUNICIPIOS (
    mun_id NUMBER (38), 
    mun_municipio VARCHAR(100),
    mun_reg_der VARCHAR(100),
    mun_reg_adm VARCHAR(100),
    PRIMARY KEY (mun_id)
);

CREATE TABLE CONDICOES_CLIMATICAS (
    ccm_id NUMBER (38), 
    ccm_meteoro VARCHAR(100),
    ccm_visib VARCHAR(100),
    PRIMARY KEY (ccm_id)
);

CREATE TABLE CONCESSIONARIAS (
    con_id NUMBER (38), 
    con_concessionaria VARCHAR(100),
    PRIMARY KEY (con_id)
);

CREATE TABLE RODOVIAS (
    rod_id NUMBER (38), 
    rod_rodovias VARCHAR(100),
    rod_denominacao VARCHAR(100),
    rod_jurisdicao VARCHAR(100),
    rod_con_id VARCHAR(100),
    PRIMARY KEY(rod_id),
    FOREIGN KEY(rod_con_id) REFERENCES CONCESSIONARIAS(id)
);

CREATE TABLE TIPOS_ACIDENTES (
    tac_id NUMBER (38), 
    tac_class_acid VARCHAR(100),
    tac_tipo_acid VARCHAR(100),
    PRIMARY KEY(tac_id)
);

CREATE TABLE TIPOS_VEICULOS (
    tvc_id NUMBER (38), 
    tvc_veiculo VARCHAR(100),
    PRIMARY KEY(tvc_id)
);

CREATE TABLE ACIDENTES (
    acd_id NUMBER(38),
    acd_marco_qm NUMBER(38),
    acd_sentido VARCHAR(100),
    acd_dthr_oc DATE,
    acd_ano NUMBER(38),
    acd_mes NUMBER(38),
    acd_ilesa_int NUMBER(38),
    acd_vit_fatal_int NUMBER(38),
    acd_vit_grave_int NUMBER(38),
    acd_vit_leve_int NUMBER(38),
    acd_vit_moderada_int NUMBER(38),
    acd_vit_seminfo_int NUMBER(38),
    acd_tipo_vista VARCHAR(100),
    acd_lat_final NUMBER(38),
    acd_lon_final NUMBER(38),
    acd_rod_id NUMBER(38),
    acd_tac_id NUMBER(38),
    acd_ccm_id NUMBER(38),
    acd_mun_id NUMBER(38),
    PRIMARY KEY(acd_id),
    FOREIGN KEY(acd_rod_id) REFERENCES CONCESSIONARIAS(id),
    FOREIGN KEY(acd_tac_id) REFERENCES TIPOS_ACIDENTES(id),
    FOREIGN KEY(acd_ccm_id) REFERENCES CONDICOES_CLIMATICAS(id),
    FOREIGN KEY(acd_mun_id) REFERENCES MUNICIPIOS(id)
);

CREATE TABLE VEICULOS_ENVOLVIDOS (
    ven_id NUMBER(38),
    ven_qtd NUMBER(38),
    ven_acd_id NUMBER(38),
    ven_tvc_id NUMBER(38),    
    PRIMARY KEY(ven_id),
    FOREIGN KEY(ven_acd_id) REFERENCES CONCESSIONARIAS(id),
    FOREIGN KEY(ven_tvc_id) REFERENCES TIPOS_ACIDENTES(id)
);
