DELIMITER $$
DROP TRIGGER IF EXISTS limit_fecha_mision$$
CREATE TRIGGER limit_fecha_mision BEFORE INSERT ON mision
FOR EACH ROW
BEGIN
	IF (SELECT idmision 
		FROM mision 
        WHERE equipo_id_equipo = NEW.equipo_id_equipo
        AND date_add(fecha_fin, INTERVAL 3 MONTH) < current_date) IS NOT NULL THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No se permite el envío de equipos en misiones, con misiones recientes.';
	END IF;
END $$