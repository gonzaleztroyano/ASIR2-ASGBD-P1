DELIMITER $$
DROP TRIGGER IF EXISTS cad_prod_envio$$
CREATE TRIGGER cad_prod_envio BEFORE INSERT 
ON envio_has_material
FOR EACH ROW
BEGIN
	DECLARE local_caducidad DATE;
	SELECT material.caducidad 
		FROM material
        WHERE material.idmaterial = NEW.envio_has_material.material_idmaterial 
        INTO local_caducidad;
	IF local_caducidad < DATE_ADD(current_date(),INTERVAL 30 day) THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No se permite el flete de envíso con productos con caducidad próxima';
		SET NEW.material_idmaterial = 99;
	END IF;
END$$