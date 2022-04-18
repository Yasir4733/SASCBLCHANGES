-- AHSAN  BHAI
-- ApparelSooperWizer LOCAL


ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32),
Color VARCHAR(32);

ALTER TABLE [Essentials].[CutJob]
DROP COLUMN Size, Color;

















































-- Aborted Changes
ALTER TABLE [Essentials].[CutReport]
ADD ProductionOrderClientID INT,
CONSTRAINT FK_CutReport_ProductionOrderClient FOREIGN KEY (ProductionOrderClientID)
REFERENCES  [Essentials].[ProductionOrderClient] (ProductionOrderClientID);

USE [ApparalSooperWizer]
GO
ALTER TABLE [Essentials].[CutReport] DROP CONSTRAINT [FK_CutReport_ProductionOrderClient]
GO
ALTER TABLE [Essentials].[CutReport] DROP COLUMN ProductionOrderClientID
GO
