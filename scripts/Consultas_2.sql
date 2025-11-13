--------------------------------------------------------------------------------
-- 1. Quantidade de acidentes por município e ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT m.mun_municipio,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN municipios m ON a.acd_mun_id = m.mun_id
GROUP BY m.mun_municipio, A.ACD_ANO

UNION ALL

SELECT m.mun_municipio,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN municipios m ON ha.h_acd_mun_id = m.mun_id
GROUP BY m.mun_municipio, HA.H_ACD_ANO

ORDER BY mun_municipio, ano, periodo;


--------------------------------------------------------------------------------
-- 2. Tipos de acidentes mais comuns por ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT ta.tac_tipo_acid AS tipo_acidente,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN tipos_acidentes ta ON a.acd_tac_id = ta.tac_id
GROUP BY ta.tac_tipo_acid, A.ACD_ANO

UNION ALL

SELECT ta.tac_tipo_acid AS tipo_acidente,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN tipos_acidentes ta ON ha.h_acd_tac_id = ta.tac_id
GROUP BY ta.tac_tipo_acid, HA.H_ACD_ANO

ORDER BY total DESC;

--------------------------------------------------------------------------------
-- 3. Acidentes por rodovia e ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT r.rod_codigo_rodovia,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN rodovias r ON a.acd_rod_id = r.rod_id
GROUP BY r.rod_codigo_rodovia, A.ACD_ANO

UNION ALL

SELECT r.rod_codigo_rodovia,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN rodovias r ON ha.h_acd_rod_id = r.rod_id
GROUP BY r.rod_codigo_rodovia, HA.H_ACD_ANO

ORDER BY rod_codigo_rodovia, ano, periodo;

--------------------------------------------------------------------------------
-- 4. Acidentes por concessionária e ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT c.con_concessionaria,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN rodovias r ON a.acd_rod_id = r.rod_id
JOIN concessionarias c ON r.rod_con_id = c.con_id
GROUP BY c.con_concessionaria, A.ACD_ANO

UNION ALL

SELECT c.con_concessionaria,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN rodovias r ON ha.h_acd_rod_id = r.rod_id
JOIN concessionarias c ON r.rod_con_id = c.con_id
GROUP BY c.con_concessionaria, HA.H_ACD_ANO

ORDER BY con_concessionaria, ano, periodo;

--------------------------------------------------------------------------------
-- 5. Condições climáticas mais associadas a acidentes por ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT cc.ccm_meteoro || ' / ' || cc.ccm_visib AS condicao_climatica,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN condicoes_climaticas cc ON a.acd_ccm_id = cc.ccm_id
GROUP BY cc.ccm_meteoro, cc.ccm_visib, A.ACD_ANO

UNION ALL

SELECT cc.ccm_meteoro || ' / ' || cc.ccm_visib AS condicao_climatica,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN condicoes_climaticas cc ON ha.h_acd_ccm_id = cc.ccm_id
GROUP BY cc.ccm_meteoro, cc.ccm_visib, HA.H_ACD_ANO

ORDER BY condicao_climatica, ano, periodo;

--------------------------------------------------------------------------------
-- 6. Veículos envolvidos em acidentes por ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT tv.tvc_veiculo,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(ve.ven_id) AS total
FROM veiculos_envolvidos ve
JOIN tipos_veiculos tv ON ve.ven_tvc_id = tv.tvc_id
JOIN acidentes a ON ve.ven_acd_id = a.acd_id
GROUP BY tv.tvc_veiculo, A.ACD_ANO

UNION ALL

SELECT tv.tvc_veiculo,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(hve.h_ven_id) AS total
FROM h_veiculos_envolvidos hve
JOIN tipos_veiculos tv ON hve.h_ven_tvc_id = tv.tvc_id
JOIN h_acidentes ha ON hve.h_ven_acd_id = ha.h_acd_id
GROUP BY tv.tvc_veiculo, HA.H_ACD_ANO

ORDER BY tvc_veiculo, ano, periodo;

--------------------------------------------------------------------------------
-- 7. Ranking dos municípios com maior crescimento de acidentes por ano
--------------------------------------------------------------------------------
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
               A.ACD_ANO AS ano,
               'Atual' AS periodo,
               COUNT(a.acd_id) AS total
        FROM acidentes a
        JOIN municipios m ON a.acd_mun_id = m.mun_id
        GROUP BY m.mun_municipio, A.ACD_ANO

        UNION ALL

        SELECT m.mun_municipio AS nome_municipio,
               HA.H_ACD_ANO AS ano,
               'Histórico' AS periodo,
               COUNT(ha.h_acd_id) AS total
        FROM h_acidentes ha
        JOIN municipios m ON ha.h_acd_mun_id = m.mun_id
        GROUP BY m.mun_municipio, HA.H_ACD_ANO
    )
    GROUP BY nome_municipio, ano
)
ORDER BY ano, ranking;

--------------------------------------------------------------------------------
-- 8. Acidentes por município e rodovia por ano (atual x histórico)
--------------------------------------------------------------------------------
SELECT m.mun_municipio,
       r.rod_codigo_rodovia,
       A.ACD_ANO AS ano,
       'Atual' AS periodo,
       COUNT(a.acd_id) AS total
FROM acidentes a
JOIN municipios m ON a.acd_mun_id = m.mun_id
JOIN rodovias r ON a.acd_rod_id = r.rod_id
GROUP BY m.mun_municipio, r.rod_codigo_rodovia, A.ACD_ANO

UNION ALL

SELECT m.mun_municipio,
       r.rod_codigo_rodovia,
       HA.H_ACD_ANO AS ano,
       'Histórico' AS periodo,
       COUNT(ha.h_acd_id) AS total
FROM h_acidentes ha
JOIN municipios m ON ha.h_acd_mun_id = m.mun_id
JOIN rodovias r ON ha.h_acd_rod_id = r.rod_id
GROUP BY m.mun_municipio, r.rod_codigo_rodovia, HA.H_ACD_ANO

ORDER BY mun_municipio, rod_codigo_rodovia, ano, periodo;

