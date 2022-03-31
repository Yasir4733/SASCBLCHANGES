-- AHSAN BHAI
-- Client ApparelSooperWizer
  USE [SooperWizerQA];
  ALTER TABLE [Essentials].[CutJob]
  ADD StyleTemplateID INT,
  CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
  REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);


  UPDATE [Essentials].[CutJob]
  SET StyleTemplateID = 3
  WHERE CutJobID = 55;




USE [ApparalSooperWizer]
GO
/****** Object:  Trigger [Essentials].[TR_Insert_CutPieces]    Script Date: 3/30/2022 5:27:25 PM ******/
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





USE [ApparalSooperWizer]
GO
/****** Object:  Trigger [Essentials].[TR_update_CutPieces]    Script Date: 3/30/2022 5:27:42 PM ******/
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
