DELIMITER $$

DROP FUNCTION IF EXISTS sum_donacion_anio$$
CREATE FUNCTION sum_donacion_anio(in_anio CHAR(4), in_socix VARCHAR(9))
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE resultado INT;
	SELECT SUM(importe)
    FROM cuotas
    WHERE LEFT(CONVERT(anio_mes,CHAR(4)),2) = RIGHT(in_anio,2)
    GROUP BY socio_dni_socio
    HAVING socio_dni_socio = in_socix INTO resultado;
    RETURN resultado;
END $$

SELECT sum_donacion_anio('2020','12228755T')$$