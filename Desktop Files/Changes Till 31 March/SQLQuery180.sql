/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [StyleBulletinID]
      ,[StyleTemplateID]
      ,[OperationID]
      ,[OperationSequence]
      ,[ScanType]
      ,[IsFirst]
      ,[IsLast]
      ,[MachineTypeID]
      ,[CreatedAt]
      ,[UpdatedAt]
      ,[SMV]
      ,[PieceRate]
      ,[IsCritical]
  FROM [SooperWizerRT].[Essentials].[StyleBulletin]

-- StyleBulletin
DECLARE @ID INT;
DECLARE @num INT;
DECLARE @num1 INT;
DECLARE @V1 INT;
DECLARE @OPID INT;

SET @V1 = 1;
SET @ID = 1;
WHILE @ID<=100
	BEGIN
    SET @num= CEILING(RAND()*2);
	SET @num1= CEILING(RAND()*20);
	IF @ID%1000
		BEGIN
		SET @V1 = @V1+1
		END
		SELECT @V1,@ID
	IF @OPID%1000=0
		BEGIN
		SET @V1 = @V1+1
		END
		SELECT @V1,@ID
	
    --INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,OperationSequence,ScanType,MachineTypeID,SMV,PieceRate)
    --VALUES(15,@ID,@ID,CHOOSE(@num,'Bundle','Piece'),CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),ROUND(RAND(),2),ROUND(RAND(),2));
    
    SET @ID = @ID+1;
	
    SET @OPID = @OPID+1;
END
