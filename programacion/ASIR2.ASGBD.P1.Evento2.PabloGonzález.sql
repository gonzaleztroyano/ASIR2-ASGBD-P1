CREATE TABLE `contabilidad_mensual` (
  `anio` INT NOT NULL,
  `mes` INT NOT NULL,
  `ingresos` INT NOT NULL,
  PRIMARY KEY (`anio`, `mes`))
ENGINE = InnoDB;

DELIMITER $$
DROP EVENT IF EXISTS conta_mensual$$
CREATE EVENT conta_mensual ON SCHEDULE
EVERY 1 MONTH
STARTS "2021-12-15 05:00:00"
ENDS "2025-12-15 05:00:00"
DO
BEGIN
	DECLARE local_suma INT;
	SELECT SUM(importe)
    FROM casicruzroja.cuotas
    WHERE anio_mes = (SELECT DATE_FORMAT(NOW(), '%y%m')) 
    INTO local_suma;

	INSERT INTO contabilidad_mensual 
    VALUES (CAST(DATE_FORMAT(NOW(), '%y') AS UNSIGNED),
			CAST(DATE_FORMAT(NOW(), '%m') AS UNSIGNED),
			local_suma);
END$$
