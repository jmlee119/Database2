-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-10-04 15:17:24 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



DROP TABLE movie CASCADE CONSTRAINTS;

DROP TABLE movieexec CASCADE CONSTRAINTS;

DROP TABLE moviestar CASCADE CONSTRAINTS;

DROP TABLE starsin CASCADE CONSTRAINTS;

CREATE OR REPLACE TYPE people_info AS OBJECT (
    name      VARCHAR2(50),
    address   VARCHAR2(100),
    birthdate DATE
) NOT FINAL;
/

CREATE OR REPLACE TYPE family_info AS OBJECT (
    spousename     VARCHAR2(20),
    no_of_children NUMBER(1)
) NOT FINAL;
/

CREATE OR REPLACE TYPE exec_info UNDER people_info (
    networth NUMBER(14),
    role     VARCHAR2(20),
    no       NUMBER(8),
    family   family_info
) NOT FINAL;
/

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

CREATE OR REPLACE TYPE star_info UNDER people_info (
    gender CHAR(6),
    family family_info,
    no     VARCHAR2(30)
) NOT FINAL;
/

-- predefined type, no DDL - XMLTYPE

CREATE TABLE movie (
    title      VARCHAR2(50) NOT NULL,
    year       NUMBER(4) NOT NULL,
    length     NUMBER(3),
    producerno NUMBER(8) NOT NULL
);

ALTER TABLE movie ADD CONSTRAINT movie_pk PRIMARY KEY ( title,
                                                        year );

CREATE TABLE movieexec (
    job  VARCHAR2(10),
    info exec_info,
    CHECK ( info.no IS NOT NULL )
);

ALTER TABLE movieexec ADD CONSTRAINT exec_p_key PRIMARY KEY ( info.no );

CREATE TABLE moviestar (
    company VARCHAR2(10),
    info    star_info,
    CHECK ( info.no IS NOT NULL ),
    CHECK ( info.name IS NOT NULL )
);

ALTER TABLE moviestar ADD CONSTRAINT star_key PRIMARY KEY ( info.no );

CREATE TABLE starsin (
    starno     VARCHAR2(30) NOT NULL,
    movietitle VARCHAR2(50) NOT NULL,
    movieyear  NUMBER(4) NOT NULL
);

ALTER TABLE starsin
    ADD CONSTRAINT starsin_pk PRIMARY KEY ( starno,
                                            movietitle,
                                            movieyear );

ALTER TABLE movie
    ADD CONSTRAINT produced_by FOREIGN KEY ( producerno )
        REFERENCES movieexec ( info.no );

ALTER TABLE starsin
    ADD CONSTRAINT starsin_movie_fk FOREIGN KEY ( movietitle,
                                                  movieyear )
        REFERENCES movie ( title,
                           year );

ALTER TABLE starsin
    ADD CONSTRAINT starsin_moviestar_fk FOREIGN KEY ( starno )
        REFERENCES moviestar ( info.no );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   4
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
