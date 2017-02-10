--1
SELECT *
FROM tvid_afiliados
WHERE CDAFILIADO
NOT IN
  (
    SELECT CDAFILIADO
    FROM tvid_clasificacion AS A, tvid_movie AS B, tvid_prestamos AS C
    WHERE DSCLASIFICACION = 'ACCION' AND
    A.CDCLASIFICACION =  B.CDCLASIFICACION AND
  B.CDMOVIE = C.CDMOVIE
  )
AND
CDAFILIADO IN ( SELECT CDAFILIADO FROM tvid_prestamos);


--2
SELECT DSMOVIE
FROM tvid_movies_x_local, tvid_movie
WHERE tvid_movies_x_local.CDMOVIE =  tvid_movie.CDMOVIE
GROUP BY tvid_movie.CDMOVIE
HAVING COUNT(*) = (SELECT COUNT(*) AS NRO_TOTAL FROM tvid_local)

--Punto 3
SELECT DSAFILIADO
FROM tvid_prestamos P, tvid_afiliados A
WHERE
  P.FEENTREGA_ESPERADA > '2015-08-17'
  AND
  P.FEENTREGADA_REAL IS NULL
  AND
  P.CDAFILIADO = A.CDAFILIADO
GROUP BY DSAFILIADO
HAVING COUNT(*) > 1

--Punto 3.1
SELECT DSAFILIADO
FROM tvid_prestamos P, tvid_afiliados A
WHERE
  P.FEENTREGA_ESPERADA > DATE_SUB(CURDATE(),INTERVAL 1 DAY)
  AND
  P.FEENTREGADA_REAL IS NULL
  AND
  P.CDAFILIADO = A.CDAFILIADO
GROUP BY DSAFILIADO
HAVING COUNT(*) > 1

--4
SELECT DSMOVIE,DSCLASIFICACION
FROM tvid_movie
LEFT JOIN tvid_clasificacion
ON tvid_movie.CDCLASIFICACION = tvid_clasificacion.CDCLASIFICACION
