DELIMITER $$
DROP FUNCTION IF EXISTS mat_don_colab$$
CREATE FUNCTION mat_don_colab (colab_intro VARCHAR(10))
RETURNS INT
DETERMINISTIC 
BEGIN
DECLARE local_total INT;
SELECT SUM(cantidad) AS total
FROM colaborador_dona_material
GROUP BY colaborador_nif
HAVING colaborador_nif = colab_intro
INTO local_total;

IF colab_intro = 'A14764794' THEN
	SET local_total = local_total *1.20;
    RETURN local_total;
	END IF;
    
IF colab_intro = 'A14764795' THEN
	SET local_total = local_total *0.75;
    RETURN local_total;
	END IF;    
RETURN local_total;
END$$

SELECT mat_don_colab('A14764795')$$