-- TRIGGER insert_cut_pieces

CREATE TRIGGER [Essentials].[TR_insert_cut_pieces]
        ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    CREATE SEQUENCE numbers
    AS BIGINT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE INSERTED.BundleQuantity;

    DECLARE @Counter INT; 
    SET @Counter=1;
    WHILE (@Counter<=INSERTED.BundleQuantity)
    BEGIN

        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
        VALUES (INSERTED.BundleID,NEXT VALUE FOR numbers);
    END    
END

-- TRIGGER update_cut_pieces

CREATE TRIGGER [Essentials].[TR_update_cut_pieces]
        ON [Essentials].[CutReport]
AFTER UPDATE 
BEGIN
    SET NOCOUNT ON;
    DELETE FROM [Essentials].[PieceWiseCutReport]
    WHERE BundleID = new.BundleID;

    INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
    SELECT new.BundleID,NumberID
    FROM [Essentials].[Numbers]
    WHERE NumberID <= new.BundleQuantity;
END



--CREATE SEQUENCE numbers
--AS BIGINT
--START WITH 1
--INCREMENT BY 1
--MINVALUE 1
--MAXVALUE INSERTED.BundleQuantity;

--SELECT NEXT VALUE FOR numbers;





CREATE TABLE `numbers` (
  `NumberID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`NumberID`)
) ;




  SELECT DISTINCT CR.[BundleID]
      ,[BundleCode]
      ,[BundleQuantity]
      ,[ScannedQuantity]
      ,[RemainingQuantity]
      ,PCR.[StyleTemplateID]
  FROM [SooperWizer].[Essentials].[CutReport] CR
  INNER JOIN 
  [Essentials].[PieceWiseCutReport] PCR
  ON CR.BundleID = PCR.BundleID;




INSERT INTO [Essentials].[CutReport](BundleCode,BundleQuantity,RemainingQuantity,CutJobID)
VALUES('BundleCode-105',20,20,4);

UPDATE [Essentials].[CutReport]
SET BundleQuantity = 25
WHERE BundleID = 109;

  INSERT INTO [Essentials].[CutReport](BundleCode,BundleQuantity,RemainingQuantity,CutJobID)
VALUES('Bundle-301',5,5,23);

UPDATE [Essentials].[CutReport]
SET BundleQuantity = 10
WHERE BundleID = 142;

-- ============================================
-- ============================================
USE [SooperWizerReplica];
GO

CREATE TRIGGER [Essentials].[TR_insert_cut_pieces]
        ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @BID INT;
	DECLARE @QUANTITY INT;
	DECLARE @PN INT; 
	SELECT @BID = INSERTED.BundleID FROM INSERTED; 
    SELECT @QUANTITY = INSERTED.BundleQuantity FROM INSERTED;
    SET @PN=1;
    WHILE (@PN<=@QUANTITY)
    BEGIN

        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
        VALUES (@BID,@PN);
        SET @PN = @PN+1;
    END    
END
GO


--- ================================================
--- ================================================

CREATE TRIGGER [Essentials].[TR_Insert_CutPieces]
ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	-- DECLARE @PN INT;
	DECLARE @QUANTITY INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
        VALUES (@ID,@PN);
		SET @PN = @PN+1;
    END

END


-- ========================================
--=========================================


USE [SooperWizerReplica]
GO

CREATE TRIGGER [Essentials].[TR_update_CutPieces]
ON [Essentials].[CutReport]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	-- DECLARE @PN INT;
	DECLARE @QUANTITY INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;

	DELETE FROM [Essentials].[PieceWiseCutReport]
    WHERE BundleID = @ID;
	
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber)
        VALUES (@ID,@PN);
		SET @PN = @PN+1;
    END

END



-- =================================
-- ================================

USE [SooperWizer];
GO

CREATE TRIGGER [Essentials].[TR_Insert_CutPieces]
ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @STID = StyleTemplateID FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END


---------------------
USE [SooperWizer]
GO

CREATE TRIGGER [Essentials].[TR_update_CutPieces]
ON [Essentials].[CutReport]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @STID = StyleTemplateID FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;

	DELETE FROM [Essentials].[PieceWiseCutReport]
    WHERE BundleID = @ID;
	
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END



-- =================================
-- =================================


USE [ApparalSooperWizer];
GO

CREATE TRIGGER [Essentials].[TR_Insert_CutPieces]
ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @STID = StyleTemplateID FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END

-----------------------------------------------

USE [ApparalSooperWizer]
GO

CREATE TRIGGER [Essentials].[TR_update_CutPieces]
ON [Essentials].[CutReport]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @STID = StyleTemplateID FROM inserted;
	PRINT @ID;
	PRINT @QUANTITY;

	DELETE FROM [Essentials].[PieceWiseCutReport]
    WHERE BundleID = @ID;
	
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END