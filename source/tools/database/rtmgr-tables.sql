-------------------------------------------------------------------------------
-- T A B L E S
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Table holding information about database modifications
-------------------------------------------------------------------------------

CREATE TABLE UPDATES (
  DATA TIMESTAMP,
  TABLENAME VARCHAR(50),
  ID INT,
  OPERATION INT
);

CREATE INDEX IDX_UPDATES_BY_DATE ON UPDATES(DATA);

-------------------------------------------------------------------------------
-- HASLO
-------------------------------------------------------------------------------

CREATE TABLE HASLO (HASLO VARCHAR(32));

INSERT INTO HASLO (HASLO) VALUES ('qwe123');

-------------------------------------------------------------------------------
-- TAKSOWKA
-------------------------------------------------------------------------------

CREATE TABLE TAKSOWKA (
  ID INT PRIMARY KEY,
  NRBOCZNY VARCHAR(10) UNIQUE,
  NRWYWOLAWCZY VARCHAR(10) UNIQUE,
  NAZWA VARCHAR(80),
  AKTYWNA INTEGER
);

CREATE GENERATOR TAKSOWKA_ID;
SET GENERATOR TAKSOWKA_ID TO 10000;

-------------------------------------------------------------------------------
-- POSTOJ
-------------------------------------------------------------------------------

CREATE TABLE POSTOJ (
  ID INT PRIMARY KEY,
  NAZWA VARCHAR(80)
);

CREATE GENERATOR POSTOJ_ID;
SET GENERATOR POSTOJ_ID TO 10000;

-------------------------------------------------------------------------------
-- TAKSOWKA "POSTAWIONA" NA NAPOSTOJU
-------------------------------------------------------------------------------

CREATE TABLE TAKSOWKANAPOSTOJU (
  ID INT PRIMARY KEY,
  POSTOJID INT,
  TAKSOWKAID INT UNIQUE,
  INDEKS INT
);

CREATE GENERATOR TAKSOWKANAPOSTOJU_ID;
SET GENERATOR TAKSOWKANAPOSTOJU_ID TO 10000;

-------------------------------------------------------------------------------
-- ULICA
-------------------------------------------------------------------------------

CREATE TABLE ULICA (
  ID INT PRIMARY KEY,
  NAZWA VARCHAR(80),
  POCZATEK VARCHAR(6),
  KONIEC VARCHAR(6),
  OBSZARID INT
);

CREATE GENERATOR ULICA_ID;
SET GENERATOR ULICA_ID TO 10000;

-------------------------------------------------------------------------------
-- TAXI STOPS ASSIGNED TO A STREET
-------------------------------------------------------------------------------

CREATE TABLE POSTOJNAULICY (
  ID INT PRIMARY KEY,
  ULICAID INT,
  POSTOJID INT,
  INDEKS INT
);

CREATE INDEX IDX_POSTOJNAULICY1 ON POSTOJNAULICY (POSTOJID);
CREATE INDEX IDX_POSTOJNAULICY2 ON POSTOJNAULICY (ULICAID);

CREATE GENERATOR POSTOJNAULICY_ID;
SET GENERATOR POSTOJNAULICY_ID TO 10000;

-------------------------------------------------------------------------------
-- OBSZAR
-------------------------------------------------------------------------------

CREATE TABLE OBSZAR (
  ID INT PRIMARY KEY,
  NAZWA VARCHAR(80),
  SKROT VARCHAR(16)
);

CREATE GENERATOR OBSZAR_ID;
SET GENERATOR OBSZAR_ID TO 10000;

-------------------------------------------------------------------------------
-- KURS
-------------------------------------------------------------------------------

CREATE TABLE KURS (
  ID INT PRIMARY KEY,
  FLAGS INT,
  ULICAID INT,
  ULICA VARCHAR(80),
  DOM VARCHAR(6),
  MIESZKANIE VARCHAR(6),
  TAKSOWKAID INT,
  PRZYJECIE TIMESTAMP,
  OPIS VARCHAR(255)
);

CREATE GENERATOR KURS_ID;
SET GENERATOR KURS_ID TO 10000;

CREATE INDEX IDX_KURS_BY_PRZYJECIE ON KURS(PRZYJECIE);

-------------------------------------------------------------------------------
-- KLIENT
-------------------------------------------------------------------------------

CREATE TABLE KLIENT (
  ID INT PRIMARY KEY,
  NAZWA VARCHAR(80),
  ULICA VARCHAR(80),
  DOM VARCHAR(6),
  MIESZKANIE VARCHAR(6),
  TELEFON VARCHAR(15)
);

CREATE GENERATOR KLIENT_ID;
SET GENERATOR KLIENT_ID TO 10000;

-------------------------------------------------------------------------------
-- T R I G G E R S
-------------------------------------------------------------------------------

SET TERM !! ;

-------------------------------------------------------------------------------
-- TAKSOWKA
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_TAKSOWKA_ID FOR TAKSOWKA BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(TAKSOWKA_ID, 1);
END !!

CREATE OR ALTER TRIGGER TAKSOWKA_INSERT FOR TAKSOWKA AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKA', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER TAKSOWKA_UPDATE FOR TAKSOWKA AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKA', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER TAKSOWKA_DELETE FOR TAKSOWKA AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKA', OLD.ID, 3);
  DELETE FROM TAKSOWKANAPOSTOJU WHERE TAKSOWKAID = OLD.ID;
END !!

-------------------------------------------------------------------------------
-- POSTOJ
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_POSTOJ_ID FOR POSTOJ BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(POSTOJ_ID, 1);
END !!

CREATE OR ALTER TRIGGER POSTOJ_INSERT FOR POSTOJ AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJ', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER POSTOJ_UPDATE FOR POSTOJ AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJ', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER POSTOJ_DELETE FOR POSTOJ AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJ', OLD.ID, 3);
  DELETE FROM TAKSOWKANAPOSTOJU WHERE POSTOJID = OLD.ID;
  DELETE FROM POSTOJNAULICY WHERE POSTOJID = OLD.ID;
END !!

-------------------------------------------------------------------------------
-- TAKSOWKA NA POSTOJU
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_TAKSOWKANAPOSTOJU_ID FOR TAKSOWKANAPOSTOJU BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(TAKSOWKANAPOSTOJU_ID, 1);
END !!

CREATE OR ALTER TRIGGER TAKSOWKANAPOSTOJU_INSERT FOR TAKSOWKANAPOSTOJU AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKANAPOSTOJU', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER TAKSOWKANAPOSTOJU_UPDATE FOR TAKSOWKANAPOSTOJU AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKANAPOSTOJU', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER TAKSOWKANAPOSTOJU_DELETE FOR TAKSOWKANAPOSTOJU AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'TAKSOWKANAPOSTOJU', OLD.ID, 3);
END !!

-------------------------------------------------------------------------------
-- ULICA
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_ULICA_ID FOR ULICA BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(ULICA_ID, 1);
END !!

CREATE OR ALTER TRIGGER ULICA_INSERT FOR ULICA AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'ULICA', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER ULICA_UPDATE FOR ULICA AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'ULICA', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER ULICA_DELETE FOR ULICA AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'ULICA', OLD.ID, 3);
  DELETE FROM POSTOJNAULICY WHERE ULICAID = OLD.ID;
END !!

-------------------------------------------------------------------------------
-- TAXI STOPS ASSIGNED TO A STREET
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_POSTOJNAULICY_ID FOR POSTOJNAULICY BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(POSTOJNAULICY_ID, 1);
END !!

CREATE OR ALTER TRIGGER POSTOJNAULICY_INSERT FOR POSTOJNAULICY AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJNAULICY', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER POSTOJNAULICY_UPDATE FOR POSTOJNAULICY AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJNAULICY', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER POSTOJNAULICY_DELETE FOR POSTOJNAULICY AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'POSTOJNAULICY', OLD.ID, 3);
END !!

-------------------------------------------------------------------------------
-- KURS
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_KURS_ID FOR KURS BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(KURS_ID, 1);
END !!

CREATE OR ALTER TRIGGER KURS_INSERT FOR KURS AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KURS', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER KURS_UPDATE FOR KURS AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KURS', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER KURS_DELETE FOR KURS AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KURS', OLD.ID, 3);
END !!

-------------------------------------------------------------------------------
-- KLIENT
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_KLIENT_ID FOR KLIENT BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(KLIENT_ID, 1);
END !!

CREATE OR ALTER TRIGGER KLIENT_INSERT FOR KLIENT AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KLIENT', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER KLIENT_UPDATE FOR KLIENT AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KLIENT', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER KLIENT_DELETE FOR KLIENT AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'KLIENT', OLD.ID, 3);
END !!

-------------------------------------------------------------------------------
-- S T O R E D  P R O C E D U R E S
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- TAKSOWKA
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_TAKSOWKA (NAZWA VARCHAR(80), NRBOCZNY VARCHAR(10), NRWYWOLAWCZY VARCHAR(10)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(TAKSOWKA_ID, 1);
  INSERT INTO TAKSOWKA (ID, NAZWA, NRBOCZNY, NRWYWOLAWCZY) VALUES (:NEW_ID, :NAZWA, :NRBOCZNY, :NRWYWOLAWCZY);
END !!

CREATE OR ALTER PROCEDURE DELETE_TAKSOWKA (ID INT) AS
BEGIN
  DELETE FROM TAKSOWKA WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_TAKSOWKA (ID INT, NAZWA VARCHAR(80), NRBOCZNY VARCHAR(10), NRWYWOLAWCZY VARCHAR(10)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_TAKSOWKA :NAZWA, :NRBOCZNY, :NRWYWOLAWCZY RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE TAKSOWKA SET NAZWA=:NAZWA, NRBOCZNY=:NRBOCZNY, NRWYWOLAWCZY=:NRWYWOLAWCZY WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- POSTOJ
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_POSTOJ (NAZWA VARCHAR(80)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(POSTOJ_ID, 1);
  INSERT INTO POSTOJ (ID, NAZWA) VALUES (:NEW_ID, :NAZWA);
END !!

CREATE OR ALTER PROCEDURE DELETE_POSTOJ (ID INT) AS
BEGIN
  DELETE FROM POSTOJ WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_POSTOJ (ID INT, NAZWA VARCHAR(80)) AS
BEGIN
  UPDATE POSTOJ SET NAZWA=:NAZWA WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- TAKSOWKA NA POSTOJU
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_TAKSOWKA_NA_POSTOJU (TAKSOWKAID INT, POSTOJID INT, INDEKS INT) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(TAKSOWKANAPOSTOJU_ID, 1);
  INSERT INTO TAKSOWKANAPOSTOJU (ID, TAKSOWKAID, POSTOJID, INDEKS) VALUES (:NEW_ID, :TAKSOWKAID, :POSTOJID, :INDEKS);
END !!

CREATE OR ALTER PROCEDURE DELETE_TAKSOWKA_NA_POSTOJU (TAKSOWKAID INT, POSTOJID INT) AS
BEGIN
  DELETE FROM TAKSOWKANAPOSTOJU WHERE TAKSOWKAID=:TAKSOWKAID AND POSTOJID=:POSTOJID;
END !!

CREATE EXCEPTION UNKNOWN_TAKSOWKA 'Nieznana nazwa postoju' !!

CREATE OR ALTER PROCEDURE POSTAW_TAKSOWKE_NA_POSTOJU (NRWYWOLAWCZY VARCHAR(10), POSTOJID INT) RETURNS (NEW_ID INT) AS
  DECLARE VARIABLE TAKSOWKAID INT;
  DECLARE VARIABLE INDEKS INT;
BEGIN
  SELECT ID FROM TAKSOWKA WHERE NRWYWOLAWCZY=:NRWYWOLAWCZY INTO :TAKSOWKAID;
  IF (:TAKSOWKAID IS NULL) THEN EXCEPTION UNKNOWN_TAKSOWKA;
  SELECT MAX(INDEKS) FROM TAKSOWKANAPOSTOJU WHERE POSTOJID=:POSTOJID INTO :INDEKS;
  IF (INDEKS IS NULL) THEN INDEKS = 0;
  ELSE INDEKS = INDEKS + 1;
  EXECUTE PROCEDURE ADD_TAKSOWKA_NA_POSTOJU TAKSOWKAID, POSTOJID, INDEKS RETURNING_VALUES NEW_ID;
END !!

CREATE EXCEPTION TAKSOWKA_NIENAPOSTOJU 'Wybrana taks�wka nie znajduje si� na �adnym postoju' !!

CREATE OR ALTER PROCEDURE ZDEJMIJ_TAKSOWKE_Z_POSTOJU (NRWYWOLAWCZY VARCHAR(10)) AS
  DECLARE VARIABLE TAKSOWKAID INT;
  DECLARE VARIABLE POSTOJID INT;
  DECLARE VARIABLE INDEKS INT;
BEGIN
  SELECT ID FROM TAKSOWKA WHERE NRWYWOLAWCZY=:NRWYWOLAWCZY INTO :TAKSOWKAID;
  IF (:TAKSOWKAID IS NULL) THEN EXCEPTION UNKNOWN_TAKSOWKA;
  SELECT POSTOJID FROM TAKSOWKANAPOSTOJU WHERE TAKSOWKAID=:TAKSOWKAID INTO :POSTOJID;
  IF (:POSTOJID IS NULL) THEN EXCEPTION TAKSOWKA_NIENAPOSTOJU;
  EXECUTE PROCEDURE DELETE_TAKSOWKA_NA_POSTOJU TAKSOWKAID, POSTOJID;
END !!

-------------------------------------------------------------------------------
-- ULICA
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_ULICA (NAZWA VARCHAR(80), POCZATEK VARCHAR(10), KONIEC VARCHAR(10), OBSZARID INT) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(ULICA_ID, 1);
  INSERT INTO ULICA (ID, NAZWA, POCZATEK, KONIEC, OBSZARID) VALUES (:NEW_ID, :NAZWA, :POCZATEK, :KONIEC, :OBSZARID);
END !!

CREATE OR ALTER PROCEDURE DELETE_ULICA (ID INT) AS
BEGIN
  DELETE FROM ULICA WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_ULICA (ID INT, NAZWA VARCHAR(80), POCZATEK VARCHAR(10), KONIEC VARCHAR(10), OBSZARID INT) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = :ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_ULICA :NAZWA,:POCZATEK,:KONIEC,:OBSZARID RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE ULICA SET NAZWA=:NAZWA, POCZATEK=:POCZATEK, KONIEC=:KONIEC, OBSZARID=:OBSZARID WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- OBSZAR
-------------------------------------------------------------------------------

CREATE OR ALTER TRIGGER SET_OBSZAR_ID FOR OBSZAR BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(OBSZAR_ID, 1);
END !!

CREATE OR ALTER TRIGGER OBSZAR_INSERT FOR OBSZAR AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'OBSZAR', NEW.ID, 1);
END !!

CREATE OR ALTER TRIGGER OBSZAR_UPDATE FOR OBSZAR AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'OBSZAR', OLD.ID, 2);
END !!

CREATE OR ALTER TRIGGER OBSZAR_DELETE FOR OBSZAR AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'OBSZAR', OLD.ID, 3);
END !!

CREATE OR ALTER PROCEDURE ADD_OBSZAR (NAZWA VARCHAR(80), SKROT VARCHAR(16)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(OBSZAR_ID, 1);
  INSERT INTO OBSZAR (ID, NAZWA, SKROT) VALUES (:NEW_ID, :NAZWA, :SKROT);
END !!

CREATE OR ALTER PROCEDURE DELETE_OBSZAR (ID INT) AS
BEGIN
  DELETE FROM OBSZAR WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_OBSZAR (ID INT, NAZWA VARCHAR(80), SKROT VARCHAR(10)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_OBSZAR :NAZWA, :SKROT RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE OBSZAR SET NAZWA=:NAZWA, SKROT=:SKROT WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- POSTOJ
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_POSTOJ_DO_ULICY (POSTOJID INT, ULICAID INT) RETURNS (NEW_ID INT) AS
  DECLARE VARIABLE INDEKS INT;
BEGIN
  NEW_ID = GEN_ID(POSTOJNAULICY_ID, 1);
  SELECT 
    COUNT(ID) 
  FROM 
    POSTOJNAULICY 
  WHERE
    ULICAID=:ULICAID
  INTO
    :INDEKS
  ;
  INDEKS = INDEKS + 1;
  INSERT INTO POSTOJNAULICY (ID, POSTOJID, ULICAID, INDEKS) VALUES (:NEW_ID, :POSTOJID, :ULICAID, :INDEKS);
END !!

CREATE OR ALTER PROCEDURE DELETE_POSTOJ_DO_ULICY (POSTOJID INT, ULICAID INT) AS
BEGIN
  DELETE FROM POSTOJNAULICY WHERE POSTOJID=:POSTOJID AND ULICAID=:ULICAID;
END !!

-------------------------------------------------------------------------------
-- KURS
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_KURS (FLAGS INT, ULICAID INT, ULICA VARCHAR(80), DOM VARCHAR(10), MIESZKANIE VARCHAR(10), TAKSOWKAID INT, PRZYJECIE TIMESTAMP, OPIS VARCHAR(16384)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(KURS_ID, 1);
  INSERT INTO KURS (ID, FLAGS, ULICAID, ULICA, DOM, MIESZKANIE, TAKSOWKAID, PRZYJECIE, OPIS) VALUES (:NEW_ID, :FLAGS, :ULICAID, :ULICA, :DOM, :MIESZKANIE, :TAKSOWKAID, :PRZYJECIE, :OPIS);
END !!

CREATE OR ALTER PROCEDURE DELETE_KURS (ID INT) AS
BEGIN
  DELETE FROM KURS WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_KURS (ID INT, FLAGS INT, ULICAID INT, ULICA VARCHAR(80), DOM VARCHAR(10), MIESZKANIE VARCHAR(10), TAKSOWKAID INT, PRZYJECIE TIMESTAMP, OPIS VARCHAR(16384)) AS
  DECLARE VARIABLE NEW_ID INT;
BEGIN
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_KURS :FLAGS, :ULICAID, :ULICA, :DOM, :MIESZKANIE, :TAKSOWKAID, :PRZYJECIE, :OPIS RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE KURS SET FLAGS=:FLAGS, ULICAID=:ULICAID, ULICA=:ULICA, DOM=:DOM, MIESZKANIE=:MIESZKANIE, TAKSOWKAID=:TAKSOWKAID, PRZYJECIE=:PRZYJECIE, OPIS=:OPIS WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- KLIENT
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ADD_KLIENT (ULICA VARCHAR(80), DOM VARCHAR(10), MIESZKANIE VARCHAR(10), TELEFON VARCHAR(15)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(KLIENT_ID, 1);
  INSERT INTO KLIENT (ID, ULICA, DOM, MIESZKANIE, TELEFON) VALUES (:NEW_ID, :ULICA, :DOM, :MIESZKANIE, :TELEFON);
END !!

CREATE OR ALTER PROCEDURE DELETE_KLIENT (ID INT) AS
BEGIN
  DELETE FROM KLIENT WHERE ID = :ID;
END !!

CREATE OR ALTER PROCEDURE UPDATE_KLIENT (ID INT, ULICA VARCHAR(80), DOM VARCHAR(10), MIESZKANIE VARCHAR(10), TELEFON VARCHAR(15)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_KLIENT :ULICA, :DOM, :MIESZKANIE, :TELEFON RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE KLIENT SET ULICA=:ULICA, DOM=:DOM, MIESZKANIE=:MIESZKANIE, TELEFON=:TELEFON WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- Z E S T A W I E N I A
-------------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ZESTAWIENIE (START1 TIMESTAMP, STOP1 TIMESTAMP)
RETURNS (
    NAZWA VARCHAR(80),
    NRWYWOLAWCZY VARCHAR(10),
    NRBOCZNY VARCHAR(10),
    ILOSCKURSOW INTEGER)
AS
    DECLARE VARIABLE A_ID VARCHAR(10);
BEGIN
  FOR SELECT 
    ID, NRWYWOLAWCZY, NRBOCZNY, NAZWA 
  FROM 
    TAKSOWKA 
  ORDER BY
    NRWYWOLAWCZY
  INTO
    :A_ID, :NRWYWOLAWCZY, :NRBOCZNY, :NAZWA
  DO
  BEGIN
    FOR SELECT 
      COUNT(KURS.ID) 
    FROM 
      KURS 
    WHERE 
      KURS.TAKSOWKAID=:A_ID AND KURS.PRZYJECIE BETWEEN :START1 AND :STOP1
    INTO 
      :ILOSCKURSOW
    DO SUSPEND;
  END
END !!

-------------------------------------------------------------------------------
-- E N D
-------------------------------------------------------------------------------

SET TERM ; !!

-------------------------------------------------------------------------------
-- HELPER VIEWS
-------------------------------------------------------------------------------

CREATE VIEW 
  KURSY
AS
SELECT
  KURS.ID,
  KURS.ULICA,
  KURS.ULICAID,
  KURS.DOM,
  KURS.MIESZKANIE,
  KURS.TAKSOWKAID,
  TAKSOWKA.NRWYWOLAWCZY,
  KURS.PRZYJECIE,
  KURS.FLAGS
FROM
  KURS
  LEFT JOIN TAKSOWKA ON (TAKSOWKA.ID=KURS.TAKSOWKAID)
;

CREATE VIEW TAKSOWKANAULICY(
  TAKSOWKA,
  NRWYWOLAWCZY,
  NAZWA,
  INDEKSPOSTOJU,
  ID)
AS
SELECT 
  TAKSOWKA.ID AS TAKSOWKA,
  TAKSOWKA.NRWYWOLAWCZY, 
  POSTOJ.NAZWA,
  POSTOJNAULICY.INDEKS AS INDEKSPOSTOJU,
  ULICA.ID 
FROM
  POSTOJ
  INNER JOIN TAKSOWKANAPOSTOJU ON (POSTOJ.ID = TAKSOWKANAPOSTOJU.POSTOJID)
  INNER JOIN POSTOJNAULICY ON (POSTOJ.ID = POSTOJNAULICY.POSTOJID)
  INNER JOIN TAKSOWKA ON (TAKSOWKANAPOSTOJU.TAKSOWKAID = TAKSOWKA.ID)
  INNER JOIN ULICA ON (ULICA.ID = POSTOJNAULICY.ULICAID)
ORDER BY 
  POSTOJNAULICY.INDEKS,
  TAKSOWKANAPOSTOJU.INDEKS
;

CREATE VIEW GRDKURSY (
  ID, 
  FLAGS, 
  STATUS, 
  ULICAID, 
  ULICA, 
  DOM, 
  MIESZKANIE, 
  PRZYJECIE, 
  TAKSOWKAID, 
  TAKSOWKA,
  OPIS, 
  POSTOJ1, 
  POSTOJ2, 
  POSTOJ3, 
  POSTOJ4, 
  POSTOJ5, 
  POSTOJ6, 
  POSTOJ7, 
  POSTOJ8)
AS 
SELECT
  KURS.ID AS ID,
  KURS.FLAGS AS FLAGS,
  MIN(CASE KURS.FLAGS
    WHEN 0 THEN 'NORMALNY'
    WHEN 1 THEN '(jeden)'
    WHEN 2 THEN '(dwa)'
    WHEN 3 THEN '(trzy)'
    WHEN 4 THEN '(cztery)'
    WHEN 5 THEN '(piec)'
    WHEN 6 THEN '(szesc)'
    WHEN 7 THEN '(siedem)'
  END) AS STATUS,
  KURS.ULICAID AS ULICAID,  
  KURS.ULICA AS ULICA,
  KURS.DOM AS DOM,  
  KURS.MIESZKANIE AS MIESZKANIE,  
  KURS.PRZYJECIE AS PRZYJECIE,  
  TAKSOWKA.ID AS TAKSOWKAID,
  TAKSOWKA.NRWYWOLAWCZY AS TAKSOWKA,
  OPIS,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 1 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ1,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 2 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ2,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 3 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ3,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 4 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ4,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 5 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ5,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 6 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ6,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 7 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ7,  
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 8 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ8
FROM 
  KURS
  LEFT OUTER JOIN TAKSOWKA ON (KURS.TAKSOWKAID = TAKSOWKA.ID)
  LEFT OUTER JOIN POSTOJNAULICY ON (KURS.ULICAID = POSTOJNAULICY.ULICAID)
  LEFT OUTER JOIN POSTOJ ON (POSTOJ.ID = POSTOJNAULICY.POSTOJID)
GROUP BY
  ID,
  FLAGS,
  ULICAID,  
  ULICA,
  DOM,  
  MIESZKANIE,  
  PRZYJECIE,  
  TAKSOWKAID,
  TAKSOWKA,
  OPIS
ORDER BY  
  PRZYJECIE
;

CREATE VIEW GRDAKTYWNETAKSOWKI
AS
SELECT 
  NRWYWOLAWCZY,
  AKTYWNA
FROM 
  TAKSOWKA
WHERE 
  AKTYWNA=1
ORDER BY 
  TAKSOWKA.NRWYWOLAWCZY
;

CREATE VIEW KURSYZOBSZARID (
  ID, 
  ULICA, 
  DOM, 
  MIESZKANIE, 
  PRZYJECIE, 
  TAKSOWKAID, 
  OBSZARID, 
  NRWYWOLAWCZY)
AS  
SELECT   
  KURS.ID, 
  KURS.ULICA, 
  KURS.DOM, 
  KURS.MIESZKANIE, 
  KURS.PRZYJECIE, 
  KURS.TAKSOWKAID, 
  ULICA.OBSZARID, 
  TAKSOWKA.NRWYWOLAWCZY
FROM   
  KURS    
  INNER JOIN ULICA ON (KURS.ULICAID=ULICA.ID)   
  LEFT JOIN TAKSOWKA ON (KURS.TAKSOWKAID=TAKSOWKA.ID) 
ORDER BY   
  KURS.PRZYJECIE
;

CREATE VIEW WOLANIA (
  OBSZAR, 
  NAZWA, 
  POCZATEK, 
  KONIEC, 
  POSTOJ1, 
  POSTOJ2, 
  POSTOJ3, 
  POSTOJ4, 
  POSTOJ5, 
  POSTOJ6, 
  POSTOJ7, 
  POSTOJ8) 
AS
SELECT 
  OBSZAR.NAZWA AS OBSZAR,
  ULICA.NAZWA AS NAZWA,
  ULICA.POCZATEK AS POCZATEK,
  ULICA.KONIEC AS KONIEC,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 1 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ1,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 2 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ2,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 3 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ3,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 4 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ4,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 5 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ5,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 6 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ6,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 7 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ7,
  MIN(CASE POSTOJNAULICY.INDEKS WHEN 8 THEN POSTOJ.NAZWA ELSE NULL END) AS POSTOJ8
FROM
  ULICA
  INNER JOIN POSTOJNAULICY ON (ULICA.ID = POSTOJNAULICY.ULICAID)
  INNER JOIN POSTOJ ON (POSTOJNAULICY.POSTOJID = POSTOJ.ID)
  LEFT JOIN OBSZAR ON (ULICA.OBSZARID = OBSZAR.ID)
GROUP BY
  OBSZAR,
  ULICA.NAZWA,
  ULICA.POCZATEK,
  ULICA.KONIEC
ORDER BY
  ULICA.NAZWA,
  ULICA.POCZATEK
;