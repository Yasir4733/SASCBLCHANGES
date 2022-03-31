USE [SooperWizerRT]
GO
/****** Object:  StoredProcedure [dbo].[uspSetMachineBox]    Script Date: 3/30/2022 11:29:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[uspSetMachineBox](@box_id INT,@machine_id INT, @message VARCHAR(1024) OUT,@code INT OUT)
AS
BEGIN
	SET NOCOUNT ON;
    BEGIN TRY

      BEGIN TRAN

        UPDATE [Essentials].[Machine] SET BoxID = NULL WHERE BoxID = @box_id; 
        UPDATE [Essentials].[Machine] SET BoxID = @box_id WHERE MachineID = @machine_id;
      
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

