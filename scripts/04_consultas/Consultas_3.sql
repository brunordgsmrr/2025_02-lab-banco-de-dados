-- 1) PERFIL DE RISCO POR CONCESSIONÁRIA E RODOVIA
-- Identificar quais Concessionárias e Rodovias apresentam a 
-- maior taxa de acidentes e a maior gravidade (medida pelo 
-- número total de vítimas fatais)
SELECT
    C.CON_CONCESSIONARIA,
    R.ROD_CODIGO_RODOVIA,
    COUNT(A.ACD_ID) AS Total_Acidentes,
    SUM(A.ACD_VIT_FATAL_INT) AS Total_Mortes
FROM ACIDENTES A
JOIN RODOVIAS R ON A.ACD_ROD_ID = R.ROD_ID
JOIN CONCESSIONARIAS C ON R.ROD_CON_ID = C.CON_ID
GROUP BY C.CON_CONCESSIONARIA, R.ROD_CODIGO_RODOVIA
ORDER BY Total_Mortes DESC, Total_Acidentes DESC;

-- 2) IMPACTO DAS CONDIÇÕES CLIMÁTICAS NA GRAVIDADE
-- Determinar sob quais condições climáticas (Meteorologia e 
-- Visibilidade) os acidentes são mais frequentes ou mais 
-- graves (maior proporção de vítimas graves/fatais por acidente).
SELECT
    CC.CCM_METEORO,
    CC.CCM_VISIB,
    COUNT(A.ACD_ID) AS Total_Acidentes,
    ROUND(AVG(A.ACD_VIT_FATAL_INT + A.ACD_VIT_GRAVE_INT), 2) AS Media_Vitimas_Graves_Fatais
FROM ACIDENTES A
JOIN CONDICOES_CLIMATICAS CC ON A.ACD_CCM_ID = CC.CCM_ID
GROUP BY CC.CCM_METEORO, CC.CCM_VISIB
ORDER BY Media_Vitimas_Graves_Fatais DESC;


-- 3)TOPOLOGIA DE ACIDENTES POR TIPO DE VEÍCULO
-- Descobrir quais tipos de veículos (TVC_VEICULO) estão mais 
-- envolvidos em acidentes com alta gravidade.
SELECT
    TV.TVC_VEICULO,
    SUM(VE.VEN_QTD) AS Total_Veiculos_Envolvidos,
    SUM(CASE WHEN A.ACD_VIT_FATAL_INT > 0 THEN VE.VEN_QTD ELSE 0 END) AS Veiculos_Em_Acidentes_Fatais
FROM VEICULOS_ENVOLVIDOS VE
JOIN TIPOS_VEICULOS TV ON VE.VEN_TVC_ID = TV.TVC_ID
JOIN ACIDENTES A ON VE.VEN_ACD_ID = A.ACD_ID
GROUP BY TV.TVC_VEICULO
ORDER BY Veiculos_Em_Acidentes_Fatais DESC;


-- 4) CLASSIFICAÇÃO DOS ACIDENTES MAIS COMUNS E MORTAIS
-- Mapear a relação entre a Classificação do Acidente (TAC_CLASS_ACID) e o 
-- Tipo de Acidente (TAC_TIPO_ACID) com a ocorrência e a letalidade.
SELECT
    TA.TAC_CLASS_ACID,
    TA.TAC_TIPO_ACID,
    COUNT(A.ACD_ID) AS Total_Acidentes,
    SUM(A.ACD_VIT_FATAL_INT) AS Total_Fatais
FROM ACIDENTES A
JOIN TIPOS_ACIDENTES TA ON A.ACD_TAC_ID = TA.TAC_ID
GROUP BY TA.TAC_CLASS_ACID, TA.TAC_TIPO_ACID
ORDER BY Total_Fatais DESC, Total_Acidentes DESC;


-- 5) PICOS TEMPORAIS (SAZONALIDADE E HORÁRIO)
-- Identificar padrões de sazonalidade (Mês e Ano) e picos de ocorrência 
-- (Hora, extraída do ACD_DTHR_OC) para alocar recursos de resgate e 
-- policiamento de forma preditiva.
SELECT
    EXTRACT(HOUR FROM ACD_DTHR_OC) AS Hora_Dia,
    ACD_MES,
    COUNT(ACD_ID) AS Total_Acidentes
FROM ACIDENTES
GROUP BY EXTRACT(HOUR FROM ACD_DTHR_OC), ACD_MES
ORDER BY Total_Acidentes DESC;


-- 6) PONTOS CRÍTICOS (HOTSPOTS) POR QUILOMETRAGEM
-- Encontrar os marcos quilométricos (ACD_MARCO_QM) dentro de cada Rodovia 
-- que concentram o maior número de acidentes.
SELECT
    R.ROD_CODIGO_RODOVIA,
    A.ACD_MARCO_QM,
    A.ACD_TIPO_PISTA, -- Incluir o tipo de pista (simples/dupla) como contexto
    COUNT(A.ACD_ID) AS Concentracao_Acidentes
FROM ACIDENTES A
JOIN RODOVIAS R ON A.ACD_ROD_ID = R.ROD_ID
GROUP BY R.ROD_CODIGO_RODOVIA, A.ACD_MARCO_QM, A.ACD_TIPO_PISTA
HAVING COUNT(A.ACD_ID) > 5 -- Filtro para mostrar apenas hotspots (ajustável)
ORDER BY Concentracao_Acidentes DESC;


-- 7) RISCO GEOGRÁFICO: MUNICÍPIOS E REGIONAL ADMINISTRATIVA
-- Comparar a performance das Regionais Administrativas e DER em termos de 
-- volume de acidentes e gravidade.
SELECT
    M.MUN_REG_ADM,
    M.MUN_REG_DER,
    COUNT(A.ACD_ID) AS Acidentes_na_Regional,
    SUM(A.ACD_VIT_FATAL_INT) AS Total_Mortes
FROM ACIDENTES A
JOIN MUNICIPIOS M ON A.ACD_MUN_ID = M.MUN_ID
GROUP BY M.MUN_REG_ADM, M.MUN_REG_DER
ORDER BY Total_Mortes DESC;

-- 8) Cenários de Alto Risco (Condição + Tipo de Acidente + Pista)
-- Esta análise combina o Tipo de Pista (ACD_TIPO_PISTA), o Tipo de Acidente 
-- (TAC_TIPO_ACID) e a Condição Climática (CCM_METEORO) para isolar as 
-- combinações de fatores que resultam na maior taxa de vítimas.
SELECT
    A.ACD_TIPO_PISTA,
    TA.TAC_TIPO_ACID,
    CC.CCM_METEORO,
    COUNT(A.ACD_ID) AS Total_Acidentes,
    -- Calcular a média de vítimas (total) por acidente neste cenário
    ROUND(AVG(
        A.ACD_ILESA_INT + 
        A.ACD_VIT_FATAL_INT + 
        A.ACD_VIT_GRAVE_INT + 
        A.ACD_VIT_LEVE_INT + 
        A.ACD_VIT_MODERADA_INT + 
        A.ACD_VIT_SEMINFO_INT
    ), 2) AS Media_Vitimas_Por_Acidente
FROM ACIDENTES A
JOIN TIPOS_ACIDENTES TA ON A.ACD_TAC_ID = TA.TAC_ID
JOIN CONDICOES_CLIMATICAS CC ON A.ACD_CCM_ID = CC.CCM_ID
GROUP BY A.ACD_TIPO_PISTA, TA.TAC_TIPO_ACID, CC.CCM_METEORO
HAVING COUNT(A.ACD_ID) >= 10 -- Filtrar combinações com ocorrência mínima para relevância estatística (ajustável)
ORDER BY Media_Vitimas_Por_Acidente DESC;
