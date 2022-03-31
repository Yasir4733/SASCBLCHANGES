-- StyleTemplate
DECLARE @ID INT;
SET @ID = 1;
DECLARE @num INT;
DECLARE @num1 INT;
DECLARE @num2 INT;
DECLARE @numrows INT;

SET @numrows = 1000;

-- StyleTemplate
SET @ID = 1;
WHILE @ID <= @numrows
BEGIN
    INSERT INTO [Essentials].[StyleTemplate](StyleTemplateCode)
        VALUES('Stc-'+ CAST(@ID AS VARCHAR(30)))
    PRINT @ID
    SET @ID = @ID + 1
END

-- Section
INSERT INTO [Essentials].[Section](SectionCode,SectionDescription)
VALUES('Sc-1','Primary'),('Sc-2','Back'),('Sc-3','Front'),('Sc-4','Assembly-1'),('Sc-5','Assembly-2');


-- ScanGroup
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[ScanGroup](CreatedAT,UpdatedAt)
    VALUES(CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
    PRINT @ID;
    SET @ID = @ID+1;
END

-- Line
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[Line](LineCode,LineDescription)
    VALUES('L-'+ CAST(@ID AS VARCHAR(30)),'LineDescription-'+ CAST(@ID AS VARCHAR(30)));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Worker
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[Worker](WorkerCode,WorkerDescription)
    VALUES('W-'+ CAST(@ID AS VARCHAR(30)),'WorkerDescription-'+ CAST(@ID AS VARCHAR(30)));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Module
SET @ID = 1;
WHILE @ID <= @numrows
BEGIN
    INSERT INTO [Essentials].[Module](ModuleCode)
        VALUES('Mu-'+ CAST(@ID AS VARCHAR(30)))
    PRINT @ID
    SET @ID = @ID + 1
END


-- Box
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[Box](BoxCode,IssueDate)
    VALUES('Boc-'+ CAST(@ID+20 AS VARCHAR(30)),GETDATE());
    PRINT @ID;
    SET @ID = @ID+1;
END





-- MachineType
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[MachineType](MachineTypeCode,MachineTypeDescription,Allowance)
    VALUES('Mtc-'+ CAST(@ID AS VARCHAR(30)),'MachineTypeDescription-'+ CAST(@ID AS VARCHAR(30)),ROUND(RAND()*(15-10)+10,2));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- SaleOrder
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[SaleOrder](SaleOrderCode,Customer,OrderQuantity)
    VALUES('Soc-'+ CAST(@ID AS VARCHAR(30)),'Customer-'+ CAST(@ID AS VARCHAR(30)),1000);
    PRINT @ID;
    SET @ID = @ID+1;
END

-- Department
INSERT INTO [Essentials].[Department](DepartmentName)
VALUES('PreWash'),('Wash'),('Packing'),('Shipping');


-- Operation
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    SET @num= CEILING(RAND()*4);
    INSERT INTO [Essentials].[Operation](OperationCode,OperationName,OperationDescription,PieceRate,OperationType,SectionID,DepartmentID,SMV)
    VALUES('Opc-'+ CAST(@ID AS VARCHAR(30)),'OperationName-'+ CAST(@ID AS VARCHAR(30)),'OperationDescription-'+ CAST(@ID AS VARCHAR(30))
	,ROUND(RAND(),2),CHOOSE(@num, 'Machine', 'Manual','Machine', 'Manual'),CHOOSE(@num, 1,2,3,4),CHOOSE(@num, 1,2,3,4),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END;


-- TargetFeeding
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    SET @num= CEILING(RAND()*3);
    INSERT INTO [Essentials].[TargetFeeding](TargetDate,TargetShift,LineID,SectionID,PlanEfficiency,PlanProduction)
    VALUES(CAST(GETDATE() AS DATE),CHOOSE(@num, 'Morning','Evening','Night'),@ID,CHOOSE(@num, 1,2,3),
            ROUND(RAND(),2),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END;

-- ProductionOrder
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    SET @num= CEILING(RAND()*2);
    INSERT INTO [Essentials].[ProductionOrder](ProductionOrderCode,SaleOrderID,StyleTemplateID,IsFollowOperationSequence)
    VALUES('Poc-'+ CAST(@ID+2900 AS VARCHAR(30)),6,30,CHOOSE(@num, 0,1));
    PRINT @ID;
    SET @ID = @ID+1;
END;


-- Marker
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[Marker](MarkerCode,ProductionOrderID)
    VALUES('Moc-'+ CAST(@ID AS VARCHAR(30)),@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END


-- [Essentials].[MarkerMapping]
SET @ID = 1;  
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[MarkerMapping](MarkerID,Size,Ratio,Inseam)
    VALUES(20,@ID,@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END


-- StyleBulletin
SET @ID = 1;
WHILE @ID<=@numrows
	BEGIN
    SET @num= CEILING(RAND()*2);
	SET @num1= CEILING(RAND()*20);
    INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,OperationSequence,ScanType,MachineTypeID,SMV,PieceRate)
    VALUES(15,@ID,@ID,CHOOSE(@num,'Bundle','Piece'),CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),ROUND(RAND(),2),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END



--CutJob
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
	SET @num= CEILING(RAND()*2);
	SET @num1= CEILING(RAND()*20);
    INSERT INTO [Essentials].[CutJob](CutNo,ProductionOrderID,CutQuantity,MarkerID)
    VALUES('CutNo-'+ CAST(@ID AS VARCHAR(30)),1,100,CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- CutReport
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    SET @num= CEILING(RAND()*4);
    INSERT INTO [Essentials].[CutReport](BundleCode,BundleQuantity,RemainingQuantity,CutJobID,StyleTemplateID)
    VALUES('BundleCode-'+ CAST(@ID+900 AS VARCHAR(30)),100,100,10,1);
    PRINT @ID;
    SET @ID = @ID+1;
END


-- Machine
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
	SET @num1= CEILING(RAND()*20);
	SET @num2= CEILING(RAND()*10);
    INSERT INTO [Essentials].[Machine](MachineCode,MachineDescription,MachineTypeID,LineID,BoxID)
    VALUES('MachineCode-'+ CAST(@ID+9000 AS VARCHAR(30)),'MachinDescription-'+ CAST(@ID AS VARCHAR(30)),CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),CHOOSE(@num2, 1,2,3,4,5,6,7,8,9,10),CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20));
    PRINT @ID;
    SET @ID = @ID+1;
END


-- [Essentials].[Tag] 
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[Tag](TagID,BundleID)
    VALUES(@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END

-- [Essentials].[MachineOperations] 
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN
    INSERT INTO [Essentials].[MachineOperations](MachineID,OperationID)
    VALUES(@ID+400,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END


-- [Essentials].[AllocatedMachines]
SET @ID = 1;
WHILE @ID<=@numrows
BEGIN

    INSERT INTO [Essentials].[AllocatedMachines](WorkerID,MachineID)
    VALUES(@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



UPDATE child 
SET
child.BoxID = parent.MachineID
from    [Essentials].[Machine] child (NOLOCK),     
        [Essentials].[Machine] parent (NOLOCK)
WHERE
  child.MachineID = Parent.MachineID

SELECT COUNT(*) FROM [Essentials].[AllocatedMachines]


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- CBLQA
ALTER TABLE [Data].[TotalScanning]
ADD
CurrentStyleTemplateID INT ,
CurrentStyleTemplateCode VARCHAR(64);

 ALTER TABLE [Essentials].[CutJob]
 ADD IsClosed BIT NOT NULL DEFAULT 0;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- RESET DATABASE
EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'DELETE FROM ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
GO


--
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'DELETE FROM [primary_assignment].[MachineOperationMapping]'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
GO
DBCC CHECKIDENT ('[primary_assignment].[MachineOperationMapping]', RESEED, 1);

  SELECT @latest_worker_scan_id = SCOPE_IDENTITY();

            INSERT INTO [Data].[WorkerOperations](WorkerScanID,OperationID)
	        SELECT @latest_worker_scan_id, OperationID FROM [Essentials].[MachineOperations]
	        WHERE MachineID = @machine_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(*) FROM [Essentials].[Operation]

SET IDENTITY_INSERT [Essentials].[Operation] ON

INSERT INTO [Essentials].[Operation](OperationID,OperationCode,OperationName,OperationDescription,PieceRate,OperationType,SectionID,DepartmentID,SMV)
    VALUES(101,'Opc-'+ CAST(10001 AS VARCHAR(30)),'OperationName-'+ CAST(101 AS VARCHAR(30)),'OperationDescription-'+ CAST(101 AS VARCHAR(30))
	,ROUND(RAND(),2),'Manual',4,3,ROUND(RAND(),2))

SET IDENTITY_INSERT [Essentials].[Operation] OFF


-- Operation
DECLARE @ID INT;
DECLARE @num INT;
SET @ID = 100;
WHILE @ID<=10000
BEGIN
    SET @num= CEILING(RAND()*4);
    INSERT INTO [Essentials].[Operation](OperationCode,OperationName,OperationDescription,PieceRate,OperationType,SectionID,DepartmentID,SMV)
    VALUES('Opc-'+ CAST(@ID AS VARCHAR(30)),'OperationName-'+ CAST(@ID AS VARCHAR(30)),'OperationDescription-'+ CAST(@ID AS VARCHAR(30))
	,ROUND(RAND(),2),CHOOSE(@num, 'Machine', 'Manual','Machine', 'Manual'),CHOOSE(@num, 1,2,3,4),CHOOSE(@num, 1,2,3,4),ROUND(RAND(),2));
    PRINT @ID;
    SET @ID = @ID+1;
END;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------



 
EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON ?'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'DELETE FROM [Essentials].[StyleBulletin]'
GO
EXEC sp_MSForEachTable 'ALTER TABLE ? CHECK CONSTRAINT ALL'
GO
EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON ?'
GO
DBCC CHECKIDENT ('[Essentials].[StyleBulletin]', RESEED, 1);




-- StyleBulletin
DECLARE @ID INT;
DECLARE @num INT;
DECLARE @num1 INT;
DECLARE @V1 INT;
DECLARE @OPID INT;
SET @OPID = 1;
SET @V1 = 2;
SET @ID = 1;


WHILE @ID<=10000
	BEGIN
    SET @num= CEILING(RAND()*2);
	SET @num1= CEILING(RAND()*20);
	
	IF @ID%1001=0
		BEGIN
			SET @V1 = @V1+1
		END

	IF @OPID%1001=0
		BEGIN
			SET @OPID = 1
		END

    INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,OperationSequence,ScanType,MachineTypeID,SMV,PieceRate)
    VALUES(@V1,@OPID,@OPID,CHOOSE(@num,'Bundle','Piece'),CHOOSE(@num1, 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),ROUND(RAND(),2),ROUND(RAND(),2));
    
    SET @ID = @ID+1;
	
    SET @OPID = @OPID+1;
END
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


  UPDATE child 
SET
child.OperationID = parent.MachineID
from    [Essentials].[MachineOperations] child (NOLOCK),     
        [Essentials].[MachineOperations] parent (NOLOCK)
WHERE
  child.MachineID = Parent.MachineID

SELECT COUNT(*) FROM [Essentials].[MachineOperations]


DECLARE @ID INT;

-- [Essentials].[MachineOperations] 
SET @ID = 501;
WHILE @ID<=10000
BEGIN
    INSERT INTO [Essentials].[MachineOperations](MachineID,OperationID)
    VALUES(@ID,@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
