DELIMITER $$
DROP FUNCTION IF EXISTS deduccion_hacienda$$
CREATE FUNCTION deduccion_hacienda (in_anio CHAR(4), in_socix VARCHAR(9))
RETURNS DECIMAL(6,2)
DETERMINISTIC
BEGIN
	DECLARE total_anio INT;
    DECLARE a_deducir DECIMAL(6,2);
    SELECT sum_donacion_anio('2020',in_socix) INTO total_anio;
    
    IF total_anio < 151 THEN
		SET a_deducir = total_anio * 0.75;
		RETURN a_deducir;
    END IF;
    IF total_anio > 151 THEN
		SET a_deducir = ((150*0.75)+((total_anio-150)*0.30));
        RETURN a_deducir;
	END IF;
END $$

SELECT deduccion_hacienda('2020','24724662F')$$

SELECT sum_donacion_anio('2020','24724662F')$$