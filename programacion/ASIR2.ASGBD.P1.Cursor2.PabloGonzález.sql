DELIMITER $$
DROP PROCEDURE IF EXISTS cobro_cuotas$$
CREATE PROCEDURE  cobro_cuotas( )
BEGIN
    DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
    DECLARE local_dni_socio varchar(9);
    DECLARE local_cuota_tipo varchar(45);
    DECLARE local_cuota_importe INT;
	DECLARE cursor_cobro_cuotas CURSOR FOR
	SELECT dni_socio,cuota_tipo,cuota_importe
		FROM socix;
    SELECT found_rows() INTO num_filas;
    OPEN cursor_cobro_cuotas;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
            FETCH cursor_cobro_cuotas INTO local_dni_socio,local_cuota_tipo,local_cuota_importe;
            -- Todos los meses, tipo mensual se cobra.
            IF local_cuota_tipo = 'mensual' THEN
				INSERT INTO cuotas VALUES (DATE_FORMAT(NOW(), '%y%m'),local_dni_socio,local_cuota_importe);
            END IF;
            -- Los meses que sean 1,3,6,9, se cobran las trimestrales
            IF ((local_cuota_tipo = 'trimestral') AND (MONTH(current_date()) = (1 OR 3 OR 6 OR 9) )) THEN
				INSERT INTO cuotas VALUES (DATE_FORMAT(NOW(), '%y%m'),local_dni_socio,local_cuota_importe);
            END IF;
            -- Los meses 6, se cobran las anuales
            IF ((local_cuota_tipo = 'anual') AND (MONTH(current_date()=6))) THEN
				INSERT INTO cuotas VALUES (DATE_FORMAT(NOW(), '%y%m'),local_dni_socio,local_cuota_importe);
            END IF;
	SET cuenta_bucle = cuenta_bucle + 1;
        END;
    END WHILE;
    CLOSE cursor_cobro_cuotas;
END $$
