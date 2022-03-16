CREATE FUNCTION `setMachineWorker`(worker_id INT, machine_id INT) RETURNS bit(1)
    DETERMINISTIC
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		RETURN 0;
	END;
    UPDATE machine SET ActiveWorkerID = NULL,UpdatedAt = NOW() WHERE ActiveWorkerID = worker_id; 
    UPDATE machine SET ActiveWorkerID = worker_id,UpdatedAt = NOW() WHERE MachineID = machine_id;
RETURN 1;
END






-- ===========================================================
-- ===========================================================

-- Stored Procedures

CREATE DEFINER=`root`@`localhost` PROCEDURE `setMachineDown`(
IN machine_id INT,
IN down_reason VARCHAR(9999),
OUT message VARCHAR(1024),
OUT code INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MESSAGE_TEXT = MESSAGE_TEXT;
		SET message =  @MESSAGE_TEXT;
		SET code = @ERRNO;
		ROLLBACK; 
    END;
    
    START TRANSACTION;
		INSERT INTO machine_down_time(MachineID,DownReason)
        VALUES(machine_id,down_reason);
        
        UPDATE machine
        SET IsMachineDown =1
        WHERE MachineID = machine_id;
    COMMIT;
    SET message =  'Success';
	SET code = 0;
END



CREATE DEFINER=`root`@`localhost` PROCEDURE `setMahineUp`(
IN machine_id INT,
OUT message VARCHAR(1024),
OUT code INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MESSAGE_TEXT = MESSAGE_TEXT;
		SET message = @MESSAGE_TEXT;
        SET code = @ERRNO;
    END;
    
    START TRANSACTION;
		UPDATE machine_down_time
        SET EndTime = CURRENT_TIMESTAMP
        WHERE MachineID = machine_id AND EndTime IS NULL;
        
        UPDATE machine 
        SET IsMachineDown = 0
        WHERE MachineID = machine_id;
    COMMIT;
	
    SET message = 'Success';
	SET code = 0;    
    
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `setMachineWorker`(
IN worker_id INT, 
IN machine_id INT, 
OUT message VARCHAR(1024), 
OUT code INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		GET DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MESSAGE_TEXT = MESSAGE_TEXT;
		SET message =  @MESSAGE_TEXT;
		SET code = @ERRNO;
		ROLLBACK;
	END;
    
    START TRANSACTION;
    UPDATE machine SET ActiveWorkerID = NULL,UpdatedAt = NOW() WHERE ActiveWorkerID = worker_id; 
    UPDATE machine SET ActiveWorkerID = worker_id,UpdatedAt = NOW() WHERE MachineID = machine_id;
	COMMIT;
    
	SET message = 'Success';
	SET code = 0;
END








CREATE DEFINER=`root`@`localhost` PROCEDURE `updateWorkerTodayProduction`(
IN worker_id INT,
 IN production_pieces INT,
 OUT total_pieces INT,
 OUT message VARCHAR(30),
 OUT code INT)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @ERRNO = MYSQL_ERRNO, @MESSAGE_TEXT = MESSAGE_TEXT;
		SET message =  @MESSAGE_TEXT;
		SET code = @ERRNO;
		ROLLBACK; 
	END; 

	START TRANSACTION;
		UPDATE Worker
		SET TodayProduction = (ifnull(TodayProduction, 0) + production_pieces),UpdatedAt = now()
		WHERE WorkerID = worker_id;
	COMMIT;
	SELECT TodayProduction INTO total_pieces
	FROM worker
	WHERE WorkerID = worker_id;

	SET message = 'Success';
	SET code = 0;
END