CREATE TABLE `contabilidad_mensual_sede` (
  `anio` INT NOT NULL,
  `mes` INT NOT NULL,
  `sede` INT NOT NULL,
  `ingresos` INT NOT NULL,
  PRIMARY KEY (`anio`, `mes`,`sede`))
ENGINE = InnoDB;

DELIMITER $$
DROP PROCEDURE IF EXISTS proc_conta_mensual_sede$$
CREATE PROCEDURE proc_conta_mensual_sede()
BEGIN
	DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
    DECLARE local_idsede INT DEFAULT 0;
    DECLARE local_suma_sede INT DEFAULT 0;
	DECLARE cursor_conta_mensual_sede CURSOR FOR
		SELECT DISTINCT idsede FROM sede;
	SELECT found_rows() INTO num_filas;
	OPEN cursor_conta_mensual_sede;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
			FETCH cursor_conta_mensual_sede INTO local_idsede;
            SELECT SUM(importe)
            FROM cuotas as c, socix as s
            WHERE c.socio_dni_socio = s.dni_socio
				AND	anio_mes = concat(
				(CAST(DATE_FORMAT(NOW(), '%y') AS UNSIGNED),
				CAST(DATE_FORMAT(NOW(), '%m') AS UNSIGNED)))
                AND socix.sede_idsede = local_idsede 
			INTO local_suma_sede;
            INSERT INTO contabilidad_mensual_sede VALUES 
				(CAST(DATE_FORMAT(NOW(), '%y') AS UNSIGNED),
				CAST(DATE_FORMAT(NOW(), '%m') AS UNSIGNED),
                local_idsede,
                local_suma_sede);
	SET cuenta_bucle = cuenta_bucle + 1;
        END;
    END WHILE;
    CLOSE cursor_conta_mensual_sede;
END $$
CALL proc_conta_mensual_sede$$
