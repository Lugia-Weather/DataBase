-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025-05-31 01:20:10 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE tbl_alerta (
    id_alerta    INTEGER NOT NULL,
    tipo         VARCHAR2(50) NOT NULL,
    mensagem     VARCHAR2(500) NOT NULL,
    data_criacao TIMESTAMP NOT NULL
);

ALTER TABLE tbl_alerta ADD CONSTRAINT tbl_alerta_pk PRIMARY KEY ( id_alerta );

CREATE TABLE tbl_dispositivo_iot (
    id_dispositivo   INTEGER NOT NULL,
    id_modulo        VARCHAR2(100) NOT NULL,
    mac_endereco     VARCHAR2(50) NOT NULL,
    projeto          VARCHAR2(100) NOT NULL,
    status           VARCHAR2(50) NOT NULL,
    id_endereco      INTEGER NOT NULL,
    data_criacao     TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP
);

ALTER TABLE tbl_dispositivo_iot ADD CONSTRAINT tbl_dispositivo_iot_pk PRIMARY KEY ( id_dispositivo );

CREATE TABLE tbl_endereco (
    logradouro       VARCHAR2(100) NOT NULL,
    bairro           VARCHAR2(50) NOT NULL,
    complemento      VARCHAR2(100),
    uf               CHAR(2) NOT NULL,
    localidade       VARCHAR2(50) NOT NULL,
    id_endereco      INTEGER NOT NULL,
    latitude         NUMBER(10, 6),
    longitude        NUMBER(11, 6),
    data_criacao     TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP
);

ALTER TABLE tbl_endereco ADD CONSTRAINT tbl_endereco_pk PRIMARY KEY ( id_endereco );

CREATE TABLE tbl_leitura (
    id_leitura     INTEGER NOT NULL,
    id_dispositivo INTEGER NOT NULL,
    nivel_agua_cm  NUMBER(8, 3) NOT NULL,
    status_nivel   VARCHAR2(20) NOT NULL,
    data_criacao   TIMESTAMP NOT NULL,
    id_alerta      INTEGER NOT NULL
);

CREATE UNIQUE INDEX tbl_leitura__idx ON
    tbl_leitura (
        id_alerta
    ASC );

ALTER TABLE tbl_leitura ADD CONSTRAINT tbl_leitura_pk PRIMARY KEY ( id_leitura );

CREATE TABLE tbl_telefone (
    ddd              CHAR(2) NOT NULL,
    numero           CHAR(9) NOT NULL,
    id_telefone      INTEGER NOT NULL,
    data_criacao     TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP
);

ALTER TABLE tbl_telefone ADD CONSTRAINT tbl_telefone_pk PRIMARY KEY ( id_telefone );

CREATE TABLE tbl_usuario (
    id_usuario       INTEGER NOT NULL,
    nome             VARCHAR2(70) NOT NULL,
    email            VARCHAR2(50) NOT NULL,
    senha            VARCHAR2(255) NOT NULL,
    id_endereco      INTEGER NOT NULL,
    id_telefone      INTEGER NOT NULL,
    data_criacao     TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP
);

ALTER TABLE tbl_usuario ADD CONSTRAINT tbl_usuario_pk PRIMARY KEY ( id_usuario );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tbl_dispositivo_iot
    ADD CONSTRAINT tbl_dispositivo_iot_tbl_endereco_fk FOREIGN KEY ( id_endereco )
        REFERENCES tbl_endereco ( id_endereco );

ALTER TABLE tbl_leitura
    ADD CONSTRAINT tbl_leitura_tbl_alerta_fk FOREIGN KEY ( id_alerta )
        REFERENCES tbl_alerta ( id_alerta );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE tbl_leitura
    ADD CONSTRAINT tbl_leitura_tbl_dispositivo_iot_fk FOREIGN KEY ( id_dispositivo )
        REFERENCES tbl_dispositivo_iot ( id_dispositivo );

ALTER TABLE tbl_usuario
    ADD CONSTRAINT tbl_usuario_tbl_endereco_fk FOREIGN KEY ( id_endereco )
        REFERENCES tbl_endereco ( id_endereco );

ALTER TABLE tbl_usuario
    ADD CONSTRAINT tbl_usuario_tbl_telefone_fk FOREIGN KEY ( id_telefone )
        REFERENCES tbl_telefone ( id_telefone );



-- Relat�rio do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             1
-- ALTER TABLE                             11
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
-- ERRORS                                   2
-- WARNINGS                                 0
