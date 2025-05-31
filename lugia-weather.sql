-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2025-05-31 01:20:10 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE


-- Drop para cada tabela
DROP TABLE TBL_ALERTA CASCADE CONSTRAINTS PURGE;
DROP TABLE TBL_LEITURA CASCADE CONSTRAINTS PURGE;
DROP TABLE TBL_TELEFONE CASCADE CONSTRAINTS PURGE;
DROP TABLE TBL_ENDERECO CASCADE CONSTRAINTS PURGE;
DROP TABLE TBL_DISPOSITIVO_IOT CASCADE CONSTRAINTS PURGE;
DROP TABLE TBL_USUARIO CASCADE CONSTRAINTS PURGE;

-- DDL
CREATE TABLE tbl_alerta (
    id_alerta    INTEGER NOT NULL,
    tipo         VARCHAR2(50) NOT NULL,
    mensagem     VARCHAR2(500) NOT NULL,
    data_criacao TIMESTAMP NOT NULL
);

ALTER TABLE tbl_alerta ADD CONSTRAINT tbl_alerta_pk PRIMARY KEY ( id_alerta );

CREATE TABLE tbl_dispositivo_iot (
    id_dispositivo   INTEGER NOT NULL,
    id_modulo        VARCHAR2(100) NOT NULL UNIQUE,
    mac_endereco     VARCHAR2(50) NOT NULL UNIQUE,
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
    email            VARCHAR2(50) NOT NULL UNIQUE,
    senha            VARCHAR2(255) NOT NULL,
    id_endereco      INTEGER NOT NULL,
    id_telefone      INTEGER NOT NULL,
    data_criacao     TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP
);

ALTER TABLE tbl_usuario ADD CONSTRAINT tbl_usuario_pk PRIMARY KEY ( id_usuario );


ALTER TABLE tbl_dispositivo_iot
    ADD CONSTRAINT tbl_disp_endereco_fk FOREIGN KEY ( id_endereco )
        REFERENCES tbl_endereco ( id_endereco );

ALTER TABLE tbl_leitura
    ADD CONSTRAINT tbl_leitura_tbl_alerta_fk FOREIGN KEY ( id_alerta )
        REFERENCES tbl_alerta ( id_alerta );

ALTER TABLE tbl_leitura
    ADD CONSTRAINT tbl_leitura_disp_fk FOREIGN KEY ( id_dispositivo )
        REFERENCES tbl_dispositivo_iot ( id_dispositivo );

ALTER TABLE tbl_usuario
    ADD CONSTRAINT tbl_usuario_tbl_endereco_fk FOREIGN KEY ( id_endereco )
        REFERENCES tbl_endereco ( id_endereco );

ALTER TABLE tbl_usuario
    ADD CONSTRAINT tbl_usuario_tbl_telefone_fk FOREIGN KEY ( id_telefone )
        REFERENCES tbl_telefone ( id_telefone );

-- Select para cada tabela

SELECT * FROM TBL_ALERTA;

SELECT * FROM TBL_LEITURA;

SELECT * FROM TBL_TELEFONE;

SELECT * FROM TBL_ENDERECO;

SELECT * FROM TBL_DISPOSITIVO_IOT;

SELECT * FROM TBL_USUARIO;


-- Delete para cada tabela
DELETE FROM TBL_USUARIO;

DELETE FROM TBL_TELEFONE;

DELETE FROM TBL_LEITURA;

DELETE FROM TBL_ALERTA;

DELETE FROM TBL_DISPOSITIVO_IOT;

DELETE FROM TBL_ENDERECO;



-- PL/SQL
SET VERIFY OFF;
SET SERVEROUTPUT ON; 


-- Procedure com bloco anônimo de inserção
BEGIN
-- ENDERECO
FOR i IN 1..5 LOOP
INSERT INTO tbl_endereco (logradouro, bairro, complemento, uf, localidade, id_endereco, latitude, longitude, data_criacao)
VALUES ('Rua ' || i, 'Bairro ' || i, 'Complemento ' || i, 'SP', 'Cidade ' || i, i, -23.5 + i, -46.6 + i, SYSDATE);
END LOOP;

-- TELEFONE
FOR i IN 1..5 LOOP
INSERT INTO tbl_telefone (ddd, numero, id_telefone, data_criacao)
VALUES ('1' || TO_CHAR(i), '90000000' || TO_CHAR(i), i, SYSDATE);
END LOOP;

-- ALERTA
FOR i IN 1..5 LOOP
INSERT INTO tbl_alerta (id_alerta, tipo, mensagem, data_criacao)
VALUES (i,
CASE i WHEN 1 THEN 'Normal' WHEN 2 THEN 'Chuva Leve' WHEN 3 THEN 'Chuva Moderada' WHEN 4 THEN 'Risco de Alagamento' ELSE 'Alagamento' END,
'Mensagem de alerta ' || i,
SYSDATE);
END LOOP;

-- DISPOSITIVO_IOT
FOR i IN 1..5 LOOP
INSERT INTO tbl_dispositivo_iot (id_dispositivo, id_modulo, mac_endereco, projeto, status, id_endereco, data_criacao)
VALUES (i, 'MOD' || i, '00:11:22:33:44:5' || i, 'Detecção Enchente', CASE WHEN i=1 THEN 'Ativo' ELSE 'Inativo' END, i, SYSDATE);
END LOOP;

-- 5. USUARIO
FOR i IN 1..5 LOOP
INSERT INTO tbl_usuario (id_usuario, nome, email, senha, id_endereco, id_telefone, data_criacao)
VALUES (i, 'Usuário ' || i, 'usuario' || i || '@exemplo.com', 'senha' || i, i, i, SYSDATE);
END LOOP;

-- LEITURA
FOR i IN 1..5 LOOP
INSERT INTO tbl_leitura (id_leitura, id_dispositivo, nivel_agua_cm, status_nivel, data_criacao, id_alerta)
VALUES (i, i, 5.0*i,
CASE i WHEN 1 THEN 'Normal' WHEN 2 THEN 'Chuva' WHEN 3 THEN 'Atenção' WHEN 4 THEN 'Risco' ELSE 'Alagado' END,
SYSDATE, i);
END LOOP;
END;




-- Procedure com bloco anônimo de atualização
BEGIN
-- ENDERECO
FOR i IN 1..5 LOOP
UPDATE tbl_endereco
SET bairro = 'Bairro Atualizado ' || i, data_atualizacao = SYSDATE
WHERE id_endereco = i;
END LOOP;

-- TELEFONE
FOR i IN 1..5 LOOP
UPDATE tbl_telefone
SET numero = '98888888' || TO_CHAR(i), data_atualizacao = SYSDATE
WHERE id_telefone = i;
END LOOP;

-- ALERTA
FOR i IN 1..5 LOOP
UPDATE tbl_alerta
SET mensagem = 'Mensagem de alerta atualizada ' || i
WHERE id_alerta = i;
END LOOP;

-- DISPOSITIVO_IOT
FOR i IN 1..5 LOOP
UPDATE tbl_dispositivo_iot
SET status = 'Atualizado ' || i, data_atualizacao = SYSDATE
WHERE id_dispositivo = i;
END LOOP;

-- USUARIO
FOR i IN 1..5 LOOP
UPDATE tbl_usuario
SET nome = 'Usuário Atualizado ' || i, data_atualizacao = SYSDATE
WHERE id_usuario = i;
END LOOP;

-- LEITURA
FOR i IN 1..5 LOOP
UPDATE tbl_leitura
SET nivel_agua_cm = 100.0 + i
WHERE id_leitura = i;
END LOOP;
END;


-- Procedure com bloco anônimo de exclusão
BEGIN
-- LEITURA
FOR i IN 1..5 LOOP
DELETE FROM tbl_leitura WHERE id_leitura = i;
END LOOP;

-- USUARIO
FOR i IN 1..5 LOOP
DELETE FROM tbl_usuario WHERE id_usuario = i;
END LOOP;

-- DISPOSITIVO_IOT
FOR i IN 1..5 LOOP
DELETE FROM tbl_dispositivo_iot WHERE id_dispositivo = i;
END LOOP;

-- ALERTA
FOR i IN 1..5 LOOP
DELETE FROM tbl_alerta WHERE id_alerta = i;
END LOOP;

-- TELEFONE
FOR i IN 1..5 LOOP
DELETE FROM tbl_telefone WHERE id_telefone = i;
END LOOP;

-- ENDERECO
FOR i IN 1..5 LOOP
DELETE FROM tbl_endereco WHERE id_endereco = i;
END LOOP;
END;







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
