-- 생성자 Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   위치:        2022-10-08 17:49:49 KST
--   사이트:      Oracle Database 12cR2
--   유형:      Oracle Database 12cR2

DROP type Basic_info force;
DROP type phone force;

DROP VIEW Dept_info CASCADE CONSTRAINTS 
;

DROP VIEW Prof_of_CS CASCADE CONSTRAINTS 
;

DROP VIEW Special_Lectures CASCADE CONSTRAINTS 
;

DROP TABLE assist CASCADE CONSTRAINTS;

DROP TABLE class CASCADE CONSTRAINTS;

DROP TABLE class_of_professor CASCADE CONSTRAINTS;

DROP TABLE class_of_room CASCADE CONSTRAINTS;

DROP TABLE class_of_student CASCADE CONSTRAINTS;

DROP TABLE class_of_time CASCADE CONSTRAINTS;

DROP TABLE department CASCADE CONSTRAINTS;

DROP TABLE head CASCADE CONSTRAINTS;

DROP TABLE professor CASCADE CONSTRAINTS;

DROP TABLE room CASCADE CONSTRAINTS;

DROP TABLE student CASCADE CONSTRAINTS;

DROP TABLE time CASCADE CONSTRAINTS;

CREATE OR REPLACE TYPE phone AS OBJECT (
    cell   CHAR(13),
    home   CHAR(13),
    office CHAR(13)
) NOT FINAL;
/

CREATE OR REPLACE TYPE basic_info AS OBJECT (
    name    VARCHAR2(50),
    address VARCHAR2(250),
    pno     phone
) NOT FINAL;
/

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE assist (
    no             NUMBER(6) NOT NULL,
    info           basic_info,
    departmentname VARCHAR2(50) NOT NULL,
    CHECK ( info.name IS NOT NULL ),
    CHECK ( info.pno.cell IS NOT NULL )
);

ALTER TABLE assist
    ADD CHECK ( info.pno.cell LIKE '___-____-____' );

ALTER TABLE assist
    ADD CHECK ( info.pno.home LIKE '___-____-____' );

ALTER TABLE assist
    ADD CHECK ( info.pno.office LIKE '___-____-____' );

ALTER TABLE assist ADD CONSTRAINT assist_pk PRIMARY KEY ( no );

CREATE TABLE class (
    no       NUMBER(6) NOT NULL,
    name     VARCHAR2(50) NOT NULL,
    gpa      NUMBER(6),
    assistno NUMBER(6) NOT NULL
);

ALTER TABLE class ADD CONSTRAINT class_pk PRIMARY KEY ( no );

CREATE TABLE class_of_professor (
    professorno NUMBER(6) NOT NULL,
    classno     NUMBER(6) NOT NULL
);

ALTER TABLE class_of_professor ADD CONSTRAINT class_of_professor_pk PRIMARY KEY ( professorno,
                                                                                  classno );

CREATE TABLE class_of_room (
    roomno           NUMBER(6) NOT NULL,
    roombuildingname VARCHAR2(50) NOT NULL,
    classno          NUMBER(6) NOT NULL
);

ALTER TABLE class_of_room
    ADD CONSTRAINT class_of_room_pk PRIMARY KEY ( roomno,
                                                  roombuildingname,
                                                  classno );

CREATE TABLE class_of_student (
    classno   NUMBER(6) NOT NULL,
    studentno NUMBER(6) NOT NULL
);

ALTER TABLE class_of_student ADD CONSTRAINT class_of_student_pk PRIMARY KEY ( classno,
                                                                              studentno );

CREATE TABLE class_of_time (
    classno   NUMBER(6) NOT NULL,
    classday  VARCHAR2(50) NOT NULL,
    classtime NUMBER(6) NOT NULL
);

ALTER TABLE class_of_time
    ADD CONSTRAINT class_of_time_pk PRIMARY KEY ( classno,
                                                  classday,
                                                  classtime );

CREATE TABLE department (
    dname VARCHAR2(50) NOT NULL,
    count NUMBER(6)
);

ALTER TABLE department ADD CONSTRAINT departmennt_p_pk PRIMARY KEY ( dname );

CREATE TABLE head (
    no             NUMBER(6) NOT NULL,
    professorno    NUMBER(6) NOT NULL,
    departmentname VARCHAR2(50)
);

ALTER TABLE head ADD CONSTRAINT head_pk PRIMARY KEY ( no );

CREATE TABLE professor (
    no             NUMBER(6) NOT NULL,
    major          VARCHAR2(50) NOT NULL,
    location       VARCHAR2(250),
    info           basic_info,
    departmentname VARCHAR2(50) NOT NULL,
    CHECK ( info.name IS NOT NULL ),
    CHECK ( info.pno.cell IS NOT NULL )
);

ALTER TABLE professor
    ADD CHECK ( info.pno.cell LIKE '___-____-____' );

ALTER TABLE professor
    ADD CHECK ( info.pno.home LIKE '___-____-____' );

ALTER TABLE professor
    ADD CHECK ( info.pno.office LIKE '___-____-____' );

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( no );

CREATE TABLE room (
    buildingname VARCHAR2(50) NOT NULL,
    no           NUMBER(6) NOT NULL,
    floor        NUMBER(6) NOT NULL,
    count        NUMBER(6)
);

ALTER TABLE room ADD CONSTRAINT room_pk PRIMARY KEY ( no,
                                                      buildingname );

CREATE TABLE student (
    no    NUMBER(6) NOT NULL,
    info  basic_info,
    stype VARCHAR2(50),
    major VARCHAR2(50) NOT NULL,
    minor VARCHAR2(50),
    CHECK ( info.name IS NOT NULL ),
    CHECK ( info.pno.cell IS NOT NULL )
);

ALTER TABLE student
    ADD CHECK ( info.pno.cell LIKE '___-____-____' );

ALTER TABLE student
    ADD CHECK ( info.pno.home LIKE '___-____-____' );

ALTER TABLE student
    ADD CHECK ( info.pno.office LIKE '___-____-____' );

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( no );

CREATE TABLE time (
    day  VARCHAR2(50) NOT NULL,
    time NUMBER(6) NOT NULL
);

ALTER TABLE time ADD CONSTRAINT time_pk PRIMARY KEY ( day,
                                                      time );

ALTER TABLE class
    ADD CONSTRAINT class_of_assist FOREIGN KEY ( assistno )
        REFERENCES assist ( no );

ALTER TABLE class_of_professor
    ADD CONSTRAINT class_of_professor_class_fk FOREIGN KEY ( classno )
        REFERENCES class ( no );

ALTER TABLE class_of_professor
    ADD CONSTRAINT class_of_professor_professor_fk FOREIGN KEY ( professorno )
        REFERENCES professor ( no );

ALTER TABLE class_of_room
    ADD CONSTRAINT class_of_room_class_fk FOREIGN KEY ( classno )
        REFERENCES class ( no );

ALTER TABLE class_of_room
    ADD CONSTRAINT class_of_room_room_fk FOREIGN KEY ( roomno,
                                                       roombuildingname )
        REFERENCES room ( no,
                          buildingname );

ALTER TABLE class_of_student
    ADD CONSTRAINT class_of_student_class_fk FOREIGN KEY ( classno )
        REFERENCES class ( no );

ALTER TABLE class_of_student
    ADD CONSTRAINT class_of_student_student_fk FOREIGN KEY ( studentno )
        REFERENCES student ( no );

ALTER TABLE class_of_time
    ADD CONSTRAINT class_of_time_class_fk FOREIGN KEY ( classno )
        REFERENCES class ( no );

ALTER TABLE class_of_time
    ADD CONSTRAINT class_of_time_time_fk FOREIGN KEY ( classday,
                                                       classtime )
        REFERENCES time ( day,
                          time );

ALTER TABLE assist
    ADD CONSTRAINT department_of_assist FOREIGN KEY ( departmentname )
        REFERENCES department ( dname );

ALTER TABLE professor
    ADD CONSTRAINT department_of_professor FOREIGN KEY ( departmentname )
        REFERENCES department ( dname );

ALTER TABLE head
    ADD CONSTRAINT head_of_department FOREIGN KEY ( departmentname )
        REFERENCES department ( dname );

ALTER TABLE head
    ADD CONSTRAINT head_of_professor FOREIGN KEY ( professorno )
        REFERENCES professor ( no );

ALTER TABLE student
    ADD CONSTRAINT major_of_student FOREIGN KEY ( major )
        REFERENCES department ( dname );

ALTER TABLE student
    ADD CONSTRAINT minor_of_studentv1 FOREIGN KEY ( minor )
        REFERENCES department ( dname );

CREATE OR REPLACE VIEW Dept_info ( dname, "교수의 수", "조교의 수" ) AS
SELECT
    department.dname,
    COUNT(DISTINCT professor.no) AS "교수의 수",
    COUNT(DISTINCT assist.no)    AS "조교의 수"
FROM
    assist,
    department,
    professor
WHERE
        department.dname = assist.departmentname
    AND department.dname = professor.departmentname
GROUP BY
    department.dname
HAVING
    COUNT(DISTINCT professor.no) >= 2 
;

CREATE OR REPLACE VIEW Prof_of_CS ( name, location, "Count_classNo", departmentname ) AS
SELECT
    p.info.name                       AS "name",
    p.location,
    COUNT(class_of_professor.classno) AS "Count_classNo",
    p.departmentname
FROM
    class_of_professor,
    professor p
WHERE
        p.no = class_of_professor.professorno
    AND p.departmentname = '소프트웨어학과'
GROUP BY
    p.info.name,
    p.location,
    p.departmentname 
;

CREATE OR REPLACE VIEW Special_Lectures ( name, no, time, day ) AS
SELECT
    c.name,
    room.no,
    t.time,
    t.day
FROM
    class_of_time,
    time  t,
    class c,
    class_of_room,
    room
WHERE
        t.day = class_of_time.classday
    AND t.time = class_of_time.classtime
    AND c.no = class_of_time.classno
    AND c.no = class_of_room.classno
    AND room.no = class_of_room.roomno
    AND room.buildingname = class_of_room.roombuildingname
    AND t.time >= 6
    AND t.time <= 9
    AND ( t.day LIKE '월'
          OR t.day LIKE '수'
          OR t.day LIKE '금' ) 
;



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                            12
-- CREATE INDEX                             0
-- ALTER TABLE                             36
-- CREATE VIEW                              3
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   2
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
