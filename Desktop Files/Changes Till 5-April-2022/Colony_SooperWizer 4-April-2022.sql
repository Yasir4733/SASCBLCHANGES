-- COLONY 
-- AHSAN BHAI 4-April-2022


USE [SooperWizerQA];

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
GO

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)
GO


CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)
GO

CREATE TABLE [Essentials].[ProductionOrderClient](
    ProductionOrderClientID INT NOT NULL IDENTITY(1,1),
    ProductionOrderID INT NOT NULL,
    Color VARCHAR(32) NOT NULL,
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_ProductionOrderClient PRIMARY KEY (ProductionOrderClientID),
    CONSTRAINT FK_ProductionOrderClient_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder](ProductionOrderID)
)
GO

ALTER TABLE [Essentials].[MarkerMapping] 
ALTER COLUMN Size VARCHAR (32) NOT NULL;
GO

ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO

EXEC sp_RENAME '[Essentials].[CutJob].CutQuantity' , 'Plies', 'COLUMN'

-- StyleTemplateID In CutJob And Changes In Triggers ------ Pending



--------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------


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
GO

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)
GO


CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)
GO

CREATE TABLE [Essentials].[ProductionOrderClient](
    ProductionOrderClientID INT NOT NULL IDENTITY(1,1),
    ProductionOrderID INT NOT NULL,
    Color VARCHAR(32) NOT NULL,
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_ProductionOrderClient PRIMARY KEY (ProductionOrderClientID),
    CONSTRAINT FK_ProductionOrderClient_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder](ProductionOrderID)
)
GO

ALTER TABLE [Essentials].[MarkerMapping] 
ALTER COLUMN Size VARCHAR (32) NOT NULL;
GO

ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO

EXEC sp_RENAME '[Essentials].[CutJob].CutQuantity' , 'Plies', 'COLUMN'
