--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: MUNICIPIOS
--------------------------------------------------------------------------------
COMMENT ON TABLE MUNICIPIOS IS 'Armazena informações sobre os municípios onde os acidentes ocorreram.';

COMMENT ON COLUMN MUNICIPIOS.MUN_ID IS 'Identificador único do município.';
COMMENT ON COLUMN MUNICIPIOS.MUN_MUNICIPIO IS 'Nome do município.';
COMMENT ON COLUMN MUNICIPIOS.MUN_REG_DER IS 'Região do DER (Departamento de Estradas de Rodagem) a que o município pertence.';
COMMENT ON COLUMN MUNICIPIOS.MUN_REG_ADM IS 'Região Administrativa a que o município pertence.';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: CONDICOES_CLIMATICAS
--------------------------------------------------------------------------------
COMMENT ON TABLE CONDICOES_CLIMATICAS IS 'Armazena as diferentes condições climáticas e de visibilidade no momento do acidente.';

COMMENT ON COLUMN CONDICOES_CLIMATICAS.CCM_ID IS 'Identificador único da condição climática.';
COMMENT ON COLUMN CONDICOES_CLIMATICAS.CCM_METEORO IS 'Tipo de condição meteorológica (ex: Chuva, Sol, Neblina).';
COMMENT ON COLUMN CONDICOES_CLIMATICAS.CCM_VISIB IS 'Condição de visibilidade na pista (ex: Boa, Reduzida).';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: CONCESSIONARIAS
--------------------------------------------------------------------------------
COMMENT ON TABLE CONCESSIONARIAS IS 'Armazena os nomes das concessionárias responsáveis pelas rodovias.';

COMMENT ON COLUMN CONCESSIONARIAS.CON_ID IS 'Identificador único da concessionária.';
COMMENT ON COLUMN CONCESSIONARIAS.CON_CONCESSIONARIA IS 'Nome da concessionária de rodovia.';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: RODOVIAS
--------------------------------------------------------------------------------
COMMENT ON TABLE RODOVIAS IS 'Armazena informações sobre as rodovias envolvidas nos acidentes.';

COMMENT ON COLUMN RODOVIAS.ROD_ID IS 'Identificador único da rodovia.';
COMMENT ON COLUMN RODOVIAS.ROD_CODIGO_RODOVIA IS 'Código/Sigla da rodovia (ex: SP-310).';
COMMENT ON COLUMN RODOVIAS.ROD_DENOMINACAO IS 'Nome de denominação da rodovia.';
COMMENT ON COLUMN RODOVIAS.ROD_JURISDICAO IS 'Órgão de jurisdição da rodovia (ex: Estadual, Federal).';
COMMENT ON COLUMN RODOVIAS.ROD_CON_ID IS 'Chave Estrangeira para a tabela CONCESSIONARIAS.';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: TIPOS_ACIDENTES
--------------------------------------------------------------------------------
COMMENT ON TABLE TIPOS_ACIDENTES IS 'Armazena a classificação e o tipo detalhado do acidente.';

COMMENT ON COLUMN TIPOS_ACIDENTES.TAC_ID IS 'Identificador único do tipo de acidente.';
COMMENT ON COLUMN TIPOS_ACIDENTES.TAC_CLASS_ACID IS 'Classificação geral do acidente (ex: Colisão, Atropelamento).';
COMMENT ON COLUMN TIPOS_ACIDENTES.TAC_TIPO_ACID IS 'Tipo detalhado do acidente (ex: Colisão Frontal, Saída de Pista).';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: TIPOS_VEICULOS
--------------------------------------------------------------------------------
COMMENT ON TABLE TIPOS_VEICULOS IS 'Armazena os diferentes tipos de veículos envolvidos nos acidentes.';

COMMENT ON COLUMN TIPOS_VEICULOS.TVC_ID IS 'Identificador único do tipo de veículo.';
COMMENT ON COLUMN TIPOS_VEICULOS.TVC_VEICULO IS 'Descrição do tipo de veículo (ex: Automóvel, Caminhão, Motocicleta).';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: ACIDENTES
--------------------------------------------------------------------------------
COMMENT ON TABLE ACIDENTES IS 'Armazena os detalhes e as estatísticas de cada acidente registrado.';

COMMENT ON COLUMN ACIDENTES.ACD_ID IS 'Identificador único do acidente.';
COMMENT ON COLUMN ACIDENTES.ACD_MARCO_QM IS 'Quilômetro do marco referencial onde o acidente ocorreu.';
COMMENT ON COLUMN ACIDENTES.ACD_SENTIDO IS 'Sentido da via no momento do acidente.';
COMMENT ON COLUMN ACIDENTES.ACD_DTHR_OC IS 'Data e hora da ocorrência do acidente.';
COMMENT ON COLUMN ACIDENTES.ACD_ANO IS 'Ano da ocorrência (redundante, mas útil para consultas).';
COMMENT ON COLUMN ACIDENTES.ACD_MES IS 'Mês da ocorrência (redundante, mas útil para consultas).';
COMMENT ON COLUMN ACIDENTES.ACD_ILESA_INT IS 'Quantidade de vítimas ilesas.';
COMMENT ON COLUMN ACIDENTES.ACD_VIT_FATAL_INT IS 'Quantidade de vítimas fatais.';
COMMENT ON COLUMN ACIDENTES.ACD_VIT_GRAVE_INT IS 'Quantidade de vítimas graves.';
COMMENT ON COLUMN ACIDENTES.ACD_VIT_LEVE_INT IS 'Quantidade de vítimas leves.';
COMMENT ON COLUMN ACIDENTES.ACD_VIT_MODERADA_INT IS 'Quantidade de vítimas moderadas.';
COMMENT ON COLUMN ACIDENTES.ACD_VIT_SEMINFO_INT IS 'Quantidade de vítimas sem informação de lesão.';
COMMENT ON COLUMN ACIDENTES.ACD_TIPO_PISTA IS 'Tipo de pista (ex: Simples, Dupla).';
COMMENT ON COLUMN ACIDENTES.ACD_LAT_FINAL IS 'Latitude final da localização do acidente.';
COMMENT ON COLUMN ACIDENTES.ACD_LON_FINAL IS 'Longitude final da localização do acidente.';
COMMENT ON COLUMN ACIDENTES.ACD_ROD_ID IS 'Chave Estrangeira para a tabela RODOVIAS.';
COMMENT ON COLUMN ACIDENTES.ACD_TAC_ID IS 'Chave Estrangeira para a tabela TIPOS_ACIDENTES.';
COMMENT ON COLUMN ACIDENTES.ACD_CCM_ID IS 'Chave Estrangeira para a tabela CONDICOES_CLIMATICAS.';
COMMENT ON COLUMN ACIDENTES.ACD_MUN_ID IS 'Chave Estrangeira para a tabela MUNICIPIOS.';

---

--------------------------------------------------------------------------------
-- COMENTÁRIOS PARA A TABELA: VEICULOS_ENVOLVIDOS
--------------------------------------------------------------------------------
COMMENT ON TABLE VEICULOS_ENVOLVIDOS IS 'Tabela de relacionamento que detalha os tipos e quantidades de veículos envolvidos em cada acidente.';

COMMENT ON COLUMN VEICULOS_ENVOLVIDOS.VEN_ID IS 'Identificador único do registro de veículo envolvido.';
COMMENT ON COLUMN VEICULOS_ENVOLVIDOS.VEN_QTD IS 'Quantidade de veículos desse tipo envolvidos no acidente.';
COMMENT ON COLUMN VEICULOS_ENVOLVIDOS.VEN_ACD_ID IS 'Chave Estrangeira para a tabela ACIDENTES.';
COMMENT ON COLUMN VEICULOS_ENVOLVIDOS.VEN_TVC_ID IS 'Chave Estrangeira para a tabela TIPOS_VEICULOS.';