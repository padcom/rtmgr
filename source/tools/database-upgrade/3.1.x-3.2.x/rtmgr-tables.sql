-------------------------------------------------------------------------------
-- ULICA
-------------------------------------------------------------------------------

ALTER TABLE ULICA ADD AREAID INT;

-------------------------------------------------------------------------------
-- AREA
-------------------------------------------------------------------------------

CREATE TABLE AREA (
  ID INT PRIMARY KEY,
  NAME VARCHAR(80),
  SHORTCUT VARCHAR(16)
);

CREATE GENERATOR AREA_ID;
SET GENERATOR AREA_ID TO 10000;

-------------------------------------------------------------------------------
-- T R I G G E R S
-------------------------------------------------------------------------------

SET TERM !! ;

CREATE TRIGGER SET_AREA_ID FOR AREA BEFORE INSERT AS
BEGIN
  IF (NEW.ID = 0) THEN
    NEW.ID = GEN_ID(AREA_ID, 1);
END !!

CREATE TRIGGER AREA_INSERT FOR AREA AFTER INSERT AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'AREA', NEW.ID, 1);
END !!

CREATE TRIGGER AREA_UPDATE FOR AREA AFTER UPDATE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'AREA', OLD.ID, 2);
END !!

CREATE TRIGGER AREA_DELETE FOR AREA AFTER DELETE AS
BEGIN
  INSERT INTO UPDATES (DATA, TABLENAME, ID, OPERATION) VALUES (CURRENT_TIMESTAMP, 'AREA', OLD.ID, 3);
END !!

CREATE PROCEDURE ADD_AREA (NAME VARCHAR(80), SHORTCUT VARCHAR(16)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(AREA_ID, 1);
  INSERT INTO AREA (ID, NAME, SHORTCUT) VALUES (:NEW_ID, :NAME, :SHORTCUT);
END !!

CREATE PROCEDURE DELETE_AREA (ID INT) AS
BEGIN
  DELETE FROM AREA WHERE ID = :ID;
END !!

CREATE PROCEDURE UPDATE_AREA (ID INT, NAME VARCHAR(80), SHORTCUT VARCHAR(10)) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_AREA :NAME, :SHORTCUT RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE AREA SET NAME=:NAME, SHORTCUT=:SHORTCUT WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- ULICA
-------------------------------------------------------------------------------

ALTER PROCEDURE ADD_ULICA (NAZWA VARCHAR(80), POCZATEK VARCHAR(10), KONIEC VARCHAR(10), AREAID INT) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = GEN_ID(ULICA_ID, 1);
  INSERT INTO ULICA (ID, NAZWA, POCZATEK, KONIEC, AREAID) VALUES (:NEW_ID, :NAZWA, :POCZATEK, :KONIEC, :AREAID);
END !!

ALTER PROCEDURE UPDATE_ULICA (ID INT, NAZWA VARCHAR(80), POCZATEK VARCHAR(10), KONIEC VARCHAR(10), AREAID INT) RETURNS (NEW_ID INT) AS
BEGIN
  NEW_ID = :ID;
  IF (ID = 0) THEN
    EXECUTE PROCEDURE ADD_ULICA :NAZWA,:POCZATEK,:KONIEC,:AREAID RETURNING_VALUES :NEW_ID;
  ELSE
    UPDATE ULICA SET NAZWA=:NAZWA, POCZATEK=:POCZATEK, KONIEC=:KONIEC, AREAID=:AREAID WHERE ID=:ID;
END !!

-------------------------------------------------------------------------------
-- E N D
-------------------------------------------------------------------------------

SET TERM ; !!

-------------------------------------------------------------------------------
-- Views
-------------------------------------------------------------------------------

CREATE VIEW KURSYZAREAID (
  ID, 
  ULICA, 
  DOM, 
  MIESZK, 
  PRZYJECIE, 
  TAKSOWKAID, 
  AREAID, 
  NRWYWOL)
AS  
SELECT   
  KURS.ID, 
  KURS.ULICA, 
  KURS.DOM, 
  KURS.MIESZK, 
  KURS.PRZYJECIE, 
  KURS.TAKSOWKAID, 
  ULICA.AREAID, 
  TAKSOWKA.NRWYWOL  
FROM   
  KURS    
  INNER JOIN ULICA ON (KURS.ULICAID=ULICA.ID)   
  LEFT JOIN TAKSOWKA ON (KURS.TAKSOWKAID=TAKSOWKA.ID) 
ORDER BY   
  KURS.PRZYJECIE;


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
  AREA.NAME AS OBSZAR,
--  ULICA.ID,
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
  LEFT JOIN AREA ON (ULICA.AREAID = AREA.ID)
GROUP BY
  OBSZAR,
--  ULICA.ID,
  ULICA.NAZWA,
  ULICA.POCZATEK,
  ULICA.KONIEC
ORDER BY
  ULICA.NAZWA,
  ULICA.POCZATEK
  