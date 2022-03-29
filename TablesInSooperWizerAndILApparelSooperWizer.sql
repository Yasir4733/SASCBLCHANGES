USE [SooperWizer];

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)



CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)


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


ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO


-- ============================================================================================================
-- ============================================================================================================


USE [SooperWizerCP];

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)



CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)


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


ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO

-- ============================================================================================================
-- ============================================================================================================

USE [SooperWizerRT];

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)



CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)


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


ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO
-- color 32

-- Size 32









-- ============================================================================================================
-- ============================================================================================================



USE [ApparalSooperWizer];

CREATE TABLE [Essentials].[Shift](
    ShiftID INT NOT NULL IDENTITY(1,1),
    ShiftName VARCHAR(32) NOT NULL,
    StartTime TIME(0),
    EndTime TIME(0),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Shift PRIMARY KEY (ShiftID)
)





-- =======================================================================================
-- =======================================================================================

DECLARE @time time(0) = '12:15:04.1237';  
DECLARE @datetime datetime= @time;  
SELECT @time AS '@time', @datetime AS '@datetime'; 


SELECT CONVERT(TIME(0), GETDATE()) AS 'Current TIME using GETDATE()'
  


-- Shift:-
-- ShiftName,StartTime,EndTime,CreatedAt,UpdatedAt





USE [SooperWizer];

CREATE TABLE [Essentials].[Color](
    ColorID INT NOT NULL IDENTITY(1,1),
    Color VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Color PRIMARY KEY (ColorID)
)


USE [SooperWizer];
CREATE TABLE [Essentials].[Size](
    SizeID INT NOT NULL IDENTITY(1,1),
    Size VARCHAR(32) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Size PRIMARY KEY (SizeID)
)

USE [SooperWizer];
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

USE [SooperWizer];
ALTER TABLE [Essentials].[CutReport]
ADD Size VARCHAR(32);
GO
