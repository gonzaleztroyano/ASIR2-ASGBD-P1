DELIMITER $$
DROP PROCEDURE IF EXISTS correct_form_tipo_cuota_1$$
CREATE PROCEDURE correct_form_tipo_cuota_1()
BEGIN
	UPDATE socix 
		SET cuota_tipo = 'mensual'
			AND cuota_importe = 20
		WHERE cuota_tipo = 'testBB';
END$$