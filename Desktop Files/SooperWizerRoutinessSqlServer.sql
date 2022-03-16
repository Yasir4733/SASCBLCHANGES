CREATE PROCEDURE [Essentials].[uspSetMachineDown](@machine_id INT,@down_reason VARCHAR(MAX), @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

		    INSERT INTO [Essentials].[MachineDownTime](MachineID,DownReason)
        VALUES(@machine_id,@down_reason);
        
		  	UPDATE [Essentials].[Machine]
			  SET IsMachineDown =1
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


SELECT @message AS Messege, @code AS ErrorCode;

END




DECLARE @message VARCHAR;

DECLARE @code INT;

EXEC [dbo].[uspSetMachineDown] 2,'Power Breakage',@message,@code;


-- ==================================================
-- ==================================================



CREATE PROCEDURE [Essentials].[uspSetMahineUp](@machine_id INT, @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN
        UPDATE [Essentials].[MachineDownTime]
        SET EndTime = GETDATE()
        WHERE MachineID = @machine_id AND EndTime IS NULL;
        
        UPDATE [Essentials].[Machine] 
        SET IsMachineDown = 0
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


SELECT @message AS Messege, @code AS ErrorCode;

END




DECLARE @message VARCHAR;

DECLARE @code INT;

EXEC  [dbo].[uspSetMahineUp] 2,@message,@code;



-- ==================================================
-- ==================================================


CREATE PROCEDURE [Essentials].[uspSetMachineWorker](@worker_id INT,@machine_id INT, @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

        UPDATE [Essentials].[Machine] SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() WHERE ActiveWorkerID = @worker_id; 
        UPDATE [Essentials].[Machine] SET ActiveWorkerID = @worker_id,UpdatedAt = GETDATE() WHERE MachineID = @machine_id;
      
      COMMIT TRAN
	  
	    SET @message =  'Success';
	    SET @code = 0;
    END TRY

    BEGIN CATCH
        SET @message = ERROR_MESSAGE();
	    SET @code = ERROR_NUMBER();
        ROLLBACK;
    END CATCH

SELECT @message AS Messege, @code AS ErrorCode;

END


DECLARE @message VARCHAR;

DECLARE @code INT;

EXEC  [dbo].[uspSetMahineUp] 1,2,@message,@code;



-- ==================================================
-- =================================================

CREATE PROCEDURE [Essentials].[uspUpdateWorkerTodayProduction](@worker_id INT,@production_pieces INT, @total_pieces INT OUT,@message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

        UPDATE [Essentials].[Worker]
		    SET TodayProduction = (ISNULL(TodayProduction, 0) + @production_pieces),UpdatedAt = GETDATE()
		    WHERE WorkerID = @worker_id;     
      
      COMMIT TRAN
      	
      SELECT TodayProduction INTO total_pieces
	    FROM [Essentials].[Worker]
	    WHERE WorkerID = @worker_id;
	    
        SET @message =  'Success';
	    SET @code = 0;
    
    END TRY

    BEGIN CATCH
        
        SET @message = ERROR_MESSAGE();
	    SET @code = ERROR_NUMBER();
        ROLLBACK;
        
    END CATCH

SELECT @message AS Messege, @code AS ErrorCode;

END






-- =========================================
-- =========================================



CREATE PROCEDURE [Essentials].[uspSetMachineDown](@machine_id INT,@down_reason VARCHAR(MAX), @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

		    INSERT INTO [Essentials].[MachineDownTime](MachineID,DownReason)
        VALUES(@machine_id,@down_reason);
        
		  	UPDATE [Essentials].[Machine]
			  SET IsMachineDown =1
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


SELECT @message AS Messege, @code AS ErrorCode;

END


CREATE PROCEDURE [Essentials].[uspSetMahineUp](@machine_id INT, @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN
        UPDATE [Essentials].[MachineDownTime]
        SET EndTime = GETDATE()
        WHERE MachineID = @machine_id AND EndTime IS NULL;
        
        UPDATE [Essentials].[Machine] 
        SET IsMachineDown = 0
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


SELECT @message AS Messege, @code AS ErrorCode;

END


CREATE PROCEDURE [Essentials].[uspSetMachineWorker](@worker_id INT,@machine_id INT, @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

        UPDATE [Essentials].[Machine] SET ActiveWorkerID = NULL,UpdatedAt = GETDATE() WHERE ActiveWorkerID = @worker_id; 
        UPDATE [Essentials].[Machine] SET ActiveWorkerID = @worker_id,UpdatedAt = GETDATE() WHERE MachineID = @machine_id;
      
      COMMIT TRAN
	  
	    SET @message =  'Success';
	    SET @code = 0;
    END TRY

    BEGIN CATCH
        SET @message = ERROR_MESSAGE();
	    SET @code = ERROR_NUMBER();
        ROLLBACK;
    END CATCH

SELECT @message AS Messege, @code AS ErrorCode;

END



CREATE PROCEDURE [Essentials].[uspUpdateWorkerTodayProduction](@worker_id INT,@production_pieces INT, @total_pieces INT OUT,@message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

        UPDATE [Essentials].[Worker]
		    SET TodayProduction = (ISNULL(TodayProduction, 0) + @production_pieces),UpdatedAt = GETDATE()
		    WHERE WorkerID = @worker_id;     
      
      COMMIT TRAN
      	
      SELECT TodayProduction INTO total_pieces
	    FROM [Essentials].[Worker]
	    WHERE WorkerID = @worker_id;
	    
      SET @message =  'Success';
	    SET @code = 0;
    
    END TRY

    BEGIN CATCH
        
      SET @message = ERROR_MESSAGE();
	    SET @code = ERROR_NUMBER();
      ROLLBACK;
        
    END CATCH

SELECT @message AS Messege, @code AS ErrorCode;

END





CREATE PROCEDURE [Data].[uspInsertWorkerScan](
  @worker_id INT, 
  @machine_id INT, 
	@line_id INT, 
  @extras VARCHAR(1024), 
	@code INT OUT , 
  @message VARCHAR(1024) OUT, 
  @latest_worker_scan_id INT OUT)

BEGIN

  BEGIN TRY

    BEGIN TRAN

			UPDATE [Data].[WorkerScan]
			SET EndedAt = GETDATE(),UpdatedAt = GETDATE()
			WHERE WorkerID = @worker_id AND EndedAt IS NULL;
      
      INSERT INTO [Data].[WorkerScan](WorkerID, MachineID, LineID, Extras)
      VALUES(@worker_id, @machine_id, @line_id,@extras);
      
      SELECT SCOPE_IDENTITY() INTO @latest_worker_scan_id;

      
      DECLARE @json NVARCHAR(MAX);
      SET @json = N'[  
      {
        "id": 1,"skills": [1,2,3,4]
       } 
      ]';

      INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)  
      FROM OPENJSON(@json)  
       WITH (
       id INT 'strict $.id',
      skills NVARCHAR(MAX) '$.skills' AS JSON
      )
      OUTER APPLY OPENJSON(skills)
      WITH (skill NVARCHAR(8) '$');


      -- INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)
      -- VALUES (ID,S);

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




USE [SooperWizerReplica]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/10/2022 3:36:45 PM ******/
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
			SET EndedAt = GETDATE(),UpdatedAt = GETDATE()
			WHERE WorkerID = @worker_id AND EndedAt IS NULL;
      
      INSERT INTO [Data].[WorkerScan](WorkerID, MachineID, LineID, Extras)
      VALUES(@worker_id, @machine_id, @line_id,@extras);

	  SELECT @latest_worker_scan_id = SCOPE_IDENTITY();



	  DECLARE @json NVARCHAR(MAX);
      SET @json = N'[  
      {
        "id":7,"skills": [1,2,3,4]
       } 
      ]';

      INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)  
	  SELECT id,skill
      FROM OPENJSON(@json)  
       WITH (
       id INT 'strict $.id',
      skills NVARCHAR(MAX) '$.skills' AS JSON
      )
      OUTER APPLY OPENJSON(skills)
      WITH (skill NVARCHAR(8) '$');


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



-- USE [SooperWizerReplica]
-- GO

-- DECLARE	@return_value int,
-- 		@code int,
-- 		@message varchar(1024),
-- 		@latest_worker_scan_id int

-- EXEC	@return_value = [Data].[uspInsertWorkerScan]
-- 		@worker_id =5,
-- 		@machine_id = 5,
-- 		@line_id  =1,
-- 		@extras = 'Test1-1',
-- 		@code = @code OUTPUT,
-- 		@message = @message OUTPUT,
-- 		@latest_worker_scan_id = @latest_worker_scan_id OUTPUT

-- SELECT	@code as N'@code',
-- 		@message as N'@message',
-- 		@latest_worker_scan_id as N'@latest_worker_scan_id'

-- SELECT	'Return Value' = @return_value

-- GO



USE [SooperWizerReplica]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/10/2022 3:36:45 PM ******/
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
			SET EndedAt = GETDATE(),UpdatedAt = GETDATE()
			WHERE WorkerID = @worker_id AND EndedAt IS NULL;
      
	    INSERT INTO [Data].[WorkerScan](WorkerID, MachineID, LineID, Extras)
      VALUES(@worker_id, @machine_id, @line_id,@extras);

	    SELECT @latest_worker_scan_id = SCOPE_IDENTITY();

	    SELECT OperationID FROM [Essentials].[MachineOperations]
	    WHERE MachineID = @machine_id;


    INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)  
	  VALUES(@latest_worker_scan_id,OperationID);
      

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




      INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)  
	SELECT @latest_worker_scan_id, OperationID FROM [Essentials].[MachineOperations]
	WHERE MachineID = @machine_id;
	

























USE [SooperWizerReplica]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/10/2022 3:36:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Data].[uspInsertWorkerScan](@worker_id INT,@machine_id INT,@line_id INT,@extras VARCHAR(1024),@code INT OUT ,
@message VARCHAR(1024) OUT,@latest_worker_scan_id INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

    BEGIN TRAN

			UPDATE [Data].[WorkerScan]
			SET EndedAt = GETDATE(),UpdatedAt = GETDATE()
			WHERE WorkerID = @worker_id AND EndedAt IS NULL;
      
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








USE [SooperWizerReplica]
GO
/****** Object:  StoredProcedure [Data].[uspInsertWorkerScan]    Script Date: 3/10/2022 4:22:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Data].[uspInsertWorkerScan](@worker_id INT,@machine_id INT,@line_id INT,@extras VARCHAR(1024),@code INT OUT ,
@message VARCHAR(1024) OUT,@latest_worker_scan_id INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

    BEGIN TRAN
			
			
			UPDATE [Data].[WorkerScan]
			SET EndedAt = GETDATE(),HasExpired = 1
			WHERE WorkerID = @worker_id AND EndedAt IS NULL;
		      
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



	SELECT WorkerID	 from [Data].[WorkerScan] 
	where MachineID = @machine_id AND EndedAt is null;