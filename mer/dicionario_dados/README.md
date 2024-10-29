# Modelo de Banco de Dados Agrícola

## Dicionário de Dados

### Tabela: `T_PAB_PAIS`

| Tabela (ENTIDADE)  | `T_PAB_PAIS`                                                                                      |
|--------------------|--------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre os países associados às regiões e estados/províncias no sistema.       |
| **Volume esperado**| Carga inicial de 1 registro (Brasil), com crescimento conforme novos países sejam adicionados.    |
| **Tempo de retenção** | Permanente.                                                                                   |
| **Rotina de limpeza** | Não se aplica.                                                                                |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_pais`               | INTEGER           | 5         | PK                 | Identificador único do país.                    |
| `nm_pais`               | VARCHAR2          | 100       | NN, UN             | Nome completo do país.                          |
| `cd_sigla_pais`         | CHAR              | 3         | NN                 | Sigla do país conforme padrão ISO.              |

---

### Tabela: `T_PAB_REGIAO`

| Tabela (ENTIDADE)  | `T_PAB_REGIAO`                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre as regiões associadas aos estados/províncias no sistema.                |
| **Volume esperado**| Carga inicial de 5 registros, com crescimento conforme novos países e regiões sejam adicionados.   |
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_regiao`             | INTEGER           | 5         | PK                 | Identificador único da região.                  |
| `nm_regiao`             | VARCHAR2          | 100       | NN, UN             | Nome da região (e.g., Norte, Sudeste).         |
| `ds_regiao`             | VARCHAR2          | 255       |                    | Descrição adicional da região.                 |
| `cd_pais`               | INTEGER           | 5         | NN, FK             | Código do país ao qual a região pertence.      |

---

### Tabela: `T_PAB_ESTADO`

| Tabela (ENTIDADE)  | `T_PAB_ESTADO`                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre estados ou províncias de diversos países.                               |
| **Volume esperado**| Carga inicial de 50 registros, com crescimento conforme novos estados/províncias sejam adicionados.|
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_estado`             | INTEGER           | 5         | PK                 | Identificador único do estado/província.        |
| `nm_estado`             | VARCHAR2          | 100       | NN                 | Nome completo do estado/província.              |
| `cd_sigla_estado`       | CHAR              | 5         | NN, UN (por país)  | Sigla do estado, variando entre 2 e 5 caracteres.|
| `cd_regiao`             | INTEGER           | 5         | NN, FK             | Código da região associada ao estado.           |

---

### Tabela: `T_PAB_SAFRA`

| Tabela (ENTIDADE)  | `T_PAB_SAFRA`                                                                                      |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre as safras agrícolas registradas no sistema, que podem ocorrer globalmente.|
| **Volume esperado**| Carga inicial de 10 registros, com crescimento anual conforme novas safras são registradas.        |
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_safra`              | INTEGER           | 5         | PK                 | Identificador único da safra.                   |
| `nr_safra`              | NUMERIC           | 4         | NN, CK             | Ano referente à safra (e.g., 2024). Deve estar entre 1900 e 2100.|
| `ds_safra`              | VARCHAR2          | 100       |                    | Descrição da safra, se aplicável.               |

---

### Tabela: `T_PAB_TIPOCULTURA`

| Tabela (ENTIDADE)  | `T_PAB_TIPOCULTURA`                                                                                |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre os tipos de culturas agrícolas disponíveis globalmente no sistema.      |
| **Volume esperado**| Carga inicial de 20 registros, com crescimento anual conforme novas culturas são adicionadas.      |
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_tipocultura`        | INTEGER           | 5         | PK                 | Identificador único do tipo de cultura.         |
| `nm_tipocultura`        | VARCHAR2          | 100       | NN, UN             | Nome do tipo de cultura (e.g., grãos).         |
| `ds_tipocultura`        | VARCHAR2          | 255       |                    | Descrição detalhada do tipo de cultura.         |

---

### Tabela: `T_PAB_CULTURA`

| Tabela (ENTIDADE)  | `T_PAB_CULTURA`                                                                                     |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações sobre as culturas agrícolas específicas registradas globalmente no sistema.   |
| **Volume esperado**| Carga inicial de 50 registros, com crescimento anual de até 5 novas culturas.                      |
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_cultura`            | INTEGER           | 5         | PK                 | Identificador único da cultura agrícola.        |
| `nm_cultura`            | VARCHAR2          | 100       | NN, UN             | Nome da cultura agrícola (e.g., milho, soja).   |
| `ds_cultura`            | VARCHAR2          | 255       |                    | Descrição detalhada da cultura agrícola.        |
| `cd_tipocultura`        | INTEGER           | 5         | NN, FK             | Identificador do tipo de cultura associada.      |

---

### Tabela: `T_PAB_PRODUCAO`

| Tabela (ENTIDADE)  | `T_PAB_PRODUCAO`                                                                                   |
|--------------------|---------------------------------------------------------------------------------------------------|
| **Descrição**      | Armazena informações detalhadas sobre a produção agrícola por estado/província, safra e cultura.  |
| **Volume esperado**| Carga inicial com aproximadamente 1000 registros, com crescimento conforme novas produções sejam registradas.|
| **Tempo de retenção** | Permanente.                                                                                    |
| **Rotina de limpeza** | Não se aplica.                                                                                 |

| Coluna/campo (atributos) | Tipo de Dados     | Tamanho   | Constraint         | Descrição                                      |
|--------------------------|-------------------|-----------|--------------------|------------------------------------------------|
| `cd_producao`           | INTEGER           | 10        | PK                 | Identificador único da produção.                |
| `cd_cultura`            | INTEGER           | 5         | NN, FK             | Código da cultura agrícola.                     |
| `cd_safra`              | INTEGER           | 5         | NN, FK             | Código da safra agrícola.                       |
| `cd_estado`             | INTEGER           | 5         | NN, FK             | Código do estado/província onde a produção ocorre.|
| `qt_area_plantada`      | NUMERIC (10,2)    |           | CK                 | Quantidade de área plantada (hectares). Deve ser maior ou igual a zero.|
| `qt_producao_total`     | NUMERIC (10,2)    |           | CK                 | Quantidade total produzida (toneladas). Deve ser maior ou igual a zero.|
| `vl_produtividade`      | NUMERIC (5,2)     |           | CK                 | Valor da produtividade (toneladas/hectare). Deve ser maior ou igual a zero.|

---
