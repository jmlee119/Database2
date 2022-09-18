-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-09-18 22:51:00 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



DROP TABLE address CASCADE CONSTRAINTS;

DROP TABLE movie CASCADE CONSTRAINTS;

DROP TABLE movieexec CASCADE CONSTRAINTS;

DROP TABLE moviestar CASCADE CONSTRAINTS;

DROP TABLE phoneno CASCADE CONSTRAINTS;

DROP TABLE starsin CASCADE CONSTRAINTS;

DROP TABLE studio CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE address (
    address VARCHAR2(200) NOT NULL,
    sname   VARCHAR2(50)
);

ALTER TABLE address ADD CONSTRAINT house_pk PRIMARY KEY ( address );

CREATE TABLE movie (
    title      VARCHAR2(100) NOT NULL,
    year       NUMBER(4) NOT NULL,
    length     NUMBER(3) NOT NULL,
    incolor    CHAR(5),
    studioname VARCHAR2(50) NOT NULL,
    producerno NUMBER(8) NOT NULL,
    seqtitle   VARCHAR2(100) NOT NULL,
    seqyear    NUMBER(4) NOT NULL,
    directno   NUMBER(8) NOT NULL,
    stsound    VARCHAR2(50) NOT NULL
);

ALTER TABLE movie ADD CHECK ( year BETWEEN 1900 AND 2022 );

ALTER TABLE movie ADD CHECK ( length BETWEEN 50 AND 300 );

ALTER TABLE movie
    ADD CHECK ( incolor IN ( 'f', 'false', 't', 'true' ) );

ALTER TABLE movie ADD CHECK ( seqyear BETWEEN 1900 AND 2022 );

ALTER TABLE movie ADD CONSTRAINT movie_pk PRIMARY KEY ( title,
                                                        year );

CREATE TABLE movieexec (
    certno     NUMBER(8) NOT NULL,
    name       VARCHAR2(50) NOT NULL,
    address    VARCHAR2(200),
    networth   NUMBER(12),
    spousename VARCHAR2(50)
);

CREATE UNIQUE INDEX movieexec__idx ON
    movieexec (
        spousename
    ASC );

ALTER TABLE movieexec ADD CONSTRAINT movieexec_pk PRIMARY KEY ( certno );

ALTER TABLE movieexec ADD CONSTRAINT unique_name UNIQUE ( name );

CREATE TABLE moviestar (
    name       VARCHAR2(50) NOT NULL,
    address    VARCHAR2(200),
    gneder     CHAR(6),
    birthdate  DATE,
    spousename VARCHAR2(50)
);

ALTER TABLE moviestar
    ADD CHECK ( gneder IN ( 'female', 'male', '남자', '여자' ) );

CREATE UNIQUE INDEX moviestar__idx ON
    moviestar (
        spousename
    ASC );

ALTER TABLE moviestar ADD CONSTRAINT moviestar_pk PRIMARY KEY ( name );

CREATE TABLE phoneno (
    "number"  CHAR(13) NOT NULL,
    type      VARCHAR2(50),
    sname     VARCHAR2(50),
    execno    NUMBER(8),
    provider  VARCHAR2(50) NOT NULL,
    plan      NUMBER(6) NOT NULL,
    mstarname VARCHAR2(50)
);

ALTER TABLE phoneno ADD CONSTRAINT phoneno_pk PRIMARY KEY ( "number" );

CREATE TABLE starsin (
    movietitle VARCHAR2(100) NOT NULL,
    movieyear  NUMBER(4) NOT NULL,
    starname   VARCHAR2(50) NOT NULL
);

ALTER TABLE starsin ADD CHECK ( movieyear BETWEEN 1900 AND 2022 );

ALTER TABLE starsin
    ADD CONSTRAINT starsin_pk PRIMARY KEY ( movietitle,
                                            movieyear,
                                            starname );

CREATE TABLE studio (
    name     VARCHAR2(50) NOT NULL,
    address  VARCHAR2(200),
    empcount NUMBER(3)
);

ALTER TABLE studio ADD CHECK ( empcount BETWEEN 10 AND 100 );

ALTER TABLE studio ADD CONSTRAINT studio_pk PRIMARY KEY ( name );

ALTER TABLE movie
    ADD CONSTRAINT directed FOREIGN KEY ( directno )
        REFERENCES movieexec ( certno );

ALTER TABLE movie
    ADD CONSTRAINT owns FOREIGN KEY ( studioname )
        REFERENCES studio ( name );

ALTER TABLE phoneno
    ADD CONSTRAINT phone_of_exec FOREIGN KEY ( execno )
        REFERENCES movieexec ( certno );

ALTER TABLE phoneno
    ADD CONSTRAINT phone_of_moviestar FOREIGN KEY ( mstarname )
        REFERENCES moviestar ( name );

ALTER TABLE phoneno
    ADD CONSTRAINT phone_of_studio FOREIGN KEY ( sname )
        REFERENCES studio ( name );

ALTER TABLE movie
    ADD CONSTRAINT produceredby FOREIGN KEY ( producerno )
        REFERENCES movieexec ( certno );

ALTER TABLE movie
    ADD CONSTRAINT sequel_of FOREIGN KEY ( seqtitle,
                                           seqyear )
        REFERENCES movie ( title,
                           year );

ALTER TABLE movie
    ADD CONSTRAINT sounds FOREIGN KEY ( stsound )
        REFERENCES studio ( name );

ALTER TABLE starsin
    ADD CONSTRAINT starsin_movie_fk FOREIGN KEY ( movietitle,
                                                  movieyear )
        REFERENCES movie ( title,
                           year );

ALTER TABLE starsin
    ADD CONSTRAINT starsin_moviestar_fk FOREIGN KEY ( starname )
        REFERENCES moviestar ( name );

ALTER TABLE address
    ADD CONSTRAINT studioaddress FOREIGN KEY ( sname )
        REFERENCES studio ( name );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             2
-- ALTER TABLE                             26
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
