DELIMITER $$
DROP EVENT IF EXISTS conta_mensual$$
CREATE EVENT conta_mensual ON SCHEDULE
EVERY 1 MONTH
STARTS "2021-12-01 04:00:00"
ENDS "2025-12-02 05:00:00"
DO
BEGIN
	CALL cobro_cuotas( );
END$$