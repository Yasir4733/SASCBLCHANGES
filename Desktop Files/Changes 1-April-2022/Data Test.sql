--USE [SooperWizerDT];
--GO

---- StyleTemplate
--DECLARE @ID INT;
--SET @ID = 1;

--WHILE @ID <= 1000
--BEGIN
--    INSERT INTO [Essentials].[StyleTemplate](StyleTemplateCode)
--        VALUES('Stc-'+ CAST(@ID AS VARCHAR(10)))
--    SET @ID = @ID + 1
--END
--GO

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -- Section
-- INSERT INTO [Essentials].[Section](SectionCode,SectionDescription)
-- VALUES('Sc-1','Primary'),('Sc-2','Back'),('Sc-3','Front'),('Sc-4','Assembly-1'),('Sc-5','Assembly-2');

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -- ScanGroup
-- DECLARE @ID INT
-- SET @ID = 1;
-- WHILE @ID<=10000
-- BEGIN
--     INSERT INTO [Essentials].[ScanGroup](CreatedAT,UpdatedAt)
--     VALUES(CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
--     SET @ID = @ID+1;
-- END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Line
--DECLARE @ID INT
--SET @ID = 1;
--WHILE @ID<=20
--BEGIN
--    INSERT INTO [Essentials].[Line](LineCode,LineDescription)
--    VALUES('L-'+ CAST(@ID AS VARCHAR(10)),'LineDescription-'+ CAST(@ID AS VARCHAR(10)));
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Worker
--DECLARE @ID INT
--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN
--    INSERT INTO [Essentials].[Worker](WorkerCode,WorkerDescription)
--    VALUES('W-'+ CAST(@ID AS VARCHAR(10)),'WorkerDescription-'+ CAST(@ID AS VARCHAR(10)));
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Module
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID <= 50
--BEGIN
--    INSERT INTO [Essentials].[Module](ModuleCode)
--        VALUES('Mu-'+ CAST(@ID AS VARCHAR(10)))
--    SET @ID = @ID + 1
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- USE [SooperWizerDT]
-- GO

-- ALTER TABLE [Essentials].[Box] ADD  DEFAULT (getdate()) FOR [IssueDate]
-- GO


---- Box
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN
--    INSERT INTO [Essentials].[Box](BoxCode)
--    VALUES('Boc-'+ CAST(@ID AS VARCHAR(10)));
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


---- MachineType
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=100
--BEGIN
--    INSERT INTO [Essentials].[MachineType](MachineTypeCode,MachineTypeDescription,Allowance)
--    VALUES('Mtc-'+ CAST(@ID AS VARCHAR(10)),'MachineTypeDescription-'+ CAST(@ID AS VARCHAR(10)),ROUND(RAND()*(15-10)+10,2));
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- SaleOrder
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=1000
--BEGIN
--    INSERT INTO [Essentials].[SaleOrder](SaleOrderCode,Customer,OrderQuantity)
--    VALUES('Soc-'+ CAST(@ID AS VARCHAR(10)),'Customer-'+ CAST(@ID AS VARCHAR(10)),1000);
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Department
--INSERT INTO [Essentials].[Department](DepartmentName)
--VALUES('PreWash'),('Wash'),('Packing'),('Shipping');

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


---- Operation
--DECLARE @ID INT;
--DECLARE @num1 INT
--DECLARE @num2 INT;
--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN
--    SET @num1= CEILING(RAND()*4);
--    SET @num2= CEILING(RAND()*5);
--    INSERT INTO [Essentials].[Operation](OperationCode,OperationName,OperationDescription,PieceRate,OperationType,SectionID,DepartmentID,SMV)
--    VALUES('Opc-'+ CAST(@ID AS VARCHAR(10)),'OperationName-'+ CAST(@ID AS VARCHAR(10)),'OperationDescription-'+ CAST(@ID AS VARCHAR(10))
--	,ROUND(RAND(),2),CHOOSE(@num1, 'Machine', 'Manual','Machine', 'Manual'),CHOOSE(@num2, 1,2,3,4,5),CHOOSE(@num1, 1,2,3,4),ROUND(RAND(),2));
--    SET @ID = @ID+1;
--END;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- -- TargetFeeding
-- DECLARE @ID INT;
-- DECLARE @num1 INT;
-- DECLARE @num2 INT;
-- DECLARE @V1 INT;
-- SET @V1 =  1;

-- SET @ID = 1;
-- WHILE @ID<=100
-- BEGIN
--    SET @num1 = CEILING(RAND()*3);
--    SET @num2 = CEILING(RAND()*5);

--    IF @ID % 20 = 0
-- 	BEGIN
-- 		SET @V1 = @V1+1
-- 	END
   
--    INSERT INTO [Essentials].[TargetFeeding](TargetDate,TargetShift,LineID,SectionID,PlanEfficiency,PlanProduction)
--    VALUES(CAST(GETDATE() AS DATE),CHOOSE(@num1, 'Morning','Evening','Night'),@V1,CHOOSE(@num2, 1,2,3,4,5),
--            ROUND(RAND(),2),ROUND(RAND(),2));
--    SET @ID = @ID+1;
-- END;



----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- ProductionOrder

--DECLARE @ID INT;
--DECLARE @V1 INT;
--DECLARE @V2 INT;
--DECLARE @num INT;
--SET @ID = 1;
--SET @V1 = 1;
--SET @V2 = 1;

--WHILE @ID<=10000
--BEGIN
--    SET @num= CEILING(RAND()*2);

--    IF @ID % 1000 = 0
--		BEGIN
--			SET @V1 = @V1+1
--		END
    
--	IF @ID % 100 = 0
--		BEGIN
--			SET @V2 = @V2+1
--		END 
--    INSERT INTO [Essentials].[ProductionOrder](ProductionOrderCode,SaleOrderID,StyleTemplateID,IsFollowOperationSequence)
--    VALUES('Poc-'+ CAST(@ID AS VARCHAR(10)),@V1,@V2,CHOOSE(@num, 0,1));
    
--    SET @ID = @ID+1;
--END;


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Marker
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=50
--BEGIN
--    INSERT INTO [Essentials].[Marker](MarkerCode,ProductionOrderID)
--    VALUES('Moc-'+ CAST(@ID AS VARCHAR(10)),@ID);
--    PRINT @ID;
--    SET @ID = @ID+1;
--END



----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- -- [Essentials].[MarkerMapping]
-- DECLARE @ID INT;
-- DECLARE @V1 INT;
-- DECLARE @V2 INT;
-- SET @V1 = 1 ;
-- SET @V2 = 1 ;
-- SET @ID = 1; 
-- WHILE @ID<=1000
-- BEGIN

--    IF @ID % 21 = 0
-- 		BEGIN
-- 			SET @V1 = @V1+1
-- 		END
    
--    IF @ID % 21 = 0
-- 		BEGIN
-- 			SET @V2 = 1
-- 		END
    
--     INSERT INTO [Essentials].[MarkerMapping](MarkerID,Size,Ratio,Inseam)
--     VALUES(@V1,@V2,@V2,@V2);

--     SET @ID = @ID+1;
--     SET @V2 = @V2+1
-- END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- -- StyleBulletin
-- DECLARE @ID INT;
-- DECLARE @V1 INT;
-- DECLARE @V2 INT;
-- DECLARE @V3 INT;
-- DECLARE @num INT;
-- SET @V1 = 1;
-- SET @V2 = 1;
-- SET @V3 = 1;
-- SET @ID = 1;


-- WHILE @ID<=100000
-- 	BEGIN


--    IF @ID % 1000 = 0
-- 		BEGIN
-- 			SET @V1 = @V1+1
-- 		END
    
--    IF @ID % 1000 = 0
-- 		BEGIN
-- 			SET @V2 = 1
-- 		END

--    IF @ID % 20 = 0
-- 		BEGIN
-- 			SET @V3 = 1
-- 		END
    
--     SET @num= CEILING(RAND()*2);

--     INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,OperationSequence,ScanType,MachineTypeID,SMV,PieceRate)
--     VALUES(@V1,@V2,@V2,CHOOSE(@num,'Bundle','Piece'),@V3,ROUND(RAND(),2),ROUND(RAND(),2));
    

--     SET @ID = @ID+1;
-- 	SET @V2 = @V2+1;
-- 	SET @V3 = @V3+1;
-- END


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


-- --CutJob
-- DECLARE @ID INT;
-- DECLARE @V1 INT;
-- DECLARE @V2 INT;
-- DECLARE @V3 INT;
-- DECLARE @num INT;
-- DECLARE @num1 INT;
-- SET @V1 = 1;
-- SET @V2 = 1;
-- SET @V3 = 1;
-- SET @ID = 1;


-- WHILE @ID<=100000
-- BEGIN


--     IF @ID % 1000 = 0
--  		BEGIN
--  			SET @V1 = @V1+1
--  		END
    
--     IF @ID % 50 = 0
--  		BEGIN
--  			SET @V2 = 1
--  		END

-- 	SET @num= CEILING(RAND()*2);
-- 	SET @num1= CEILING(RAND()*20);
--     INSERT INTO [Essentials].[CutJob](CutNo,ProductionOrderID,CutQuantity,MarkerID)
--     VALUES('CutNo-'+ CAST(@ID AS VARCHAR(10)),@V1,100,@V2);
    
--     SET @ID = @ID+1;
-- 	SET @V2 = @V2+1;
-- END



----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


 ----CutReport
 --DECLARE @ID INT;
 --DECLARE @V1 INT;
 --SET @V1 = 1;
 --SET @ID = 1;

 --WHILE @ID<=100000
 --BEGIN


 --    IF @ID % 1000 = 0
 -- 		BEGIN
 -- 			SET @V1 = @V1+1
 -- 		END

 --    INSERT INTO [Essentials].[CutReport](BundleCode,BundleQuantity,ScannedQuantity,RemainingQuantity,CutJobID,StyleTemplateID)
 --    VALUES('BundleCode-'+ CAST(@ID AS VARCHAR(10)),100,0,100,@V1,1);
 --    SET @ID = @ID+1;
 --END


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


---- Machine
--DECLARE @ID INT;
--DECLARE @V1 INT;
--DECLARE @V2 INT;
--DECLARE @V3 INT;
--SET @V1 = 1;
--SET @V2 = 1;

--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN

--    IF @ID % 1000 = 0
-- 		BEGIN
-- 			SET @V1 = @V1+1
-- 		END

--    IF @ID % 1000 = 0
-- 		BEGIN
-- 			SET @V2 = @V2+1
-- 		END

--    INSERT INTO [Essentials].[Machine](MachineCode,MachineDescription,MachineTypeID,LineID,BoxID)
--    VALUES('MachineCode-'+ CAST(@ID AS VARCHAR(10)),'MachinDescription-'+ CAST(@ID AS VARCHAR(10)),@V1,@V2,@ID);

--    SET @ID = @ID+1;
--END


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


---- [Essentials].[Tag]
--DECLARE @ID INT; 
--SET @ID = 1;
--WHILE @ID<=26994
--BEGIN
--    INSERT INTO [Essentials].[Tag](TagID,BundleID)
--    VALUES(@ID,@ID);
--    SET @ID = @ID+1;
--END



----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- [Essentials].[MachineOperations] 
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN
--    INSERT INTO [Essentials].[MachineOperations](MachineID,OperationID)
--    VALUES(@ID,@ID);
--    SET @ID = @ID+1;
--END

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- [Essentials].[AllocatedMachines]
--DECLARE @ID INT;
--SET @ID = 1;
--WHILE @ID<=10000
--BEGIN

--    INSERT INTO [Essentials].[AllocatedMachines](WorkerID,MachineID)
--    VALUES(@ID,@ID);
--    SET @ID = @ID+1;
--END


----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

---- [Essentials].[PieceWiseGroup]
--DECLARE @ID INT;
--DECLARE @v1 INT;
--SET @ID = 1;
--SET @v1 = 1;

--WHILE @ID <= 10000
--BEGIN
--	IF @ID%100=0
--		BEGIN
--			SET @v1 = @v1 + 1 
--		END
--	INSERT INTO [Essentials].[PieceWiseGroup](GroupID,BundleID,PieceID)
--	VALUES(@v1,@v1,@ID)
	
--	SET @ID = @ID + 1


--END


































----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------


 ---- RESET DATABASE
 --EXEC sp_MSForEachTable 'DISABLE TRIGGER ALL ON [Essentials].[ProductionOrder]'
 --GO
 --EXEC sp_MSForEachTable 'ALTER TABLE [Essentials].[ProductionOrder] NOCHECK CONSTRAINT ALL'
 --GO
 --EXEC sp_MSForEachTable 'DELETE FROM [Essentials].[ProductionOrder]'
 --GO
 --EXEC sp_MSForEachTable 'ALTER TABLE [Essentials].[ProductionOrder] CHECK CONSTRAINT ALL'
 --GO
 --EXEC sp_MSForEachTable 'ENABLE TRIGGER ALL ON [Essentials].[ProductionOrder]'
 --GO

 --DBCC CHECKIDENT ('[Essentials].[ProductionOrder]', RESEED, 0);
