USE [CBLCopyV2];
GO

ALTER TABLE [Essentials].[ProductionOrder]
ADD IsPoClosed BIT NOT NULL DEFAULT 0;
GO

CREATE TABLE [Data].[RejectedTotalScanning]
(
TotalScanningID INT IDENTITY(1,1) NOT NULL,
BundleWiseScanID INT NULL,
PieceWiseScanID INT NULL,
RebundleScanID INT NULL,
RebundlePieceScanID INT NULL,
MachineTypeID INT NULL,
MachineTypeCode VARCHAR(64) NULL,
MachineTypeDescription VARCHAR(64) NULL,
SectionID INT NULL,
SectionCode VARCHAR(64) NULL,
SectionDescription VARCHAR(64) NULL,
LineID INT NULL,
LineCode VARCHAR(64) NULL,
LineDescription VARCHAR(64) NULL,
WorkerID INT NULL,
WorkerCode VARCHAR(64) NULL,
WorkerDescription VARCHAR(64) NULL,
SkillLevelID INT NULL,
SkillName VARCHAR(10) NULL,
SkillRate FLOAT NULL,
OperationID INT NULL,
OperationCode VARCHAR(64) NULL,
OperationName VARCHAR(64) NULL,
OperationDescription VARCHAR(64) NULL,
Department VARCHAR(64) NULL,
PieceRate FLOAT NULL,
OperationType VARCHAR(65) NULL,
MachineID INT NULL,
MachineCode VARCHAR(64) NULL,
MachineDescription VARCHAR(64) NULL,
WorkerScanID INT NULL,
StyleTemplateID INT NULL,
StyleTemplateCode VARCHAR(64) NULL,
SaleOrderID INT NULL,
PpcOrderNum VARCHAR(64) NULL,
Customer VARCHAR(64) NULL,
CustomerStyle VARCHAR(64) NULL,
RequestCustomerPoCode VARCHAR(64) NULL,
PoNo VARCHAR(64) NULL,
CblPo VARCHAR(64) NULL,
ContractCode VARCHAR(64) NULL,
OrderNum VARCHAR(64) NULL,
OrderQuantity INT NULL,
XMillDate date NULL,
FabricYield FLOAT NULL,
FabricStyle VARCHAR(64) NULL,
Wash VARCHAR(64) NULL,
Fabric VARCHAR(64) NULL,
TypeFly VARCHAR(64) NULL,
BackPocketTemplate VARCHAR(64) NULL,
ProductionOrderID INT NULL,
FollowsOperationSequence BIT NULL,
MarkerID INT NULL,
MarkerCode VARCHAR(64) NULL,
CutJobID INT NULL,
CutNo INT NULL,
Plies INT NULL,
CutQuantity INT NULL,
Repeats INT NULL,
BundleID INT NOT NULL,
BundleCode VARCHAR(64) NULL,
Size VARCHAR(20) NULL,
Inseam VARCHAR(20) NULL,
BundleQuantity INT NULL,
PieceID INT NULL,
PieceNumber INT NULL,
RebundleID INT NULL,
ShortAddress VARCHAR(64) NULL,
LongAddress VARCHAR(64) NULL,
HostIP VARCHAR(64) NULL,
CurrentStyleTemplateID INT NULL,
CurrentStyleTemplateCode VARCHAR(64) NULL,
RejectionType VARCHAR(10) NOT NULL,
CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),

CONSTRAINT PK_RejectedTotalScanningID PRIMARY KEY (TotalScanningID),

CONSTRAINT FK_RejectedTotalScanning_BundleWiseScan FOREIGN KEY(BundleWiseScanID) REFERENCES [Data].[BundleWiseScan] (BundleWiseScanID),

CONSTRAINT FK_RejectedTotalScanning_Operation FOREIGN KEY(OperationID) REFERENCES [Essentials].[Operation] (OperationID),

CONSTRAINT FK_RejectedTotalScanning_PieceWiseScan FOREIGN KEY(PieceWiseScanID) REFERENCES [Data].[PieceWiseScan] (PieceWiseScanID),

CONSTRAINT FK_RejectedTotalScanning_RebundlePieceScan FOREIGN KEY(RebundlePieceScanID) REFERENCES [Rebundle].[RebundlePieceScan] (RebundlePieceScanID),

CONSTRAINT FK_RejectedTotalScanning_RebundleScan FOREIGN KEY(RebundleScanID) REFERENCES [Rebundle].[RebundleScan] (RebundleScanID)

)
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE [Data].[RejectedBundleWiseScan]
(
BundleWiseScanID INT IDENTITY(1,1) NOT NULL,
BundleID INT NOT NULL,
WorkerScanID INT NULL,
WorkerID INT NOT NULL,
LineID INT NOT NULL,
MachineID INT NOT NULL,
OperationID INT NOT NULL,
ShortAddress VARCHAR(64) NULL,
LongAddress VARCHAR(64) NULL,
HostIP VARCHAR(64) NULL,
RejectionType VARCHAR(10) NOT NULL,
CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),

CONSTRAINT PK_RejectedBundleWiseScanID PRIMARY KEY (BundleWiseScanID),

CONSTRAINT UQ_Rejected_BundleID_OperationID UNIQUE (BundleID,OperationID),

CONSTRAINT FK_RejectedBundleWiseScan_CutReport FOREIGN KEY(BundleID) REFERENCES [Essentials].[CutReport] (BundleID),

CONSTRAINT FK_RejectedBundleWiseScan_Line FOREIGN KEY(LineID) REFERENCES [Essentials].[Line] (LineID),

CONSTRAINT FK_RejectedBundleWiseScan_Machine FOREIGN KEY(MachineID) REFERENCES [Essentials].[Machine] (MachineID),

CONSTRAINT FK_RejectedBundleWiseScan_Operation FOREIGN KEY(OperationID) REFERENCES [Essentials].[Operation] (OperationID),

CONSTRAINT FK_RejectedBundleWiseScan_Worker FOREIGN KEY(WorkerID) REFERENCES [Essentials].[Worker] (WorkerID),

CONSTRAINT FK_RejectedBundleWiseScan_WorkerScan FOREIGN KEY(WorkerScanID) REFERENCES [Data].[WorkerScan] (WorkerScanID)

) 
GO
