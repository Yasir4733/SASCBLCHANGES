-- USE [SooperWizerReplica]
-- GO

-- DECLARE	@return_value int,
-- 		@message varchar(1024),
-- 		@code int

-- EXEC	@return_value = [dbo].[uspSetMachineWorker] 
-- 		@worker_id = 4, 
-- 		@machine_id = 4,
-- 		@message = @message OUTPUT,
-- 		@code = @code OUTPUT

-- SELECT	@message as N'@message',
-- 		@code as N'@code'

-- SELECT	'Return Value' = @return_value

-- GO

--  UPDATE [Essentials].[Machine]
--  SET ActiveWorkerID = 3
--  WHERE MachineID = 3;

--  UPDATE [Essentials].[Worker]
--   SET TodayProduction = NULL
--   WHERE WorkerID = 3;

--   INSERT INTO [Essentials].[AllocatedMachines] (WorkerID,MachineID)
--   VALUES (1,1),(1,2),(1,3),(1,4);

--   INSERT INTO [Essentials].[MachineOperations](MachineID,OperationID)
--   VALUES(1,1),(1,2),(1,3),(1,4);

-- INSERT INTO [Data].[WorkerScan](WorkerID,LineID,MachineID)
-- VALUES(1,1,1),(2,1,2),(3,1,3),(4,1,4);

--   INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)
--   VALUES(1,1),(1,2),(1,6),(1,7),(2,1),(2,2),(2,6),(2,7),(2,5),(2,4);

-- CREATE TRIGGER [Essentials].[TR_Machine_Update_W]
--        ON [Essentials].[Worker]
-- AFTER UPDATE
-- AS
-- BEGIN
--        SET NOCOUNT ON;
 
--        DECLARE @WorkerID INT;
 
--        SELECT @WorkerID = INSERTED.WorkerID       
--        FROM INSERTED;

--        UPDATE [Essentials].[Machine] 
--        SET ActiveWorkerID = NULL,MachineCode = 'Test-1',UpdatedAt = GETDATE() 
--        WHERE ActiveWorkerID = @WorkerID;
-- END

-- SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com');



-- USE [SooperWizerReplica]
-- GO
-- /****** Object:  Trigger [Essentials].[TR_Machine_Update_W]    Script Date: 3/10/2022 11:40:45 AM ******/
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
--  ALTER TRIGGER [Essentials].[TR_Machine_Update_W]
--         ON [Essentials].[Worker]
--  AFTER UPDATE,DELETE
--  AS
--  BEGIN
--         SET NOCOUNT ON;
--         DECLARE @WorkerID INT;
-- 		WITH cte1 AS(
--                 SELECT 
--                     d.WorkerID AS DeletedID
--                     ,i.WorkerID AS InsertedID
--                 FROM Deleted d
--                 FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID
--             ) 
-- 			SELECT @WorkerID =  COALESCE(InsertedID,DeletedID) FROM cte1;
		 
--         UPDATE [Essentials].[Machine] 
--         SET MachineCode = 'TempCode'
--         WHERE ActiveWorkerID = @WorkerID;

--         UPDATE [Essentials].[Machine] 
--         SET ActiveWorkerID = NULL,MachineCode = 'Test-1',UpdatedAt = GETDATE() 
--         WHERE ActiveWorkerID = @WorkerID;
--  END;


-- MACHINEDOWN SP
USE [SooperWizerReplica]
GO
/****** Object:  StoredProcedure [Essentials].[uspSetMachineDown]    Script Date: 3/10/2022 12:28:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Essentials].[uspSetMachineDown](@machine_id INT,@down_reason VARCHAR(MAX), @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

		    INSERT INTO [Essentials].[MachineDownTime](MachineID,DownReason)
        VALUES(@machine_id,@down_reason);
        
		  	UPDATE [Essentials].[Machine]
			  SET IsMachineDown =1,ActiveWorkerID = NULL

		  	WHERE MachineID = @machine_id;

      COMMIT TRAN
	  
	    SET @message =  'Success';
	    SET @code = 0;
    END TRY

  BEGIN CATCH

    SET @message = ERROR_MESSAGE();
	  SET @code = ERROR_NUMBER();
    ROLLBACK;

  END CATCH


-- SELECT @message AS Messege, @code AS ErrorCode;

END


-- SP INSERT WORKERSCAN

USE [SooperWizer]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/10/2022 5:59:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Data].[uspInsertWorkerScan](@worker_id INT,@machine_id INT,@line_id INT,@extras VARCHAR(1024),@code INT OUT ,
@message VARCHAR(1024) OUT,@latest_worker_scan_id INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

            BEGIN TRAN
	       UPDATE [Data].[WorkerScan]
	       SET EndedAt = GETDATE(),HasExpired = 1
	       WHERE (MachineID = @machine_id OR WorkerID = @worker_id) AND EndedAt IS NULL;
		      
	       INSERT INTO [Data].[WorkerScan](WorkerID, MachineID, LineID, Extras)
              VALUES(@worker_id, @machine_id, @line_id,@extras);

	       SELECT @latest_worker_scan_id = SCOPE_IDENTITY();

              INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)
	       SELECT @latest_worker_scan_id, OperationID FROM [Essentials].[MachineOperations]
	       WHERE MachineID = @machine_id;

       COMMIT TRAN
              SET @message = 'Success';
	       SET @code = 0;
    
  
  END TRY

  BEGIN CATCH

       SET @message = ERROR_MESSAGE();
	SET @code = ERROR_NUMBER();
       ROLLBACK;
  
  END CATCH

END










-- WORKER TRIGGER

USE [SooperWizerReplica]
GO
/****** Object:  Trigger [Essentials].[TR_Machine_Update_W]    Script Date: 3/10/2022 11:17:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [Essentials].[TR_Update_Machine_Worker]
       ON [Essentials].[Worker]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;

	WITH cte1 AS(
              SELECT 
                     d.WorkerID AS DeletedID,
                     i.WorkerID AS InsertedID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID
              ) 
		SELECT @WorkerID =  COALESCE(InsertedID,DeletedID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID;
END;





-- AllocatedMachines TRIGGER
USE [SooperWizerReplica]
GO
/****** Object:  Trigger [Essentials].[TR_Machine_Update_AM]    Script Date: 3/10/2022 12:04:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Trigger [Essentials].[TR_Machine_Update_W]    Script Date: 3/10/2022 11:17:59 AM ******/

CREATE TRIGGER [Essentials].[TR_Machine_Update_AllocatedMachines]
        ON [Essentials].[AllocatedMachines]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;
	DECLARE @MachineID INT;
	WITH cte1 AS(
              SELECT
                     d.WorkerID AS DeletedID,
		       i.WorkerID AS InsertedID,
		       d.MachineID AS DeletedMID,
		       i.MachineID AS INSERTEDMID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID AND d.MachineID = i.MachineID
              ) 
		SELECT 
		       @WorkerID =  COALESCE(InsertedID,DeletedID),
		       @MachineID =  COALESCE(InsertedMID,DeletedMID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID AND MachineID = @MachineID;
 END;



-- MACHINE OPERATIONS TRIGGER
USE [SooperWizerReplica];
GO


CREATE TRIGGER [Essentials].[TR_UpdateMachine_MachineOperations]
	ON [Essentials].[MachineOperations]
AFTER UPDATE,DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MachineID INT;
	WITH cte AS(
		SELECT 
	       	d.MachineID AS DeletedID,
			i.MachineID AS InsertedID
		FROM 
		Deleted d
		FULL OUTER HASH JOIN Inserted i ON d.MachineID = i.MachineID
		)
		SELECT	@MachineID = COALESCE(DeletedID,InsertedID) FROM cte;

	UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE MachineID = @MachineID;
END;
GO




--UPDATE [Data].[WorkerOperations]
--SET OperationID = 5
--WHERE WorkerOperationsID =1;

  
-- DECLARE @WorkerID INT;
-- DECLARE @WorkerScanID INT;
-- SET @WorkerScanID = 24;

-- SELECT @WorkerID = WorkerID
-- FROM [Data].[WorkerScan]
-- WHERE WorkerScanID = @WorkerScanID;

-- UPDATE [Essentials].[Machine] 
-- SET ActiveWorkerID = NULL, UpdatedAt = GETDATE() 
-- WHERE ActiveWorkerID = @WorkerID;

-- WorkerOperations OPERATIONSS TRIGGER

-- USE [SooperWizerReplica];
-- GO


--   CREATE TRIGGER [Data].[TR_UpdateMachine_WorkerOperations]
-- 	ON [Data].[WorkerOperations]
-- 	AFTER UPDATE,DELETE
--   AS
--   BEGIN
-- 	SET NOCOUNT ON;
-- 	DECLARE @WorkerScanID INT;
--        DECLARE @WorkerID INT;

-- 	WITH cte AS(
-- 				SELECT 
-- 					d.WorkerScanID AS DeletedID,
-- 					i.WorkerScanID AS InsertedID
-- 				FROM 
-- 					Deleted d
-- 					FULL OUTER HASH JOIN Inserted i ON d.WorkerScanID = i.WorkerScanID
-- 				)
-- 				SELECT
-- 					@WorkerScanID = COALESCE(DeletedID,InsertedID) FROM cte;


--        SELECT @WorkerID = WorkerID
--        FROM [Data].[WorkerScan]
--        WHERE WorkerScanID = @WorkerScanID;

-- 	UPDATE [Essentials].[Machine] 
--        SET ActiveWorkerID = NULL, UpdatedAt = GETDATE() 
--        WHERE ActiveWorkerID = @WorkerID;
--   END;
--   GO



-- ===================================================
-- ===================================================

--- FINAL




-- WORKER TRIGGER

USE [SooperWizerReplica]
GO

CREATE TRIGGER [Essentials].[TR_Update_Machine_Worker]
       ON [Essentials].[Worker]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;

	WITH cte1 AS(
              SELECT 
                     d.WorkerID AS DeletedID,
                     i.WorkerID AS InsertedID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID
              ) 
			  SELECT @WorkerID =  COALESCE(InsertedID,DeletedID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID;
END;
GO




-- AllocatedMachines TRIGGER
USE [SooperWizerReplica]
GO
CREATE TRIGGER [Essentials].[TR_Machine_Update_AllocatedMachines]
        ON [Essentials].[AllocatedMachines]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;
	DECLARE @MachineID INT;
	WITH cte1 AS(
              SELECT
                     d.WorkerID AS DeletedID,
		       i.WorkerID AS InsertedID,
		       d.MachineID AS DeletedMID,
		       i.MachineID AS INSERTEDMID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID AND d.MachineID = i.MachineID
              ) 
			SELECT 
		       @WorkerID =  COALESCE(InsertedID,DeletedID),
		       @MachineID =  COALESCE(InsertedMID,DeletedMID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID AND MachineID = @MachineID;
 END;
 GO


-- MACHINE OPERATIONS TRIGGER
USE [SooperWizerReplica];
GO


CREATE TRIGGER [Essentials].[TR_UpdateMachine_MachineOperations]
	ON [Essentials].[MachineOperations]
AFTER UPDATE,DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MachineID INT;
	WITH cte AS(
		SELECT 
	       	d.MachineID AS DeletedID,
			i.MachineID AS InsertedID
		FROM 
		Deleted d
		FULL OUTER HASH JOIN Inserted i ON d.MachineID = i.MachineID
		)
		SELECT	@MachineID = COALESCE(DeletedID,InsertedID) FROM cte;

	UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE MachineID = @MachineID;
END;
GO




-- ===============================================
-- ===============================================

-- ApperalSooperWizer

-- WORKER TRIGGER

USE [ApperalSooperWizer]
GO

CREATE TRIGGER [Essentials].[TR_Update_Machine_Worker]
       ON [Essentials].[Worker]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;

	WITH cte1 AS(
              SELECT 
                     d.WorkerID AS DeletedID,
                     i.WorkerID AS InsertedID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID
              ) 
			  SELECT @WorkerID =  COALESCE(InsertedID,DeletedID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID;
END;
GO




-- AllocatedMachines TRIGGER
USE [ApperalSooperWizer]
GO
CREATE TRIGGER [Essentials].[TR_Machine_Update_AllocatedMachines]
        ON [Essentials].[AllocatedMachines]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;
	DECLARE @MachineID INT;
	WITH cte1 AS(
              SELECT
                     d.WorkerID AS DeletedID,
		       i.WorkerID AS InsertedID,
		       d.MachineID AS DeletedMID,
		       i.MachineID AS INSERTEDMID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID AND d.MachineID = i.MachineID
              ) 
			SELECT 
		       @WorkerID =  COALESCE(InsertedID,DeletedID),
		       @MachineID =  COALESCE(InsertedMID,DeletedMID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID AND MachineID = @MachineID;
 END;
 GO


-- MACHINE OPERATIONS TRIGGER
USE [ApperalSooperWizer];
GO


CREATE TRIGGER [Essentials].[TR_UpdateMachine_MachineOperations]
	ON [Essentials].[MachineOperations]
AFTER UPDATE,DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MachineID INT;
	WITH cte AS(
		SELECT 
	       	d.MachineID AS DeletedID,
			i.MachineID AS InsertedID
		FROM 
		Deleted d
		FULL OUTER HASH JOIN Inserted i ON d.MachineID = i.MachineID
		)
		SELECT	@MachineID = COALESCE(DeletedID,InsertedID) FROM cte;

	UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE MachineID = @MachineID;
END;
GO


-- =================================================
-- =================================================

-- SooperWizer

-- WORKER TRIGGER

USE [SooperWizer]
GO

CREATE TRIGGER [Essentials].[TR_Update_Machine_Worker]
       ON [Essentials].[Worker]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;

	WITH cte1 AS(
              SELECT 
                     d.WorkerID AS DeletedID,
                     i.WorkerID AS InsertedID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID
              ) 
			  SELECT @WorkerID =  COALESCE(InsertedID,DeletedID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID;
END;
GO




-- AllocatedMachines TRIGGER
USE [SooperWizer]
GO
CREATE TRIGGER [Essentials].[TR_Machine_Update_AllocatedMachines]
        ON [Essentials].[AllocatedMachines]
AFTER UPDATE,DELETE
AS
BEGIN
       SET NOCOUNT ON;
       DECLARE @WorkerID INT;
	DECLARE @MachineID INT;
	WITH cte1 AS(
              SELECT
                     d.WorkerID AS DeletedID,
		       i.WorkerID AS InsertedID,
		       d.MachineID AS DeletedMID,
		       i.MachineID AS INSERTEDMID
              FROM Deleted d
              FULL OUTER HASH JOIN Inserted i ON i.WorkerID = d.WorkerID AND d.MachineID = i.MachineID
              ) 
			SELECT 
		       @WorkerID =  COALESCE(InsertedID,DeletedID),
		       @MachineID =  COALESCE(InsertedMID,DeletedMID) FROM cte1;
		 

       UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE ActiveWorkerID = @WorkerID AND MachineID = @MachineID;
 END;
 GO


-- MACHINE OPERATIONS TRIGGER
USE [SooperWizer];
GO


CREATE TRIGGER [Essentials].[TR_UpdateMachine_MachineOperations]
	ON [Essentials].[MachineOperations]
AFTER UPDATE,DELETE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @MachineID INT;
	WITH cte AS(
		SELECT 
	       	d.MachineID AS DeletedID,
			i.MachineID AS InsertedID
		FROM 
		Deleted d
		FULL OUTER HASH JOIN Inserted i ON d.MachineID = i.MachineID
		)
		SELECT	@MachineID = COALESCE(DeletedID,InsertedID) FROM cte;

	UPDATE [Essentials].[Machine] 
       SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() 
       WHERE MachineID = @MachineID;
END;
GO




-- =============================================
-- =============================================


USE [ApperalSooperWizer]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/12/2022 12:31:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Data].[uspInsertWorkerScan](@worker_id INT,@machine_id INT,@line_id INT,@extras VARCHAR(1024),@message VARCHAR(1024) OUT,@code INT OUT ,
@latest_worker_scan_id INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

    BEGIN TRAN
			UPDATE [Data].[WorkerScan]
			SET EndedAt = GETDATE(),HasExpired = 1
			WHERE (MachineID = @machine_id OR WorkerID = @worker_id) AND EndedAt IS NULL;
		      
	        INSERT INTO [Data].[WorkerScan](WorkerID, MachineID, LineID, Extras)
            VALUES(@worker_id, @machine_id, @line_id,@extras);

	        SELECT @latest_worker_scan_id = SCOPE_IDENTITY();

            INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)
	        SELECT @latest_worker_scan_id, OperationID FROM [Essentials].[MachineOperations]
	        WHERE MachineID = @machine_id;

    COMMIT TRAN
        SET @message = 'Success';
	    SET @code = 0;
    
  
  END TRY
  BEGIN CATCH

        SET @message = ERROR_MESSAGE();
	    SET @code = ERROR_NUMBER();
      ROLLBACK;
  
  END CATCH

END