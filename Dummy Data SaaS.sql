USE [SaaS];

-- [primary_essentials].[Clients]
INSERT INTO [primary_essentials].[Clients](ClientName)
VALUES('CFL');

-- ===========================================================================================================================
-- ===========================================================================================================================


-- [primary_essentials].[MajorOrder]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 50
BEGIN
    INSERT INTO [primary_essentials].[MajorOrder](ClientID)
    VALUES(1)
    -- PRINT @ID
    SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================


-- [primary_essentials].[MinorOrder]
DECLARE @ID INT;
SET @ID = 1;
DECLARE @v1 INT;
SET @v1 = 1;

WHILE @ID <= 2500
BEGIN

	IF @ID%51=0
		BEGIN
			SET @v1 = @v1 + 1 
		END
    -- PRINT @ID
	-- PRINT @V1
	INSERT INTO [primary_essentials].[MinorOrder](MajorOrderID)
    VALUES(@V1)
	SET @ID = @ID + 1
    
END

-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_essentials].[MajorOperation]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 10
BEGIN
    INSERT INTO [primary_essentials].[MajorOperation](ClientID)
        VALUES(1)
    -- PRINT @ID
    SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_essentials].[MinorOperation]
DECLARE @ID INT;
SET @ID = 1;
DECLARE @v1 INT;
SET @v1 = 1;


WHILE @ID <= 100
BEGIN

	IF @ID%11=0
		BEGIN
			SET @v1 = @v1 + 1 
		END
    -- PRINT @ID
	-- PRINT @V1
	INSERT INTO [primary_essentials].[MinorOperation](MajorOperationID)
	VALUES(@V1)
	SET @ID = @ID + 1
    
END

-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_essentials].[StyleTemplate]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 3
BEGIN
    INSERT INTO [primary_essentials].[StyleTemplate](ClientID)
        VALUES(1)
    -- PRINT @ID
    SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_chill].[MachineType]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 10
BEGIN
    INSERT INTO [primary_chill].[MachineType](ClientID)
        VALUES(1)
    -- PRINT @ID
    SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_essentials].[StyleLayout]

INSERT INTO [primary_essentials].[StyleLayout]([StyleTemplateID],[MajorOperationID],[MinorOperationID],[MachineTypeID],[OperationSequence],[PieceRate],[SMV])
        VALUES(1,1,1,1,1,0.43,0.53),(2,2,2,2,2,0.63,0.53),(3,3,2,3,3,0.73,0.33);




-- [primary_essentials].[StyleLayout]
DECLARE @ID INT;
SET @ID = 1;
DECLARE @v1 INT;
SET @v1 = 1;
DECLARE @num INT;

WHILE @ID <= 10
BEGIN
	SET @num= FLOOR(RAND()*19);
	INSERT INTO [primary_essentials].[StyleLayout]([StyleTemplateID],[MajorOperationID],[MinorOperationID],[MachineTypeID],[OperationSequence],[PieceRate],[SMV])
	VALUES(3,@ID,@ID,1,@ID,ROUND(RAND(),2),ROUND(RAND(),2))
	SET @ID = @ID + 1
    
END


-- ===========================================================================================================================
-- ===========================================================================================================================


-- [primary_essentials].[BundleCutReport]
DECLARE @ID INT;
SET @ID = 1;
DECLARE @v1 INT;
SET @v1 = 1;

WHILE @ID <= 250000
BEGIN
	IF @ID%101=0
		BEGIN
			SET @v1 = @v1 + 1 
		END
    -- PRINT @ID
	-- PRINT @V1
	INSERT INTO [primary_essentials].[BundleCutReport](MinorOrderID)
	VALUES(@V1)
	SET @ID = @ID + 1
END




-- ===========================================================================================================================
-- ===========================================================================================================================

-- [primary_essentials].[GroupCard]

DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 50000
BEGIN
	INSERT INTO [primary_essentials].[GroupCard](GroupCardDescription)
	VALUES('GroupCardDescription-'+ CAST(@ID AS VARCHAR(30)))
	SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================


-- [primary_essentials].[Tag]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 50000
BEGIN
	INSERT INTO [primary_essentials].[Tag](TagID)
	VALUES(@ID)
	PRINT @ID
	SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================


-- [primary_essentials].[GroupCardDetails]
DECLARE @ID INT;
SET @ID = 1;
DECLARE @v1 INT;
SET @v1 = 1;

WHILE @ID <= 50000
BEGIN
	IF @ID%25=0
		BEGIN
			SET @v1 = @v1 + 1 
		END

	INSERT INTO [primary_essentials].[GroupCardDetails](GroupCardID,PieceCutReportID)
	VALUES(@V1,FLOOR(RAND()*(300000-1+1))+1)
	SET @ID = @ID + 1
END

-- ===========================================================================================================================
-- ===========================================================================================================================




-- [primary_assignment].[Worker]
DECLARE @ID INT;
SET @ID = 1;

WHILE @ID <= 2000
BEGIN
    INSERT INTO [primary_assignment].[Worker](ClientID,LatestBundleCutReportID,LatestPieceCutReportID)
        VALUES(1,250000,6250000)
    -- PRINT @ID
    SET @ID = @ID + 1
END


-- ===========================================================================================================================
-- ===========================================================================================================================










-- TRIGGER

USE [SaaS_v7]
GO


CREATE TRIGGER [primary_essentials].[TR_Insert_CutPieces]
ON [primary_essentials].[BundleCutReport]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	SET @QUANTITY  = 25;
	DECLARE @PN INT;
	SET @PN = 1;
	DECLARE @num INT;

	SELECT @ID = BundleCutReportID FROM inserted;
	
	WHILE (@PN<=@QUANTITY)
    BEGIN
	SET @num= CEILING(RAND()*3);
        INSERT INTO [primary_essentials].[PieceCutReport](BundleCutReportID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,CHOOSE(@num, 1,2,3));
		SET @PN = @PN+1;
    END

END

SELECT COUNT(*) AS BUNDLES FROM [primary_essentials].[BundleCutReport] 

SELECT COUNT(*)  AS PIECES FROM [primary_essentials].[PieceCutReport]















CREATE TABLE [primary_essentials].[numbers](
 numberId INT NOT NULL IDENTITY,
 PRIMARY KEY (numberId)
)

SET IDENTITY_INSERT [primary_essentials].[numbers] ON
DECLARE @ID INT;
SET @ID = 1;

-- [primary_essentials].[numbers]
WHILE @ID <= 1001
BEGIN
    INSERT INTO [primary_essentials].[numbers](numberId)
        VALUES(@ID)
    PRINT @ID
    SET @ID = @ID + 1
END

SET IDENTITY_INSERT [primary_essentials].[numbers] OFF