USE [MASTER];
GO
CREATE DATABASE  [ApperalSooperWizer];
GO
USE [ApperalSooperWizer];
GO
CREATE SCHEMA [Essentials];
GO
CREATE SCHEMA [Data];
GO
-- ================================================
-- =================================================
CREATE TABLE [Essentials].[StyleTemplate] (
  StyleTemplateID INT NOT NULL IDENTITY(1,1),
  StyleTemplateCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_StyleTemplate PRIMARY KEY (StyleTemplateID),
  CONSTRAINT UQ_StyleTemplateCode UNIQUE (StyleTemplateCode)
);


CREATE TABLE [Essentials].[Section] (
  SectionID INT NOT NULL IDENTITY(1,1),
  SectionCode VARCHAR(64) NOT NULL,
  SectionDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Section PRIMARY KEY (SectionID),
  CONSTRAINT UQ_SectionCode UNIQUE (SectionCode)
);

CREATE TABLE [Essentials].[ScanGroup] (
  GroupID INT NOT NULL IDENTITY(1,1),
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_ScanGroup PRIMARY KEY (GroupID)
);

CREATE TABLE [Essentials].[Line] (
  LineID INT NOT NULL IDENTITY(1,1),
  LineCode VARCHAR(64) NOT NULL,
  LineDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Line PRIMARY KEY (LineID),
  CONSTRAINT UQ_LineCode UNIQUE(LineCode)
);

CREATE TABLE [Essentials].[Worker] (
  WorkerID INT NOT NULL IDENTITY(1,1),
  WorkerCode VARCHAR(64) NOT NULL,
  WorkerDescription VARCHAR(64) NOT NULL,
  WorkerImageUrl VARCHAR(2056) DEFAULT NULL,
  WorkerThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  -- AllocatedMachines json DEFAULT NULL,
  TodayCheckin DATETIME DEFAULT NULL,
  TodayProduction INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Worker PRIMARY KEY (WorkerID),
  CONSTRAINT UQ_WorkerCode UNIQUE (WorkerCode)
);


CREATE TABLE [Essentials].[Module] (
  ModuleID INT NOT NULL IDENTITY(1,1),
  ModuleCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Module PRIMARY KEY (ModuleID),
  CONSTRAINT UQ_ModuleCode UNIQUE (ModuleCode)
);


CREATE TABLE [Essentials].[Box] (
  BoxID INT NOT NULL IDENTITY(1,1),
  BoxCode VARCHAR(64) NOT NULL,
  CurrentAddress INT NOT NULL DEFAULT 0,
  IssueDate DATETIME NOT NULL DEFAULT GETDATE(),
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Box PRIMARY KEY (BoxID),
  CONSTRAINT UQ_BoxCode UNIQUE   (BoxCode)
);


CREATE TABLE [Essentials].[MachineType] (
  MachineTypeID INT NOT NULL IDENTITY(1,1),
  MachineTypeCode VARCHAR(64) NOT NULL,
  MachineTypeDescription VARCHAR(64) NOT NULL,
  Allowance FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_MachineType PRIMARY KEY (MachineTypeID),
  CONSTRAINT UQ_MachineTypeCode UNIQUE (MachineTypeCode)
);


CREATE TABLE [Essentials].[SaleOrder] (
  SaleOrderID INT NOT NULL IDENTITY(1,1),
  SaleOrderCode VARCHAR(100) NOT NULL,
  Customer VARCHAR(64) NOT NULL,
  OrderQuantity INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_SaleOrder PRIMARY KEY (SaleOrderID),
  CONSTRAINT UQ_SaleOrderCode UNIQUE (SaleOrderCode)
);


CREATE TABLE [Essentials].[Department] (
  DepartmentID INT NOT NULL IDENTITY(1,1),
  DepartmentName VARCHAR(40) NOT NULL,
  CreatedAt DATETIME DEFAULT GETDATE(),
  UpdatedAt DATETIME DEFAULT GETDATE(),
  CONSTRAINT UQ_Department_DepartmentName UNIQUE(DepartmentName),
  CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

CREATE TABLE [Essentials].[Operation] (
  OperationID INT NOT NULL IDENTITY(1,1),
  OperationCode VARCHAR(64) NOT NULL,
  OperationName VARCHAR(64) NOT NULL,
  OperationDescription VARCHAR(64) NOT NULL,
  PieceRate FLOAT DEFAULT NULL,
  OperationType VARCHAR(64) NOT NULL,
  OperationImageUrl VARCHAR(2056) DEFAULT NULL,
  OperationThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  DepartmentID INT NOT NULL,
  SMV FLOAT DEFAULT NULL,
  CONSTRAINT PK_Operation PRIMARY KEY (OperationID),
  CONSTRAINT UQ_OperationCode UNIQUE (OperationCode),
  CONSTRAINT FK_operation_department FOREIGN KEY (DepartmentID) REFERENCES [Essentials].[Department] (DepartmentID),
  CONSTRAINT FK_Operation_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT CK_Operation_OperationType CHECK ((OperationType in ('Manual','Machine')))
);

CREATE TABLE [Essentials].[CuttingTable] (
  CuttingTableID INT NOT NULL IDENTITY(1,1),
  CuttingTableCode VARCHAR(40) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CuttingTable PRIMARY KEY (CuttingTableID)
);

CREATE TABLE [Essentials].[CuttingManpower] (
  CuttingManpowerID INT NOT NULL IDENTITY(1,1),
  CuttingTableID INT NOT NULL,
  CuttingManpowerDate DATE NOT NULL,
  Manpower FLOAT NOT NULL,
  Shift VARCHAR(20) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CuttingManpower PRIMARY KEY (CuttingManpowerID),
  CONSTRAINT FK_CuttingManpower_CuttingTable FOREIGN KEY (CuttingTableID) REFERENCES [Essentials].[CuttingTable] (CuttingTableID),
  CONSTRAINT CK_CuttingManpower_Shift CHECK ((Shift IN ('Morning','Evening','Night')))
  );


CREATE TABLE [Essentials].[TargetFeeding] (
  TargetFeedingID INT NOT NULL IDENTITY(1,1),
  TargetDate date NOT NULL,
  TargetShift VARCHAR(20) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  PlanEfficiency FLOAT NOT NULL,
  PlanProduction FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_TargetFeeding PRIMARY KEY (TargetFeedingID),
  CONSTRAINT FK_TargetFeeding_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_TargetFeeding_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT CK_TargetFeeding_TargetShift CHECK ((TargetShift in ('Morning','Evening','Night'))));


CREATE TABLE [Essentials].[ProductionOrder] (
  ProductionOrderID INT NOT NULL IDENTITY(1,1),
  ProductionOrderCode VARCHAR(100) NOT NULL,
  StyleCode VARCHAR(100) NOT NULL,
  Article VARCHAR(100) NOT NULL,
  CuttingSAM FLOAT DEFAULT NULL,
  ExFactoryDate DATE DEFAULT NULL,
  SaleOrderID INT NOT NULL,
  StyleTemplateID INT DEFAULT NULL,
  IsFollowOperationSequence BIT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_ProductionOrder PRIMARY KEY (ProductionOrderID),
  CONSTRAINT UQ_ProductionOrderCode UNIQUE (ProductionOrderCode),
  CONSTRAINT FK_ProductionOrder_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES [Essentials].[SaleOrder] (SaleOrderID),
  CONSTRAINT FK_ProductionOrder_StyleTempate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID)
);


CREATE TABLE [Essentials].[ProductionOrderClient] (
  ProductionOrderClientID INT NOT NULL IDENTITY(1,1),
  ProductionOrderID INT NOT NULL,
  Size VARCHAR(20) NOT NULL,
  Color VARCHAR(20) NOT NULL,
  RequiredPieces INT NOT NULL,
  PlannedPieces INT NOT NULL,
  MainBodyFabricType VARCHAR(100) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_ProductionOrderClient PRIMARY KEY (ProductionOrderClientID),
  CONSTRAINT UQ_ProductionOrder_Size_Color UNIQUE (ProductionOrderID,Size,Color),
  CONSTRAINT FK_ProductionOrderClient_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID)
);


CREATE TABLE [Essentials].[Marker] (
  MarkerID INT NOT NULL IDENTITY(1,1),
  MarkerCode VARCHAR(64) NOT NULL,
  ProductionOrderID INT NOT NULL,
  -- MarkerMapping json NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Marker PRIMARY KEY (MarkerID),
  CONSTRAINT UQ_MarkerCodePoID UNIQUE (MarkerCode,ProductionOrderID),
  CONSTRAINT FK_Marker_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID)
);


CREATE TABLE [Essentials].[StyleBulletin] (
  StyleBulletinID INT NOT NULL IDENTITY(1,1),
  StyleTemplateID INT NOT NULL,
  OperationID INT NOT NULL,
  OperationSequence INT NOT NULL,
  ScanType VARCHAR(10) NOT NULL,
  IsFirst BIT NOT NULL DEFAULT 0,
  IsLast BIT NOT NULL DEFAULT 0,
  MachineTypeID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  SMV FLOAT DEFAULT NULL,
  PieceRate FLOAT DEFAULT NULL,
  IsCritical BIT DEFAULT 0,
  CONSTRAINT PK_StyleBulletin PRIMARY KEY (StyleBulletinID),
  CONSTRAINT UQ_StyleBulletin_StyleTemplateID_OperationID UNIQUE (StyleTemplateID,OperationID),
  CONSTRAINT FK_StyleBulletin_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType] (MachineTypeID),
  CONSTRAINT FK_StyleBulletin_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_StyleBulletin_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID),
  CONSTRAINT CK_StyleBulletin_ScanType CHECK ((ScanType in ('Bundle','Piece')))
);

CREATE TABLE [Essentials].[CutJob] (
  CutJobID INT NOT NULL IDENTITY(1,1),
  CutNo VARCHAR(32) NOT NULL,
  ProductionOrderID INT NOT NULL,
  Size VARCHAR(20) NOT NULL,
  Color VARCHAR(20) NOT NULL,
  CutQuantity INT NOT NULL,
  MarkerID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CutJob PRIMARY KEY (CutJobID),
  CONSTRAINT UQ_ProductionOrder_CutNo UNIQUE (ProductionOrderID,CutNo),
  CONSTRAINT FK_CutJob_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker] (MarkerID),
  CONSTRAINT FK_CutJob_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID)
);

CREATE TABLE [Essentials].[CutReport] (
  BundleID INT NOT NULL IDENTITY(1,1),
  BundleCode VARCHAR(64) NOT NULL,
  BundleQuantity INT NOT NULL,
  ScannedQuantity INT NOT NULL DEFAULT 0,
  RemainingQuantity INT NOT NULL,
  CutJobID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  Embellishment BIT DEFAULT (0),
  CONSTRAINT PK_CutReport PRIMARY KEY (BundleID),
  CONSTRAINT UQ_CutJobID_BundleCode UNIQUE(CutJobID,BundleCode),
  CONSTRAINT FK_CutReport_CutJob FOREIGN KEY (CutJobID) REFERENCES [Essentials].[CutJob] (CutJobID)
);


CREATE TABLE [Essentials].[PieceWiseCutReport] (
  PieceID INT NOT NULL IDENTITY(1,1),
  BundleID INT NOT NULL,
  PieceNumber INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  StyleTemplateID INT DEFAULT NULL,
  CONSTRAINT PK_PieceWiseCutReport PRIMARY KEY (PieceID),
  CONSTRAINT UQ_BundleID_PieceNo UNIQUE (BundleID,PieceNumber),
  CONSTRAINT FK_PieceWiseCutReport_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID)
);


CREATE TABLE [Essentials].[Machine] (
  MachineID INT NOT NULL IDENTITY(1,1),
  MachineCode VARCHAR(64) NOT NULL,
  MachineDescription VARCHAR(64) NOT NULL,
  MachineImageUrl VARCHAR(2056) DEFAULT NULL,
  MachineThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  MachineTypeID INT NOT NULL,
  ActiveWorkerID INT DEFAULT NULL,
  LineID INT DEFAULT NULL,
  -- Operations json DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  BoxID INT DEFAULT NULL,
  IsMachineDown BIT DEFAULT NULL,
  CONSTRAINT PK_Machine PRIMARY KEY (MachineID),
  CONSTRAINT UQ_MachineCode UNIQUE (MachineCode),
  CONSTRAINT UQ_ActiveWorker UNIQUE (ActiveWorkerID),
  -- CONSTRAINT UQ_Machine_Box UNIQUE (BoxID),
  CONSTRAINT FK_Machine_ActiveWorker FOREIGN KEY (ActiveWorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
  CONSTRAINT FK_Machine_Box FOREIGN KEY (BoxID) REFERENCES [Essentials].[Box] (BoxID),
  CONSTRAINT FK_Machine_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_Machine_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType] (MachineTypeID)
);

CREATE TABLE [Essentials].[MachineDownTime] (
  MachineDownTimeID INT NOT NULL IDENTITY(1,1),
  MachineID INT NOT NULL,
  DownReason VARCHAR(MAX) DEFAULT NULL,
  StartTime DATETIME NOT NULL DEFAULT GETDATE(),
  EndTime DATETIME DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_MachineDownTime PRIMARY KEY (MachineDownTimeID),
  CONSTRAINT FK_MachineDownTime_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID)
);


CREATE TABLE [Data].[WorkerScan] (
  WorkerScanID INT NOT NULL IDENTITY(1,1),
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  -- WorkerOperations json NOT NULL,
  Extras VARCHAR(64) DEFAULT NULL,
  HasExpire BIT DEFAULT 0,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  EndedAt DATETIME DEFAULT NULL,
  CONSTRAINT PK_WorkerScan PRIMARY KEY (WorkerScanID),
  CONSTRAINT FK_WorkerScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_WorkerScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_WorkerScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
);

CREATE TABLE [Essentials].[LineLayout] (
  LineLayoutID INT NOT NULL IDENTITY(1,1),
  RevisionNo INT NOT NULL,
  LineID INT NOT NULL,
  ProductionOrderID INT NOT NULL,
  LineLayoutDate date NOT NULL,
  LineLayoutStatus VARCHAR(8) NOT NULL,
  IsAnyMachines BIT NOT NULL,
  ParentLineLayoutID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  LineLayoutName VARCHAR(256) NOT NULL,
  CONSTRAINT PK_LineLayout PRIMARY KEY (LineLayoutID),
  CONSTRAINT FK_LineLayout_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_LineLayout_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID),
  CONSTRAINT FK_Parent_LineLayoutID FOREIGN KEY (ParentLineLayoutID) REFERENCES [Essentials].[LineLayout] (LineLayoutID)
);


CREATE TABLE [Essentials].[Tag] (
  TagID INT NOT NULL,
  BundleID INT DEFAULT NULL,
  StyleTemplateID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  PieceID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  CONSTRAINT PK_Tag PRIMARY KEY (TagID),
  CONSTRAINT FK_Tag_Bundle FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_Tag_Group FOREIGN KEY (GroupID) REFERENCES [Essentials].[ScanGroup] (GroupID),
  CONSTRAINT FK_Tag_Piece FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_Tag_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID)
);



CREATE TABLE [Essentials].[PieceWiseGroup] (
  PieceWiseGroupID INT NOT NULL IDENTITY(1,1),
  GroupID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_PieceWiseGroup PRIMARY KEY (PieceWiseGroupID),
  CONSTRAINT FK_CutReport_PieceWiseGroup FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_PieceWiseGroup FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_PieceWiseGroup_Group FOREIGN KEY (GroupID) REFERENCES [Essentials].[ScanGroup] (GroupID)
);


CREATE TABLE [Essentials].[Fault] (
  FaultID INT NOT NULL IDENTITY(1,1),
  FaultCode VARCHAR(64) NOT NULL,
  FaultDescription VARCHAR(256) NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Fault PRIMARY KEY (FaultID),
  CONSTRAINT UQ_Section_FaultCode UNIQUE (SectionID,FaultCode),
  CONSTRAINT FK_Fault_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID)
);

CREATE TABLE [Data].[Scan] (
  ScanID INT NOT NULL IDENTITY(1,1),
  WorkerScanID INT NOT NULL,
  BundleID INT DEFAULT NULL,
  PieceID INT DEFAULT NULL,
  OperationID INT NOT NULL,
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  ShortAddress VARCHAR(64) DEFAULT NULL,
  LongAddress VARCHAR(64) DEFAULT NULL,
  HostIP VARCHAR(64) DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_Scan PRIMARY KEY (ScanID),
  CONSTRAINT UQ_Scan_BundleID_PieceID_OperationID UNIQUE (BundleID,PieceID,OperationID),
  CONSTRAINT FK_Scan__PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_Scan_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_Scan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_Scan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_Scan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_Scan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
  CONSTRAINT FK_Scan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan] (WorkerScanID)
);

CREATE TABLE [Data].[PieceWiseScan] (
  PieceWiseScanningID INT NOT NULL IDENTITY(1,1),
  ScanID INT DEFAULT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  OperationID INT NOT NULL,
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  PieceWiseGroupID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  CONSTRAINT PK_PieceWiseScan PRIMARY KEY (PieceWiseScanningID),
  CONSTRAINT UQ_PieceWiseScan_BundleID_PieceID_OperationID UNIQUE (BundleID,PieceID,OperationID),
  CONSTRAINT FK_PieceWiseScan_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_PieceWiseScan_ScanGroup FOREIGN KEY (GroupID) REFERENCES [Essentials].[ScanGroup] (GroupID),
  CONSTRAINT FK_PieceWiseScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_PieceWiseScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_PieceWiseScan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseGroup FOREIGN KEY (PieceWiseGroupID) REFERENCES [Essentials].[PieceWiseGroup] (PieceWiseGroupID),
  CONSTRAINT FK_PieceWiseScan_Scan FOREIGN KEY (ScanID) REFERENCES [Data].[Scan] (ScanID),
  CONSTRAINT FK_PieceWiseScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
);

CREATE TABLE [Essentials].[User] (
  UserID INT NOT NULL IDENTITY(1,1),
  UserName VARCHAR(64) NOT NULL,
  Password VARCHAR(1024) NOT NULL,
  UserType VARCHAR(64) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_User PRIMARY KEY (UserID),
  CONSTRAINT UQ_UserName UNIQUE (UserName),
  CONSTRAINT FK_User_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_User_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID)
);

CREATE TABLE [Essentials].[Userpermission] (
  UserPermissionID INT NOT NULL IDENTITY(1,1),
  UserID INT NOT NULL,
  ModuleID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_UserPermission PRIMARY KEY (UserPermissionID),
  CONSTRAINT UQ_UserPermission UNIQUE (UserID,ModuleID),
  CONSTRAINT FK_UserPermission_Module FOREIGN KEY (ModuleID) REFERENCES [Essentials].[Module] (ModuleID),
  CONSTRAINT FK_UserPermission_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID)
);

CREATE TABLE [Data].[AuditFormSession] (
  AuditFormSessionID INT NOT NULL IDENTITY(1,1),
  WorkerID INT NOT NULL,
  OperationID INT NOT NULL,
  UserID INT NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  MachineID INT NOT NULL,
  MachineRound INT NOT NULL,
  FollowUp INT NOT NULL DEFAULT 0,
  DefectedPieces INT NOT NULL,
  RoundColor VARCHAR(6) NOT NULL,
  CreatedAtDate DATE NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_InlineSession PRIMARY KEY (AuditFormSessionID),
  CONSTRAINT UQ_MachineID_MachineRound_CreatedAtDate_FollowUp UNIQUE (MachineID,CreatedAtDate,MachineRound,FollowUp),
  CONSTRAINT FK_InlineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_InlineSession_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_InlineSession_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_InlineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT FK_InlineSession_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID),
  CONSTRAINT FK_InlineSession_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
);

CREATE TABLE [Data].[AuditFormFaultLog] (
  AuditFormFaultLogID INT NOT NULL IDENTITY(1,1),
  AuditFormSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_AuditFormFaultLog PRIMARY KEY (AuditFormFaultLogID),
  CONSTRAINT FK_AuditFormFaultLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES [Data].[AuditFormSession] (AuditFormSessionID),
  CONSTRAINT FK_AuditFormFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault] (FaultID)
);


CREATE TABLE [Data].[EndLineSession] (
  EndLineSessionID INT NOT NULL IDENTITY(1,1),
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  UserID INT NOT NULL,
  Status TINYINT NOT NULL DEFAULT 0,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_EndLineSession PRIMARY KEY (EndLineSessionID),
  CONSTRAINT FK_EndLineSession_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_EndLineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_EndLineSession_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_EndLineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT FK_EndLineSession_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID),
  CONSTRAINT CK_EndLineSession_Status CHECK ((Status in (0,1,2,3,4,5,6,7,8)))
);

CREATE TABLE [Data].[EndLineFaultLog] (
  EndLineFaultLogID INT NOT NULL IDENTITY(1,1),
  EndLineSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  PieceWiseScanningID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_EndLineFaultLog PRIMARY KEY (EndLineFaultLogID),
  CONSTRAINT FK_EndLineFaultLog_EndLineSession FOREIGN KEY (EndLineSessionID) REFERENCES [Data].[EndLineSession] (EndLineSessionID),
  CONSTRAINT FK_EndLineFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault] (FaultID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseScan FOREIGN KEY (PieceWiseScanningID) REFERENCES [Data].[PieceWiseScan] (PieceWiseScanningID)
);


CREATE TABLE [Data].[CheckListResponseLog] (
  CheckListResponseLogID INT NOT NULL IDENTITY(1,1),
  AuditFormSessionID INT NOT NULL,
  CheckListDescription VARCHAR(64) NOT NULL,
  Response VARCHAR(6) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CheckListResponseLog PRIMARY KEY (CheckListResponseLogID),
  CONSTRAINT FK_CheckListResponseLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES [Data].[AuditFormSession] (AuditFormSessionID)
);



CREATE TABLE  [Essentials].[AllocatedMachines]( 
    AllocatedMachinesID INT NOT NULL IDENTITY(1,1),
    WorkerID INT NOT NULL,
    MachineID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AllocatedMachinesID PRIMARY KEY (AllocatedMachinesID),
    CONSTRAINT FK_AllocatedMachines_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_AllocatedMachines_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID)
);

CREATE TABLE  [Essentials].[MachineOperations](
    MachineOperationsID INT NOT NULL IDENTITY(1,1),
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MachineOperationsID PRIMARY KEY (MachineOperationsID),
    CONSTRAINT FK_MachineOperations_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID),
    CONSTRAINT FK_MachineOperations_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID)    
);


CREATE TABLE [Data].[WorkerOperations](
    WorkerOperationsID INT NOT NULL IDENTITY(1,1),
    WorkerScanID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_WorkerOperationsID PRIMARY KEY (WorkerOperationsID),
    CONSTRAINT FK_WorkerOperations_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID),
    CONSTRAINT FK_WorkerOperations_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan] (WorkerScanID)   
);


CREATE TABLE [Essentials].[MarkerMapping](
    MarkerMappingID INT NOT NULL IDENTITY(1,1),
    MarkerID INT NOT NULL,
    Size INT NOT NULL,
    Ratio INT NOT NULL,
    Inseam  INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MarkerMappingID PRIMARY KEY (MarkerMappingID),
    CONSTRAINT FK_MarkerMappingID_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker](MarkerID)

);


CREATE TABLE [Essentials].[LineLayoutOperationMachines](
    LineLayoutOperationMachinesID INT NOT NULL IDENTITY(1,1),
    LineLayoutID INT NOT NULL,
    MachineID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LineLayoutOperationMachines PRIMARY KEY(LineLayoutOperationMachinesID),
    CONSTRAINT FK_LineLayoutOperationMachines_LineLayout FOREIGN KEY(LineLayoutID) REFERENCES [Essentials].[LineLayout](LineLayoutID),
    CONSTRAINT FK_LineLayoutOperationMachines_Machine FOREIGN KEY(MachineID) REFERENCES [Essentials].[Machine](MachineID)
);


