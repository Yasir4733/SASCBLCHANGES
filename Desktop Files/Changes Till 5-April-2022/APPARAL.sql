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




  USE [ApperalSooperWizer];
  ALTER TABLE [Essentials].[CuttingManpower]
  ADD LineID INT NOT NULL,
  CONSTRAINT FK_CuttingManpower_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID);
  
  ALTER TABLE [Essentials].[CuttingManpower]
  ALTER COLUMN LineID INT NOT NULL;



--  CLIENT APPARELSOOPERWIZERQA
ALTER TABLE [Essentials].[CuttingManpower]
ADD LineID INT NOT NULL,
CONSTRAINT FK_CuttingManpower_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID);

CREATE TABLE [Essentials].[Shift](
    ShiftID INT NOT NULL IDENTITY(1,1),
    ShiftName VARCHAR(32) NOT NULL,
    StartTime TIME(0),
    EndTime TIME(0),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Shift PRIMARY KEY (ShiftID)
)


--  CLIENT APPARELSOOPERWIZERQA
CREATE TABLE [Essentials].[Shift](
    ShiftID INT NOT NULL IDENTITY(1,1),
    ShiftName VARCHAR(32) NOT NULL,
    StartTime TIME(0),
    EndTime TIME(0),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Shift PRIMARY KEY (ShiftID)
)
  ALTER TABLE [Essentials].[CuttingManpower]
ADD LineID INT NOT NULL,
CONSTRAINT FK_CuttingManpower_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID);

