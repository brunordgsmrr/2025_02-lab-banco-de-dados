-- VIEWS
-- Quantidade de vitimas fatais comparado ao total de acidentes
SELECT * FROM VIEW_ACIDENTES_POR_RODOVIA_CONCESSIONARIA;

-- Impacto das condições climaticas na media de vitimas fatais
SELECT * FROM VIEW_IMPACTO_CLIMA_NA_GRAVIDADE_ACIDENTE;

-- Contagem de veiculos envolvidos em acidentes fatais comparados ao total
SELECT * FROM VIEW_VEICULOS_ACIDENTE_FATAL;

-- Quantidade de acidentes fatais comparados ao total de acidentes por classe e tipo
SELECT * FROM VIEW_ACIDENTES_MAIS_FATAIS;

-- Periodo com maior indice de acidentes
SELECT * FROM VIEW_PERIODO_MAIS_ACIDENTES;

-- Concetração de acidentes por localização, rodovia e tipo de pista
SELECT * FROM VIEW_LOCALIZACOES_COM_MAIS_ACIDENTES;

-- Quantidade de acidentes fatais comparados ao total de acidentes por região  
-- administrativa e DER regional
SELECT * FROM VIEW_ACIDENTES_POR_REGIAO;

-- Media de vitimas por acidentes
SELECT * FROM VIEW_COMBINACAO_COM_MAIS_ACIDENTES;


-- MATERIALIZED VIEWS
-- Porcentagem de acidentes por municipios
SELECT * FROM MVIEW_PORC_ACIDENTES_MUNICIPIOS;

-- Crescimento de acidentes relacionado ao ano atual
SELECT * FROM MVIEW_RANK_CRESC_ACIDENTES_MUNICIPIOS;

-- Porcentagem de acidentes por rodovias
SELECT * FROM MVIEW_RANK_PERC_ACIDENTES_RODOVIAS;

-- Contagem de acidentes por tipo e ano
SELECT * FROM MVIEW_ACIDENTES_TIPO_ANO;

-- Combinação de meteorologia e visibilidade com mais acidentes
SELECT * FROM MVIEW_CLIMAS_COM_MAIS_ACIDENTES_POR_ANO;

-- Contagem de tipos de automogens envolvidos em acidentes 
SELECT * FROM MVIEW_TIPOS_VEICULOS_ACIDENTES_POR_ANO;

--Crescimento de acidentes por ano
SELECT * FROM MVIEW_MAIOR_CRESCIMENTO_ACIDENTES_POR_ANO;

-- Contagem de acidentes por rodovias ao decorrer dos anos
SELECT * FROM MVIEW_ACIDENTES_RODOVIA_POR_ANO;
