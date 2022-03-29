USE [SooperWizer];

CREATE TABLE [Essentials].[PrintCutReport](
    CutReportPrintID INT NOT NULL IDENTITY(1,1),
    SaleOrderCode VARCHAR(100) NOT NULL,
    ProductionOrderCode VARCHAR(100) NOT NULL,
    CutNo VARCHAR(32) NOT NULL,
    BundleCode VARCHAR(64) NOT NULL,
    BundelQuantity INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_PrintCutReport PRIMARY KEY (CutReportPrintID)
)



USE [SooperWizer];

ALTER TABLE [Essentials].[MarkerMapping] 
ALTER COLUMN Size VARCHAR (32);

USE [SooperWizerRT];

ALTER TABLE [Essentials].[MarkerMapping] 
ALTER COLUMN Size VARCHAR (32);

USE [SooperWizerCP];

ALTER TABLE [Essentials].[MarkerMapping] 
ALTER COLUMN Size VARCHAR (32);


-- Local
-- ApparelSooperWizer 

EXEC sp_RENAME '[Essentials].[CutJob].Plies' , 'CutQuantity', 'COLUMN'

-- Colony
-- SooperWizer
EXEC sp_RENAME '[Essentials].[CutJob].Plies' , 'CutQuantity', 'COLUMN'


CutQuantity