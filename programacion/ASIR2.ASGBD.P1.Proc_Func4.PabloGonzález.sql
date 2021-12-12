-- Función histórica:
DELIMITER $$
DROP FUNCTION IF EXISTS total_cuotas_sede_hist$$
CREATE FUNCTION total_cuotas_sede_hist(in_sede INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE total_sede INT;
	SELECT SUM(c.importe)
	FROM cuotas as c, socix as s
	WHERE c.socio_dni_socio = s.dni_socio
	GROUP BY s.sede_idsede
	HAVING sede_idsede=in_sede INTO total_sede;
    RETURN total_sede;
END $$

SELECT total_cuotas_sede_hist(10)$$
