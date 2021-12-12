DELIMITER $$
DROP TRIGGER IF EXISTS act_stock$$
CREATE TRIGGER act_stock AFTER INSERT 
ON envio_has_material
FOR EACH ROW
BEGIN
	UPDATE material 
		SET material.cantidad_en_stock = material.cantidad_en_stock - NEW.envio_has_material.cantidad
        WHERE material.idmaterial = NEW.envio_has_material.material_idmaterial;
END$$