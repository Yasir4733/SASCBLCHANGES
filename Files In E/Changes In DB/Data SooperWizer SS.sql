USE [SooperWizer];
GO


-- StyleTemplate
DECLARE @ID INT;
SET @ID = 1;
WHILE @ID <= 100
BEGIN
    INSERT INTO [Essentials].[StyleTemplate](StyleTemplateCode)
        VALUES('Stc-'+ CAST(@ID AS VARCHAR(30)))
    PRINT @ID
    SET @ID = @ID + 1
END


-- Section

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Section](SectionCode,SectionDescription)
    VALUES('Sc-'+ CAST(@ID AS VARCHAR(30)),'SectionDescription-'+ CAST(@ID AS VARCHAR(30)));
    PRINT @ID;
    SET @ID = @ID+1;
END

-- ScanGroup

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[ScanGroup](CreatedAT,UpdatedAt)
    VALUES(CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
    PRINT @ID;
    SET @ID = @ID+1;
END



-- Line

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Line](LineCode,LineDescription)
    VALUES('Lc-'+ CAST(@ID AS VARCHAR(30)),'LineDescription-'+ CAST(@ID AS VARCHAR(30)));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Worker
DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Worker](WorkerCode,WorkerDescription)
    VALUES('Wc-'+ CAST(@ID AS VARCHAR(30)),'WorkerDescription-'+ CAST(@ID AS VARCHAR(30)));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Module

DECLARE @ID INT;
SET @ID = 1;
WHILE @ID <= 100
BEGIN
    INSERT INTO [Essentials].[Module](ModuleCode)
        VALUES('Muc-'+ CAST(@ID AS VARCHAR(30)))
    PRINT @ID
    SET @ID = @ID + 1
END


-- Box

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Box](BoxCode,IssueDate)
    VALUES('Boc-'+ CAST(@ID AS VARCHAR(30)),GETDATE());
    PRINT @ID;
    SET @ID = @ID+1;
END


-- MachineType
DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[MachineType](MachineTypeCode,MachineTypeDescription,Allowance)
    VALUES('Mtc-'+ CAST(@ID AS VARCHAR(30)),'MachineTypeDescription-'+ CAST(@ID AS VARCHAR(30)),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END



-- SaleOrder
DECLARE @OrderQuantity INT;
DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    SELECT @OrderQuantity = Round((90 * Rand())+10,0);
    INSERT INTO [Essentials].[SaleOrder](SaleOrderCode,Customer,OrderQuantity)
    VALUES('Soc-'+ CAST(@ID AS VARCHAR(30)),'Customer-'+ CAST(@ID AS VARCHAR(30)),@OrderQuantity);
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Operation
DECLARE @ID INT;
SET @ID = 1;
DECLARE @num INT;

WHILE @ID<=100
BEGIN
    SET @num= CEILING(RAND()*2);
    INSERT INTO [Essentials].[Operation](OperationCode,OperationName,OperationDescription,Department,PieceRate,OperationType,SectionID)
    VALUES('Opc-'+ CAST(@ID AS VARCHAR(30)),'OperationName-'+ CAST(@ID AS VARCHAR(30)),'OperationDescription-'+ CAST(@ID AS VARCHAR(30)),
    CHOOSE(@num, 'PreWash', 'Washing'),ROUND(RAND(),2),CHOOSE(@num, 'Machine', 'Manual'),@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END;




-- TargetFeeding

DECLARE @ID INT;
SET @ID = 1;
DECLARE @num INT;

WHILE @ID<=100
BEGIN
    SET @num= CEILING(RAND()*3);
    INSERT INTO [Essentials].[TargetFeeding](TargetDate,TargetShift,LineID,SectionID,PlanEfficiency,PlanProduction)
    VALUES(CAST(GETDATE() AS DATE),CHOOSE(@num, 'Morning','Evening','Night'),@ID,@ID,ROUND(RAND(),2),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END;



-- ProductionOrder

DECLARE @ID INT;
SET @ID = 1;
DECLARE @num INT;

WHILE @ID<=100
BEGIN
    SET @num= CEILING(RAND()*2);
    INSERT INTO [Essentials].[ProductionOrder](ProductionOrderCode,SaleOrderID,StyleTemplateID,IsFollowOperationSequence)
    VALUES('Poc-'+ CAST(@ID AS VARCHAR(30)),@ID,@ID,CHOOSE(@num, 0,1));
    PRINT @ID;
    SET @ID = @ID+1;
END;


-- Marker

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Marker](MarkerCode,ProductionOrderID)
    VALUES('Moc-'+ CAST(@ID AS VARCHAR(30)),@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END




-- StyleBulletin


DECLARE @ID INT;
DECLARE @num INT;
SET @ID =1;

WHILE @ID<=100
    SET @num= CEILING(RAND()*2);
    INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,ScanType,OperationSequence,MachineTypeID)
    VALUES(@ID,@ID,CHOOSE(@num,'Bundle','Piece'),@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END

-- StyleBulletinID =101






--CutJob

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[CutJob](CutNo,ProductionOrderID,CutQuantity,MarkerID)
    VALUES('CutNo-'+ CAST(@ID AS VARCHAR(30)),@ID,ROUND(RAND()*100,0),@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END



-- CutReport
DECLARE @ID INT;
DECLARE @num INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    SET @num= CEILING(RAND()*4);
    INSERT INTO [Essentials].[CutReport](BundleCode,BundleQuantity,RemainingQuantity,CutJobID)
    VALUES('BundleCode-'+ CAST(@ID AS VARCHAR(30)),CHOOSE(@num, 5,10,15,20),CHOOSE(@num, 5,10,15,20),CHOOSE(@num, 1,2,1,2));
    PRINT @ID;
    SET @ID = @ID+1;
END





-- [Essentials].[PieceWiseCutReport]


DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=10
BEGIN
    INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
    VALUES(6,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END







-- [Essentials].[Machine]


DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Machine](MachineCode,MachineDescription,MachineTypeID,ActiveWorkerID,LineID,BoxID)
    VALUES('MachineCode-'+ CAST(@ID AS VARCHAR(30)),'MachinDescription-'+ CAST(@ID AS VARCHAR(30)),@ID,@ID,@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END





-- [Essentials].[Tag] 

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=50
BEGIN
    INSERT INTO [Essentials].[Tag](BundleID)
    VALUES(@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END




-- SELECT ROUND(RAND()*100,0)