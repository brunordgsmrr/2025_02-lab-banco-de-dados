-- View 1 - Porcentagem de acidentes por município
CREATE MATERIALIZED VIEW MVIEW_PORC_ACIDENTES_MUNICIPIOS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT 
    M.MUN_MUNICIPIO AS MUNICIPIO,
    SUM(A.ACD_VIT_SEMINFO_INT) AS "VIT. SEM INFO",
    SUM(A.ACD_VIT_MODERADA_INT) AS "VIT. MODERADA",
    SUM(A.ACD_VIT_LEVE_INT) AS "VIT. LEVE",
    SUM(A.ACD_VIT_GRAVE_INT) AS "VIT. GRAVE",
    SUM(A.ACD_VIT_FATAL_INT) AS "VIT. FATAL",
    COUNT(*) AS TOTAL_ACIDENTES,
    TO_CHAR(
        (COUNT(*) / (SELECT COUNT(*) FROM APP.ACIDENTES)) * 100, 'FM999.0'
    ) || '%' AS PORCENTAGEM
FROM APP.ACIDENTES A
JOIN APP.MUNICIPIOS M ON A.ACD_MUN_ID = M.MUN_ID
GROUP BY M.MUN_MUNICIPIO
ORDER BY TOTAL_ACIDENTES DESC;

-- View 2 - Ranking de crescimento de acidentes por município
CREATE MATERIALIZED VIEW MVIEW_RANK_CRESC_ACIDENTES_MUNICIPIOS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT nome_municipio,
       ano,
       crescimento,
       DENSE_RANK() OVER (PARTITION BY ano ORDER BY crescimento DESC) AS ranking
FROM (
    SELECT nome_municipio,
           ano,
           NVL(SUM(CASE WHEN periodo = 'Atual' THEN total END),0) -
           NVL(SUM(CASE WHEN periodo = 'Histórico' THEN total END),0) AS crescimento
    FROM (
        SELECT m.mun_municipio AS nome_municipio,
               EXTRACT(YEAR FROM a.acd_dthr_oc) AS ano,
               'Atual' AS periodo,
               COUNT(a.acd_id) AS total
        FROM acidentes a
        JOIN municipios m ON a.acd_mun_id = m.mun_id
        GROUP BY m.mun_municipio, EXTRACT(YEAR FROM a.acd_dthr_oc)

        UNION ALL

        SELECT m.mun_municipio AS nome_municipio,
               EXTRACT(YEAR FROM ha.old_acd_dthr_oc) AS ano,
               'Histórico' AS periodo,
               COUNT(ha.old_acd_id) AS total
        FROM h_acidentes ha
        JOIN municipios m ON ha.old_acd_mun_id = m.mun_id
        GROUP BY m.mun_municipio, EXTRACT(YEAR FROM ha.old_acd_dthr_oc)
    )
    GROUP BY nome_municipio, ano
)
ORDER BY ano, ranking;

-- View 3 - Ranking das rodovias com maior percentual de acidentes
CREATE MATERIALIZED VIEW MVIEW_RANK_PERC_ACIDENTES_RODOVIAS
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS
SELECT
    RODOVIA,
    TOTAL_ACIDENTES,
    PORCENTAGEM,
    DENSE_RANK() OVER (ORDER BY TOTAL_ACIDENTES DESC) AS RANKING
FROM (
    SELECT 
        R.ROD_CODIGO_RODOVIA AS RODOVIA,
        COUNT(*) AS TOTAL_ACIDENTES,
        TO_CHAR(
            (COUNT(*) / (SELECT COUNT(*) FROM ACIDENTES)) * 100,
            'FM999.0'
        ) || '%' AS PORCENTAGEM
    FROM ACIDENTES A
    JOIN RODOVIAS R ON A.ACD_ROD_ID = R.ROD_ID
    GROUP BY R.ROD_CODIGO_RODOVIA
)
ORDER BY TOTAL_ACIDENTES DESC;
