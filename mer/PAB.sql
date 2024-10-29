-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-10-28 22:07:18 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_pab_cultura CASCADE CONSTRAINTS;

DROP TABLE t_pab_estado CASCADE CONSTRAINTS;

DROP TABLE t_pab_pais CASCADE CONSTRAINTS;

DROP TABLE t_pab_producao CASCADE CONSTRAINTS;

DROP TABLE t_pab_regiao CASCADE CONSTRAINTS;

DROP TABLE t_pab_safra CASCADE CONSTRAINTS;

DROP TABLE t_pab_tipocultura CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_pab_cultura (
    cd_cultura     INTEGER NOT NULL,
    nm_cultura     VARCHAR2(100 CHAR) NOT NULL,
    ds_cultura     VARCHAR2(255),
    cd_tipocultura INTEGER NOT NULL
);

COMMENT ON TABLE t_pab_cultura IS
    'Armazena informações sobre as culturas agrícolas específicas registradas globalmente no sistema.';

COMMENT ON COLUMN t_pab_cultura.cd_cultura IS
    'Identificador único da cultura agrícola.';

COMMENT ON COLUMN t_pab_cultura.nm_cultura IS
    'Nome da cultura agrícola (e.g., milho, soja).';

COMMENT ON COLUMN t_pab_cultura.ds_cultura IS
    'Descrição detalhada da cultura agrícola.';

COMMENT ON COLUMN t_pab_cultura.cd_tipocultura IS
    'Identificador do tipo de cultura associada.';

ALTER TABLE t_pab_cultura ADD CONSTRAINT pk_cultura PRIMARY KEY ( cd_cultura );

ALTER TABLE t_pab_cultura ADD CONSTRAINT un_cultura_nm_cultura UNIQUE ( nm_cultura );

CREATE TABLE t_pab_estado (
    cd_estado       INTEGER NOT NULL,
    nm_estado       VARCHAR2(100 CHAR) NOT NULL,
    cd_sigla_estado CHAR(2 CHAR) NOT NULL,
    cd_regiao       INTEGER NOT NULL
);

ALTER TABLE t_pab_estado
    ADD CHECK ( length(cd_sigla_estado) BETWEEN 2 AND 5 );

COMMENT ON TABLE t_pab_estado IS
    'Armazena informações sobre estados ou províncias de diversos países.';

COMMENT ON COLUMN t_pab_estado.cd_estado IS
    'Identificador único do estado/província. ';

COMMENT ON COLUMN t_pab_estado.nm_estado IS
    'Nome completo do estado/província.';

COMMENT ON COLUMN t_pab_estado.cd_sigla_estado IS
    'Sigla do estado, variando entre 2 e 5 caracteres.';

COMMENT ON COLUMN t_pab_estado.cd_regiao IS
    'Código da região associada ao estado.';

ALTER TABLE t_pab_estado ADD CONSTRAINT pk_estado PRIMARY KEY ( cd_estado );

ALTER TABLE t_pab_estado ADD CONSTRAINT un_estado_sigla_regiao UNIQUE ( cd_sigla_estado,
                                                                        cd_regiao );

CREATE TABLE t_pab_pais (
    cd_pais       INTEGER NOT NULL,
    nm_pais       VARCHAR2(100 CHAR) NOT NULL,
    cd_sigla_pais CHAR(3 CHAR) NOT NULL
);

COMMENT ON TABLE t_pab_pais IS
    'Armazena informações sobre os países associados às regiões e estados/províncias no sistema.';

COMMENT ON COLUMN t_pab_pais.cd_pais IS
    'Identificador único do país.';

COMMENT ON COLUMN t_pab_pais.nm_pais IS
    'Nome completo do país.';

COMMENT ON COLUMN t_pab_pais.cd_sigla_pais IS
    'Sigla do país conforme padrão ISO.';

ALTER TABLE t_pab_pais ADD CONSTRAINT pk_pais PRIMARY KEY ( cd_pais );

ALTER TABLE t_pab_pais ADD CONSTRAINT un_pais_nm_pais UNIQUE ( nm_pais );

CREATE TABLE t_pab_producao (
    cd_producao       INTEGER NOT NULL,
    cd_cultura        INTEGER NOT NULL,
    cd_safra          INTEGER NOT NULL,
    cd_estado         INTEGER NOT NULL,
    qt_area_plantada  NUMBER(10, 2),
    qt_producao_total NUMBER(10, 2),
    vl_produtividade  NUMBER(5, 2)
);

ALTER TABLE t_pab_producao ADD CHECK ( qt_area_plantada >= 0 );

ALTER TABLE t_pab_producao ADD CHECK ( qt_producao_total >= 0 );

ALTER TABLE t_pab_producao ADD CHECK ( vl_produtividade >= 0 );

COMMENT ON TABLE t_pab_producao IS
    'Armazena informações detalhadas sobre a produção agrícola por estado/província, safra e cultura.';

COMMENT ON COLUMN t_pab_producao.cd_producao IS
    'Identificador único da produção.';

COMMENT ON COLUMN t_pab_producao.cd_cultura IS
    'Código da cultura agrícola.';

COMMENT ON COLUMN t_pab_producao.cd_safra IS
    'Código da safra agrícola.';

COMMENT ON COLUMN t_pab_producao.cd_estado IS
    'Código do estado/província onde a produção ocorre.';

COMMENT ON COLUMN t_pab_producao.qt_area_plantada IS
    'Quantidade de área plantada (hectares).';

COMMENT ON COLUMN t_pab_producao.qt_producao_total IS
    'Quantidade total produzida (toneladas).';

COMMENT ON COLUMN t_pab_producao.vl_produtividade IS
    'Valor da produtividade (toneladas/hectare)';

ALTER TABLE t_pab_producao ADD CONSTRAINT pk_producao PRIMARY KEY ( cd_producao );

ALTER TABLE t_pab_producao
    ADD CONSTRAINT un_producao_cult_safra_estado UNIQUE ( cd_cultura,
                                                          cd_safra,
                                                          cd_estado );

CREATE TABLE t_pab_regiao (
    cd_regiao INTEGER NOT NULL,
    nm_regiao VARCHAR2(100 CHAR) NOT NULL,
    ds_regiao VARCHAR2(255 CHAR),
    cd_pais   INTEGER NOT NULL
);

COMMENT ON TABLE t_pab_regiao IS
    'Armazena informações sobre as regiões associadas aos estados/províncias no sistema.';

COMMENT ON COLUMN t_pab_regiao.cd_regiao IS
    'Identificador único da região.';

COMMENT ON COLUMN t_pab_regiao.nm_regiao IS
    'Nome da região (e.g., Norte, Sudeste). ';

COMMENT ON COLUMN t_pab_regiao.ds_regiao IS
    'Descrição adicional da região.';

COMMENT ON COLUMN t_pab_regiao.cd_pais IS
    'Código do país ao qual a região pertence.';

ALTER TABLE t_pab_regiao ADD CONSTRAINT pk_regiao PRIMARY KEY ( cd_regiao );

ALTER TABLE t_pab_regiao ADD CONSTRAINT un_regiao_nm_regiao_cd_pais UNIQUE ( nm_regiao,
                                                                             cd_pais );

CREATE TABLE t_pab_safra (
    cd_safra INTEGER NOT NULL,
    nr_safra NUMBER(4) NOT NULL,
    ds_safra VARCHAR2(100 CHAR)
);

ALTER TABLE t_pab_safra ADD CHECK ( nr_safra BETWEEN 1900 AND 2100 );

COMMENT ON TABLE t_pab_safra IS
    'Armazena informações sobre as safras agrícolas registradas no sistema, que podem ocorrer globalmente.';

COMMENT ON COLUMN t_pab_safra.cd_safra IS
    'Identificador único da safra.';

COMMENT ON COLUMN t_pab_safra.nr_safra IS
    'Ano referente à safra (e.g., 2024).';

COMMENT ON COLUMN t_pab_safra.ds_safra IS
    'Descrição da safra, se aplicável.';

ALTER TABLE t_pab_safra ADD CONSTRAINT pk_safra PRIMARY KEY ( cd_safra );

CREATE TABLE t_pab_tipocultura (
    cd_tipocultura INTEGER NOT NULL,
    nm_tipocultura VARCHAR2(100 CHAR) NOT NULL,
    ds_tipocultura VARCHAR2(255 CHAR)
);

COMMENT ON TABLE t_pab_tipocultura IS
    'Armazena informações sobre os tipos de culturas agrícolas disponíveis globalmente no sistema.';

COMMENT ON COLUMN t_pab_tipocultura.cd_tipocultura IS
    'Identificador único do tipo de cultura.';

COMMENT ON COLUMN t_pab_tipocultura.nm_tipocultura IS
    'Nome do tipo de cultura (e.g., grãos).';

COMMENT ON COLUMN t_pab_tipocultura.ds_tipocultura IS
    'Descrição detalhada do tipo de cultura.';

ALTER TABLE t_pab_tipocultura ADD CONSTRAINT pk_tipocultura PRIMARY KEY ( cd_tipocultura );

ALTER TABLE t_pab_tipocultura ADD CONSTRAINT un_tipocultura_nm_tipocultura UNIQUE ( nm_tipocultura );

ALTER TABLE t_pab_cultura
    ADD CONSTRAINT fk_cultura_tipocultura FOREIGN KEY ( cd_tipocultura )
        REFERENCES t_pab_tipocultura ( cd_tipocultura );

ALTER TABLE t_pab_estado
    ADD CONSTRAINT fk_estado_regiao FOREIGN KEY ( cd_regiao )
        REFERENCES t_pab_regiao ( cd_regiao );

ALTER TABLE t_pab_producao
    ADD CONSTRAINT fk_producao_cultura FOREIGN KEY ( cd_cultura )
        REFERENCES t_pab_cultura ( cd_cultura );

ALTER TABLE t_pab_producao
    ADD CONSTRAINT fk_producao_estado FOREIGN KEY ( cd_estado )
        REFERENCES t_pab_estado ( cd_estado );

ALTER TABLE t_pab_producao
    ADD CONSTRAINT fk_producao_safra FOREIGN KEY ( cd_safra )
        REFERENCES t_pab_safra ( cd_safra );

ALTER TABLE t_pab_regiao
    ADD CONSTRAINT fk_regiao_pais FOREIGN KEY ( cd_pais )
        REFERENCES t_pab_pais ( cd_pais );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             24
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
