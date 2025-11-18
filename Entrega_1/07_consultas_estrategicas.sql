------------------------------------------------------------------------------
-- Consulta o total de acidentes por município, ordenado do maior para o menor
------------------------------------------------------------------------------
SELECT 
    M.MUN_MUNICIPIO AS MUNICIPIO,
    SUM(A.ACD_VIT_SEMINFO_INT) AS "VIT. SEM INFO",
    SUM(A.ACD_VIT_MODERADA_INT) AS "VIT. MODERADA",
    SUM(A.ACD_VIT_LEVE_INT) AS "VIT. LEVE",
    SUM(A.ACD_VIT_GRAVE_INT) AS "VIT. GRAVE",
    SUM(A.ACD_VIT_FATAL_INT) AS "VIT. FATAL",
    COUNT(*) AS TOTAL_ACIDENTES,
    TO_CHAR(
        (COUNT(*) / (SELECT COUNT(*) FROM ACIDENTES)) * 100, 'FM999.0'
    ) || '%' AS PORCENTAGEM
FROM ACIDENTES A
JOIN MUNICIPIOS M ON A.ACD_MUN_ID = M.MUN_ID
GROUP BY M.MUN_MUNICIPIO
ORDER BY TOTAL_ACIDENTES DESC;

------------------------------------------------------------------------------
-- RANKING DAS RODOVIAS COM MAIOR PERCENTUAL DE ACIDENTES
------------------------------------------------------------------------------
SELECT 
    R.ROD_CODIGO_RODOVIA AS RODOVIA,
    COUNT(*) AS TOTAL_ACIDENTES,
    TO_CHAR(
        (COUNT(*) / (SELECT COUNT(*) FROM ACIDENTES)) * 100, 'FM999.0'
    ) || '%' AS PORCENTAGEM
FROM ACIDENTES A
JOIN RODOVIAS R ON A.ACD_ROD_ID = R.ROD_ID
GROUP BY R.ROD_CODIGO_RODOVIA
ORDER BY TOTAL_ACIDENTES DESC; -- DENSE_RANK
