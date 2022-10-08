-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-10-02 22:46:39 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2



DROP TABLE addresses CASCADE CONSTRAINTS;

DROP TABLE board CASCADE CONSTRAINTS;

DROP TABLE company CASCADE CONSTRAINTS;

DROP TABLE company_of_goods CASCADE CONSTRAINTS;

DROP TABLE employee CASCADE CONSTRAINTS;

DROP TABLE goods CASCADE CONSTRAINTS;

DROP TABLE member CASCADE CONSTRAINTS;

DROP TABLE "Order" CASCADE CONSTRAINTS;

DROP TABLE post CASCADE CONSTRAINTS;

DROP TABLE reply CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE addresses (
    address VARCHAR2(200) NOT NULL
);

ALTER TABLE addresses ADD CONSTRAINT addresses_pk PRIMARY KEY ( address );

CREATE TABLE board (
    boradtype  VARCHAR2(50) NOT NULL,
    manager_no NUMBER(5) NOT NULL
);

CREATE UNIQUE INDEX board__idx ON
    board (
        manager_no
    ASC );

ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY ( boradtype );

CREATE TABLE company (
    name            VARCHAR2(50) NOT NULL,
    p_no            CHAR(13) NOT NULL,
    company_address VARCHAR2(200) NOT NULL
);

ALTER TABLE company ADD CHECK ( p_no LIKE '___-____-____' );

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY ( name );

CREATE TABLE company_of_goods (
    companyname VARCHAR2(50) NOT NULL,
    goodsno     NUMBER(5) NOT NULL
);

ALTER TABLE company_of_goods ADD CONSTRAINT company_of_goods_pk PRIMARY KEY ( companyname,
                                                                              goodsno );

CREATE TABLE employee (
    em_no           NUMBER(5) NOT NULL,
    acc_name        VARCHAR2(50) NOT NULL,
    name            VARCHAR2(50) NOT NULL,
    p_no            CHAR(13),
    department_name VARCHAR2(50),
    email           VARCHAR2(50),
    em_address      VARCHAR2(200) NOT NULL
);

ALTER TABLE employee ADD CHECK ( p_no LIKE '___-____-____' );

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( em_no );

CREATE TABLE goods (
    no              NUMBER(5) NOT NULL,
    name            VARCHAR2(50) NOT NULL,
    money           NUMBER(12) NOT NULL,
    stock           NUMBER(5),
    made_by_company VARCHAR2(50)
);

ALTER TABLE goods ADD CONSTRAINT goods_pk PRIMARY KEY ( no );

CREATE TABLE member (
    acc_name        VARCHAR2(50) NOT NULL,
    name            VARCHAR2(50) NOT NULL,
    company_pno     CHAR(13),
    email           VARCHAR2(50),
    home_address    VARCHAR2(200) NOT NULL,
    company_address VARCHAR2(200),
    home_pno        CHAR(13)
);

ALTER TABLE member ADD CHECK ( company_pno LIKE '___-____-____' );

ALTER TABLE member ADD CHECK ( home_pno LIKE '___-____-____' );

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( acc_name );

CREATE TABLE "Order" (
    goods_no      NUMBER(5) NOT NULL,
    member_name   VARCHAR2(50) NOT NULL,
    order_address VARCHAR2(200) NOT NULL,
    orderdate     DATE
);

ALTER TABLE "Order"
    ADD CHECK ( orderdate >= DATE '2000-01-01'
                AND orderdate <= DATE '2099-12-31' );

ALTER TABLE "Order" ADD CONSTRAINT order_pk PRIMARY KEY ( goods_no );

CREATE TABLE post (
    postid      NUMBER(5) NOT NULL,
    title       VARCHAR2(50) NOT NULL,
    writer      VARCHAR2(50) NOT NULL,
    content     VARCHAR2(500) NOT NULL,
    "date"      DATE,
    boradtype   VARCHAR2(50) NOT NULL,
    member_name VARCHAR2(50) NOT NULL
);

ALTER TABLE post
    ADD CHECK ( "date" >= DATE '2000-01-01'
                AND "date" <= DATE '2099-12-31' );

ALTER TABLE post ADD CONSTRAINT post_pk PRIMARY KEY ( postid );

CREATE TABLE reply (
    replyno NUMBER(5) NOT NULL,
    content VARCHAR2(500) NOT NULL,
    manager NUMBER(5) NOT NULL,
    postid  NUMBER(5) NOT NULL
);

CREATE UNIQUE INDEX reply__idx ON
    reply (
        postid
    ASC );

CREATE UNIQUE INDEX reply__idxv1 ON
    reply (
        manager
    ASC );

ALTER TABLE reply ADD CONSTRAINT reply_pk PRIMARY KEY ( replyno );

ALTER TABLE board
    ADD CONSTRAINT board_manager FOREIGN KEY ( manager_no )
        REFERENCES employee ( em_no );

ALTER TABLE post
    ADD CONSTRAINT board_of_post FOREIGN KEY ( boradtype )
        REFERENCES board ( boradtype );

ALTER TABLE member
    ADD CONSTRAINT company_add FOREIGN KEY ( company_address )
        REFERENCES addresses ( address );

ALTER TABLE company
    ADD CONSTRAINT company_address FOREIGN KEY ( company_address )
        REFERENCES addresses ( address );

ALTER TABLE company_of_goods
    ADD CONSTRAINT company_of_goods_company_fk FOREIGN KEY ( companyname )
        REFERENCES company ( name );

ALTER TABLE company_of_goods
    ADD CONSTRAINT company_of_goods_goods_fk FOREIGN KEY ( goodsno )
        REFERENCES goods ( no );

ALTER TABLE employee
    ADD CONSTRAINT employee_address FOREIGN KEY ( em_address )
        REFERENCES addresses ( address );

ALTER TABLE member
    ADD CONSTRAINT home_address FOREIGN KEY ( home_address )
        REFERENCES addresses ( address );

ALTER TABLE post
    ADD CONSTRAINT member_of_post FOREIGN KEY ( member_name )
        REFERENCES member ( acc_name );

ALTER TABLE "Order"
    ADD CONSTRAINT order_address FOREIGN KEY ( order_address )
        REFERENCES addresses ( address );

ALTER TABLE "Order"
    ADD CONSTRAINT order_of_goods FOREIGN KEY ( goods_no )
        REFERENCES goods ( no );

ALTER TABLE reply
    ADD CONSTRAINT post_of_reply FOREIGN KEY ( postid )
        REFERENCES post ( postid );

ALTER TABLE "Order"
    ADD CONSTRAINT relation_5 FOREIGN KEY ( member_name )
        REFERENCES member ( acc_name );

ALTER TABLE reply
    ADD CONSTRAINT reply_of_manager FOREIGN KEY ( manager )
        REFERENCES employee ( em_no );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             3
-- ALTER TABLE                             30
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
