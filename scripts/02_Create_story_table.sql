-- DROP TABLE H_VEICULOS_ENVOLVIDOS;
-- DROP TABLE H_ACIDENTES;
-- DROP TABLE H_TIPOS_VEICULOS;
-- DROP TABLE H_TIPOS_ACIDENTES;
-- DROP TABLE H_RODOVIAS;
-- DROP TABLE H_CONCESSIONARIAS;
-- DROP TABLE H_CONDICOES_CLIMATICAS;
-- DROP TABLE H_MUNICIPIOS;

CREATE TABLE H_MUNICIPIOS (
    old_mun_id NUMBER (38), 
    old_mun_municipio VARCHAR(100),
    old_mun_reg_der VARCHAR(100),
    old_mun_reg_adm VARCHAR(100)
);

CREATE TABLE H_CONDICOES_CLIMATICAS (
    old_ccm_id NUMBER (38), 
    old_ccm_meteoro VARCHAR(100),
    old_ccm_visib VARCHAR(100)
);

CREATE TABLE H_CONCESSIONARIAS (
    old_con_id NUMBER (38), 
    old_con_concessionaria VARCHAR(100)
);

CREATE TABLE H_RODOVIAS (
    old_rod_id NUMBER (38), 
    old_rod_rodovias VARCHAR(100),
    old_rod_denominacao VARCHAR(100),
    old_rod_jurisdicao VARCHAR(100),
    old_rod_con_id VARCHAR(100)
);

CREATE TABLE H_TIPOS_ACIDENTES (
    old_tac_id NUMBER (38), 
    old_tac_class_acid VARCHAR(100),
    old_tac_tipo_acid VARCHAR(100)
);

CREATE TABLE H_TIPOS_VEICULOS (
    old_tvc_id NUMBER (38), 
    old_tvc_veiculo VARCHAR(100)
);

CREATE TABLE H_ACIDENTES (
    old_acd_id NUMBER(38),
    old_acd_marco_qm NUMBER(38),
    old_acd_sentido VARCHAR(100),
    old_acd_dthr_oc DATE,
    old_acd_ano NUMBER(38),
    old_acd_mes NUMBER(38),
    old_acd_ilesa_int NUMBER(38),
    old_acd_vit_fatal_int NUMBER(38),
    old_acd_vit_grave_int NUMBER(38),
    old_acd_vit_leve_int NUMBER(38),
    old_acd_vit_moderada_int NUMBER(38),
    old_acd_vit_seminfo_int NUMBER(38),
    old_acd_tipo_vista VARCHAR(100),
    old_acd_lat_final NUMBER(38),
    old_acd_lon_final NUMBER(38),
    old_acd_rod_id NUMBER(38),
    old_acd_tac_id NUMBER(38),
    old_acd_ccm_id NUMBER(38),
    old_acd_mun_id NUMBER(38)
);

CREATE TABLE H_VEICULOS_ENVOLVIDOS (
    old_ven_id NUMBER(38),
    old_ven_qtd NUMBER(38),
    old_ven_acd_id NUMBER(38),
    old_ven_tvc_id NUMBER(38)
);
