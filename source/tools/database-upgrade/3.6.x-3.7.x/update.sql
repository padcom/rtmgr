DROP VIEW TAKSOWKANAULICY;

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
