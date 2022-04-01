USE [ApparalSooperWizer];
-- AHSAN BHAI 
-- Local And Client QA

ALTER TABLE [Data].[AuditFormSession]
ADD ShiftID INT,
CONSTRAINT FK_InlineSession_Shift FOREIGN KEY(ShiftID) REFERENCES [Essentials].[Shift](ShiftID);

UPDATE [Data].[AuditFormSession]
SET ShiftID = 1 
WHERE 
AuditFormSessionID >=1;



----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Local And Client QA
-- ApparelSooperWizer

USE [SooperWizerQA];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

USE [SooperWizerQA];
ALTER TABLE [Data].[AuditFormSession]
ADD ShiftID INT,
CONSTRAINT FK_InlineSession_Shift FOREIGN KEY(ShiftID) REFERENCES [Essentials].[Shift](ShiftID);


USE [SooperWizerQA];
ALTER TABLE [Data].[AuditFormSession]
ADD 
CONSTRAINT FK_InlineSession_Shift FOREIGN KEY(ShiftID) REFERENCES [Essentials].[Shift](ShiftID);


USE [SooperWizerQA]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);





USE [SooperWizer];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

USE [SooperWizer];
ALTER TABLE [Data].[AuditFormSession]
ADD ShiftID INT,
CONSTRAINT FK_InlineSession_Shift FOREIGN KEY(ShiftID) REFERENCES [Essentials].[Shift](ShiftID);

USE [SooperWizer]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);



-- CHANGES IN BOTH PRODUCTION AND QA
USE [SooperWizer]
GO
/****** Object:  Trigger [Essentials].[TR_Insert_CutPieces]    Script Date: 4/1/2022 6:07:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [Essentials].[TR_Insert_CutPieces]
ON [Essentials].[CutReport]
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @CJID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @CJID = CutJobID FROM inserted;
	SELECT @STID = StyleTemplateID FROM [Essentials].[CutJob] WHERE CutJobID = @CJID;

	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END


USE [SooperWizer]
GO
/****** Object:  Trigger [Essentials].[TR_update_CutPieces]    Script Date: 4/1/2022 6:10:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [Essentials].[TR_update_CutPieces]
ON [Essentials].[CutReport]
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ID INT;
	DECLARE @QUANTITY INT;
	DECLARE @STID INT;
	DECLARE @CJID INT;
	DECLARE @PN INT;
	SET @PN = 1;
	SELECT @ID = BundleID FROM inserted;
	SELECT @QUANTITY = BundleQuantity FROM inserted;
	SELECT @CJID = CutJobID FROM inserted;
	SELECT @STID = StyleTemplateID FROM [Essentials].[CutJob] WHERE CutJobID = @CJID;

	DELETE FROM [Essentials].[PieceWiseCutReport]
    WHERE BundleID = @ID;
	
	WHILE (@PN<=@QUANTITY)
    BEGIN
        INSERT INTO [Essentials].[PieceWiseCutReport](BundleID,PieceNumber,StyleTemplateID)
        VALUES (@ID,@PN,@STID);
		SET @PN = @PN+1;
    END

END


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Local ApparelSooperWizer
  USE [ApparalSooperWizer];
  ALTER TABLE [Data].[PieceWiseScan]
  ADD
  ShortAddress VARCHAR(64),
  LongAddress VARCHAR(64),
  HostIP VARCHAR(64);



-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Local
  USE [SooperWizer];
  ALTER TABLE [Data].[PieceWiseScan]
  ADD
  ShortAddress VARCHAR(64),
  LongAddress VARCHAR(64),
  HostIP VARCHAR(64);


  USE [SooperWizerCP];
  ALTER TABLE [Data].[PieceWiseScan]
  ADD
  ShortAddress VARCHAR(64),
  LongAddress VARCHAR(64),
  HostIP VARCHAR(64);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- CLIENT COLONY

USE [SooperWizer]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);

USE [SooperWizerQA]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT CFL

USE [SooperWizer]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);

USE [SooperWizerQA]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CLIENT INDUS

USE [SooperWizer]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);

USE [SooperWizerQA]  
ALTER TABLE [Data].[PieceWiseScan]
ADD
ShortAddress VARCHAR(64),
LongAddress VARCHAR(64),
HostIP VARCHAR(64);
