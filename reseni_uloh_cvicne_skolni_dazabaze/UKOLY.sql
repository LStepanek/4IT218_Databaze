--------------------------------------------------------
--  File created - Středa-listopadu-08-2017   
--------------------------------------------------------
-- Unable to render TABLE DDL for object IT218.UKOLY with DBMS_METADATA attempting internal generator.
CREATE TABLE IT218.UKOLY 
(
  CIS_UK NUMBER(*, 0) NOT NULL 
, POPIS VARCHAR2(30 BYTE) NOT NULL 
, OS_CIS NUMBER(*, 0) NOT NULL 
, DATUM DATE NOT NULL 
, CONSTRAINT PK_UKOLY PRIMARY KEY 
  (
    CIS_UK 
  )
  ENABLE 
) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 1 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOCOMPRESS 
NOPARALLELALTER TABLE IT218.UKOLY
ADD CONSTRAINT FK_UKOLY_PRIDELENI_ZAM FOREIGN KEY
(
  OS_CIS 
)
REFERENCES IT218.ZAM
(
  OS_CIS 
)
ENABLECREATE UNIQUE INDEX IT218.PK_UKOLY ON IT218.UKOLY (CIS_UK ASC) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL
CREATE INDEX IT218.PRIDELENI_FK ON IT218.UKOLY (OS_CIS ASC) 
LOGGING 
TABLESPACE USERS 
PCTFREE 10 
INITRANS 2 
STORAGE 
( 
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1 
  MAXEXTENTS UNLIMITED 
  BUFFER_POOL DEFAULT 
) 
NOPARALLEL
REM INSERTING into IT218.UKOLY
SET DEFINE OFF;
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('101','PRINEST POSTU','1',to_date('10.02.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('102','ZAPLATIT SLOZENKY','1',to_date('02.10.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('105','POSTAVIT PODRIZENE DO LATE','21',to_date('10.02.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('106','ROZDELIT PRACI NA PROJEKTU FIS','21',to_date('02.10.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('107','ROZDELIT PRACI NA PROJEKTU KIS','7',to_date('02.09.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('108','DOJIT PRO SALAM A PIVKO','3',to_date('02.11.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('109','SEHNAT NECO NA ZUB','12',to_date('15.10.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('110','ZARADIT NOVE TITULY','10',to_date('22.12.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('111','DOKONCIT PROGRAM X57','19',to_date('02.01.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('112','ODLADIT ROZDELANE PROGRAMY','20',to_date('02.12.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('113','ZDOKUMENTOVAT PROGRAMY','19',to_date('02.12.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('114','PROVEST INVENTURU SKLADU C.13','42',to_date('02.06.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('115','KONECNE UKLIDIT','37',to_date('10.07.15','DD.MM.RR'));
Insert into IT218.UKOLY (CIS_UK,POPIS,OS_CIS,DATUM) values ('120','SEHNAT NOVE LIDI DO TYMU','7',to_date('30.10.15','DD.MM.RR'));