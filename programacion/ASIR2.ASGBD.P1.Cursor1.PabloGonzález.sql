DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_historico_cuotas$$
CREATE PROCEDURE  actualizar_historico_cuotas( )
BEGIN
    DECLARE num_filas INT DEFAULT 0;
    DECLARE cuenta_bucle INT DEFAULT 0;
    DECLARE anio_mes_local INT;
    DECLARE local_suma INT;
	DECLARE cursor_anio_mes_cuotas CURSOR FOR
        SELECT DISTINCT anio_mes FROM cuotas;
    SELECT found_rows() INTO num_filas;
    OPEN cursor_anio_mes_cuotas;
    WHILE cuenta_bucle < num_filas DO
		BEGIN 
            FETCH cursor_anio_mes_cuotas INTO anio_mes_local;
            SELECT SUM(importe)
				FROM cuotas
                WHERE anio_mes = anio_mes_local
                GROUP BY anio_mes
                INTO local_suma;
		INSERT INTO contabilidad_mensual 
        VALUES (CONVERT(LEFT(anio_mes_local,2),UNSIGNED),
				CONVERT(RIGHT(anio_mes_local,2),UNSIGNED),
                local_suma);
		SET cuenta_bucle = cuenta_bucle + 1;
        END;
    END WHILE;
    CLOSE cursor_anio_mes_cuotas;
END $$