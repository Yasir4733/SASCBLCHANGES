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
    VALUES('Boc-'+ CAST(@ID AS VARCHAR(30)),CAST(GETDATE() AS DATE));
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
    CHOOSE(@num, 'PreWash', 'Washing'),ROUND(RAND(),2),CHOOSE(@num, 'Machine', 'Manual'),CEILING(RAND()*100));
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
    VALUES(CAST(GETDATE() AS DATE),CHOOSE(@num, 'Morning','Evening','Night'),CEILING(RAND()*100),CEILING(RAND()*100),
            ROUND(RAND(),2),ROUND(RAND(),2));
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
    VALUES('Poc-'+ CAST(@ID AS VARCHAR(30)),CEILING(RAND()*100),CEILING(RAND()*100),CHOOSE(@num, 0,1));
    PRINT @ID;
    SET @ID = @ID+1;
END;


-- Marker

DECLARE @ID INT;
SET @ID =1;

WHILE @ID<=100
BEGIN
    INSERT INTO [Essentials].[Marker](MarkerCode,ProductionOrderID)
    VALUES('Moc-'+ CAST(@ID AS VARCHAR(30)),CEILING(RAND()*100));
    PRINT @ID;
    SET @ID = @ID+1;
END




-- StyleBulletin


DECLARE @ID INT;
DECLARE @num INT;
SET @ID =1;

WHILE @ID<=100
    SET @num= CEILING(RAND()*2);
    INSERT INTO [Essentials].[StyleBulletin](StyleTemplateID,OperationID,ScanType,MachineTypeID)
    VALUES(@ID,@ID,CHOOSE(@num,'Bundle','Piece'),@ID);
    PRINT @ID;
    SET @ID = @ID+1;
END



































-- DECLARE @sid INT;
-- SET @sid =1;
-- WHILE @sid <= 100
-- BEGIN
--     PRINT @sid
--     SET @sid = @sid + 1
-- END


-- SELECT ROUND(RAND(),2);

-- DECLARE @Allowance INT;
-- DECLARE @UpperLimitAllownace INT;
-- DECLARE @LowerLimtAllowance INT;
-- SET @LowerLimtAllowance = 1;
-- SET @UpperLimitAllownace = 9;
-- SELECT @Allowance = Round(((@UpperLimitAllownace - @LowerLimtAllowance) * Rand())+0,0);
-- SELECT @OrderQuantity = Round(((@UpperLimit - @LowerLimt) * Rand())+@LowerLimt,0);

-- PRINT @Allowance;

-- DECLARE @OrderQuantity INT;
-- DECLARE @UpperLimit INT;
-- DECLARE @LowerLimt INT;
-- SET @LowerLimt = 10;
-- SET @UpperLimit = 100;
-- SELECT @OrderQuantity = Round(((@UpperLimit - @LowerLimt) * Rand())+@LowerLimt,0);
-- PRINT @OrderQuantity;


-- DECLARE @OrderQuantity INT
-- SELECT @OrderQuantity = Round((90 * Rand())+10,0);
-- PRINT @OrderQuantity;



-- Randow choice between two strings
-- DECLARE @num INT;
-- SET @num= ROUND(RAND(),0) + 1;
-- SELECT CHOOSE(@num, 'Machine', 'Manual');

-- DECLARE @num INT;
-- SET @num= CEILING(RAND()*2);
-- SELECT CHOOSE(@num, 'Machine', 'Manual');

-- DECLARE @num1 INT;
-- SET @num1= ROUND(RAND(),0) + 1;
-- SELECT @num1;

-- Random numbers between 1-100 0r 1-2 {INTEGERS}
-- SELECT CEILING(RAND()*2);
-- SELECT CEILING(RAND()*100);


-- DECLARE @num INT;
-- SET @num= CEILING(RAND()*2);
-- SELECT CHOOSE(@num, 0,1);

-- DECLARE @ID INT;
-- DECLARE @NUM INT;
-- DECLARE @Upper INT;
-- DECLARE @Lower INT;
-- SET @Lower = 1;     /* -- The lowest random number */
-- SET @Upper = 49;    /* -- The highest random number */
-- SET @ID =1;
-- WHILE @ID<=100
-- BEGIN
-- 	SET @NUM = @Lower + CONVERT(INT, (@Upper-@Lower+1)*RAND());
-- 	PRINT @ID
-- 	SET @ID = @ID+1;
-- END