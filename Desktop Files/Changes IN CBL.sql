USE [CBLCopyV2];


CREATE TABLE [Essentials].[ParentStyleTemplate]
(
    ParentStyleTemplateID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateDescription VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()
    CONSTRAINT PK_ParentStyleTemplate PRIMARY KEY (ParentStyleTemplateID),
    CONSTRAINT UQ_ParentStyleTemplateDescription UNIQUE (ParentStyleTemplateDescription)

);




CREATE TABLE [Essentials].[ParentStyleTemplateDetail]
(
    ParentStyleTemplateDetailID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateID INT NOT NULL,
    ParentStyleTemplateDescription VARCHAR(64),
    BasicMinutesWithTrainingPercentage FLOAT NOT NULL,
    OperationID INT NOT NULL,
    OperationCode VARCHAR(64),
    OperationName VARCHAR(64),
    OperationDescription VARCHAR(64),
    SkillLevelID INT,
    SkillName VARCHAR(10),
    SkillRate FLOAT,
    PieceRate FLOAT NOT NULL,
    OperationType VARCHAR(64),
    Department VARCHAR(64),
    SectionID INT,
    SectionCode VARCHAR(64),
    SectionDescription VARCHAR(64),
    OperationSequence INT NOT NULL,
    BasicMinutes INT NOT NULL,
    NumberOfMachine INT NOT NULL,
    IsFirst BIT NOT NULL DEFAULT 0,
    IsLast BIT NOT NULL DEFAULT 0,
    IsPieceScan BIT NOT NULL,
    MachineTypeID INT NOT NULL,
    MachineTypeCode VARCHAR(64),
    MachineTypeDescription VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_ParentStyleTemplateDetail PRIMARY KEY (ParentStyleTemplateDetailID),
    CONSTRAINT UQ_ParentStyleTemplateDetail_ParentStyleTemplateID_OperationID UNIQUE (ParentStyleTemplateID, OperationID),
    CONSTRAINT FK_ParentStyleTemplateDetail_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID),
    CONSTRAINT FK_ParentStyleTemplateDetail_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID),
    CONSTRAINT FK_ParentStyleTemplateDetail_SkillLevel FOREIGN KEY (SkillLevelID) REFERENCES [Essentials].[SkillLevel](SkillLevelID),
    CONSTRAINT FK_ParentStyleTemplateDetail_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID),
    CONSTRAINT FK_ParentStyleTemplateDetail_ParentStyleTemplate FOREIGN KEY (ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate] (ParentStyleTemplateID)


);


ALTER TABLE [Essentials].[CutReport]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);


ALTER TABLE [Essentials].[StyleTemplate]
ADD ParentStyleTemplateID INT,
CONSTRAINT FK_StyleTemplate_ParentStyleTemplate FOREIGN KEY(ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate](ParentStyleTemplateID);





ALTER TABLE [Data].[WorkerScan]
ADD IsActive BIT NOT NULL DEFAULT 1;


ALTER TABLE [Essentials].[ParentStyleTemplate]
ADD 
CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
UpdatedAt DATETIME NOT NULL DEFAULT GETDATE();

USE [CBLQA];

ALTER TABLE [Data].[TotalScanning]
ADD
CurrentStyleTemplateID INT ,
CurrentStyleTemplateCode VARCHAR(64);

 ALTER TABLE [Essentials].[CutJob]
 ADD IsClosed BIT NOT NULL DEFAULT 0;

-- ======================================================
-- ======================================================


USE [SooperWizer];


CREATE TABLE [Essentials].[ParentStyleTemplate]
(
    ParentStyleTemplateID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateDescription VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()

    CONSTRAINT PK_ParentStyleTemplate PRIMARY KEY (ParentStyleTemplateID),
    CONSTRAINT UQ_ParentStyleTemplateDescription UNIQUE (ParentStyleTemplateDescription)

);


CREATE TABLE [Essentials].[ParentStyleTemplateDetail]
(
    ParentStyleTemplateDetailID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateID INT NOT NULL,
    OperationID INT NOT NULL,
	OperationSequence INT NOT NULL,
	ScanType VARCHAR(10) NOT NULL,
	IsFirst BIT NOT NULL DEFAULT 0,
	IsLast BIT NOT NULL DEFAULT 0,
	MachineTypeID INT NOT NULL,
	SMV FLOAT NULL,
	PieceRate FLOAT NULL,
	IsCritical bit NOT NULL DEFAULT 0,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT PK_ParentStyleTemplateDetail PRIMARY KEY (ParentStyleTemplateDetailID),
    CONSTRAINT UQ_ParentStyleTemplateDetail_ParentStyleTemplateID_OperationID UNIQUE (ParentStyleTemplateID, OperationID),
	CONSTRAINT FK_ParentStyleTemplateDetail_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
    CONSTRAINT FK_ParentStyleTemplateDetail_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID),
	CONSTRAINT FK_ParentStyleTemplateDetail_StyleTemplate FOREIGN KEY (ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate] (ParentStyleTemplateID)

);



ALTER TABLE [Essentials].[CutReport]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);


ALTER TABLE [Essentials].[StyleTemplate]
ADD ParentStyleTemplateID INT,
CONSTRAINT FK_StyleTemplate_ParentStyleTemplate FOREIGN KEY(ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate](ParentStyleTemplateID);

ALTER TABLE  [Essentials].[Machine]
ADD CONSTRAINT UQ_Machine_MachineID_BoxID UNIQUE (MachineID, BoxID);


ALTER TABLE [Essentials].[ParentStyleTemplate]
ADD 
CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
UpdatedAt DATETIME NOT NULL DEFAULT GETDATE();



USE [SooperWizer];

ALTER TABLE [Essentials].[User]
ADD
UserImageUrl VARCHAR(2056) DEFAULT NULL,
UserThumbnailUrl VARCHAR(2056) DEFAULT NULL;



-- =============================================

USE [ApparelSooperWizer];


CREATE TABLE [Essentials].[ParentStyleTemplate]
(
    ParentStyleTemplateID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateDescription VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE()

    CONSTRAINT PK_ParentStyleTemplate PRIMARY KEY (ParentStyleTemplateID),
    CONSTRAINT UQ_ParentStyleTemplateDescription UNIQUE (ParentStyleTemplateDescription)

);


CREATE TABLE [Essentials].[ParentStyleTemplateDetail]
(
    ParentStyleTemplateDetailID INT NOT NULL IDENTITY(1,1),
    ParentStyleTemplateID INT NOT NULL,
    OperationID INT NOT NULL,
	OperationSequence INT NOT NULL,
	ScanType VARCHAR(10) NOT NULL,
	IsFirst BIT NOT NULL DEFAULT 0,
	IsLast BIT NOT NULL DEFAULT 0,
	MachineTypeID INT NOT NULL,
	SMV FLOAT NULL,
	PieceRate FLOAT NULL,
	IsCritical bit NOT NULL DEFAULT 0,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	CONSTRAINT PK_ParentStyleTemplateDetail PRIMARY KEY (ParentStyleTemplateDetailID),
    CONSTRAINT UQ_ParentStyleTemplateDetail_ParentStyleTemplateID_OperationID UNIQUE (ParentStyleTemplateID, OperationID),
	CONSTRAINT FK_ParentStyleTemplateDetail_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
    CONSTRAINT FK_ParentStyleTemplateDetail_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID),
	CONSTRAINT FK_ParentStyleTemplateDetail_StyleTemplate FOREIGN KEY (ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate] (ParentStyleTemplateID)

);



ALTER TABLE [Essentials].[CutReport]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);


ALTER TABLE [Essentials].[StyleTemplate]
ADD ParentStyleTemplateID INT,
CONSTRAINT FK_StyleTemplate_ParentStyleTemplate FOREIGN KEY(ParentStyleTemplateID) REFERENCES [Essentials].[ParentStyleTemplate](ParentStyleTemplateID);



ALTER TABLE [Essentials].[User]
ADD
UserImageUrl VARCHAR(2056) DEFAULT NULL,
UserThumbnailUrl VARCHAR(2056) DEFAULT NULL;




ALTER TABLE [Essentials].[CutReport]
ADD Embellishment BIT NOT NULL DEFAULT 0;


ALTER TABLE [Essentials].[StyleTemplate]
DROP CONSTRAINT UQ_StyleTemplateCode;


ALTER TABLE [Essentials].[StyleTemplate]
ADD CONSTRAINT UQ_StyleTemplateCode_ParentStyleTemplate
UNIQUE (StyleTemplateCode, ParentStyleTemplateID);

ALTER TABLE [Essentials].[CutReport]
ADD CuttingTableID INT 
CONSTRAINT FK_CutReport_CuttingTable FOREIGN KEY (CuttingTableID) REFERENCES [Essentials].[CuttingTable](CuttingTableID);

ALTER TABLE [Essentials].[CutReport]
ADD CuttingTableID INT 
CONSTRAINT FK_CutReport_CuttingTable FOREIGN KEY (CuttingTableID) REFERENCES [Essentials].[CuttingTable](CuttingTableID);








--  SooperWizer And SooperWizerQA Indus
ALTER TABLE [Essentials].[Box] ADD  DEFAULT getdate() FOR IssueDate;
ALTER TABLE [Essentials].[Box] ADD  DEFAULT getdate() FOR IssueDate;




APPARELSOOPERWIZER

  ALTER TABLE [Essentials].[CuttingManpower]
  ADD LineID INT,
  CONSTRAINT FK_CuttingManpower_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID);
  
  UPDATE [Essentials].[CuttingManpower]
  SET LineID = 1
  WHERE CuttingManpowerID = 6;

  ALTER TABLE [Essentials].[CuttingManpower]
ALTER COLUMN LineID INT NOT NULL;
