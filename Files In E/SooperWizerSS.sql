USE [MASTER];
GO
CREATE DATABASE  [SooperWizerReplica];
GO
USE [SooperWizerReplica];
GO
CREATE SCHEMA [Essentials];
GO
CREATE SCHEMA [Data];
GO


CREATE TABLE  [Essentials].[StyleTemplate] (
  StyleTemplateID INT NOT NULL IDENTITY(1,1),
  StyleTemplateCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_StyleTemplateID PRIMARY KEY (StyleTemplateID),
  CONSTRAINT UQ_StyleTemplateCode  UNIQUE (StyleTemplateCode)
); 

CREATE TABLE  [Essentials].[Section] (
  SectionID INT NOT NULL IDENTITY(1,1),
  SectionCode VARCHAR(64) NOT NULL,
  SectionDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_SectionID PRIMARY KEY (SectionID),
  CONSTRAINT UQ_SectionCode UNIQUE (SectionCode)
); 

CREATE TABLE  [Essentials].[ScanGroup] (
  GroupID INT NOT NULL IDENTITY(1,1),
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_GroupID PRIMARY KEY (GroupID)
);

CREATE TABLE  [Essentials].[Line] (
  LineID INT NOT NULL IDENTITY(1,1),
  LineCode VARCHAR(64) NOT NULL,
  LineDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_LineID PRIMARY KEY (LineID),
  CONSTRAINT UQ_LineCode UNIQUE (LineCode)
);

CREATE TABLE  [Essentials].[Worker] (
  WorkerID INT NOT NULL IDENTITY(1,1),
  WorkerCode VARCHAR(64) NOT NULL,
  WorkerDescription VARCHAR(64) NOT NULL,
  WorkerImageUrl VARCHAR(MAX) DEFAULT NULL,
  WorkerThumbnailUrl VARCHAR(MAX) DEFAULT NULL,
  AllocatedMachines JSON DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_WorkerID PRIMARY KEY (WorkerID),
  CONSTRAINT UQ_WorkerCode  UNIQUE (WorkerCode),
  CONSTRAINT CK_Worker_AllocatedMachines CHECK (ISJSON(AllocatedMachines)>0)
);

CREATE TABLE  [Essentials].[Module] (
  ModuleID INT NOT NULL IDENTITY(1,1),
  ModuleCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_ModuleID PRIMARY KEY (ModuleID),
  CONSTRAINT UQ_ModuleCode UNIQUE (ModuleCode)
);

CREATE TABLE  [Essentials].[Box] (
  BoxID INT NOT NULL IDENTITY(1,1),
  BoxCode VARCHAR(64) NOT NULL,
  IssueDate DATETIME NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_BoxID PRIMARY KEY (BoxID),
  CONSTRAINT UQ_BoxCode  UNIQUE (BoxCode)
);

CREATE TABLE  [Essentials].[MachineType] (
  MachineTypeID INT NOT NULL IDENTITY(1,1),
  MachineTypeCode VARCHAR(64) NOT NULL,
  MachineTypeDescription VARCHAR(64) NOT NULL,
  Allowance FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_MachineTypeID PRIMARY KEY (MachineTypeID),
  CONSTRAINT UQ_MachineTypeCode UNIQUE (MachineTypeCode)
);

CREATE TABLE  [Essentials].[SaleOrder] (
  SaleOrderID INT NOT NULL IDENTITY(1,1),
  SaleOrderCode VARCHAR(100) NOT NULL,
  Customer VARCHAR(64) NOT NULL,
  OrderQuantity INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_SaleOrderID PRIMARY KEY (SaleOrderID),
  CONSTRAINT UQ_SaleOrderCode  UNIQUE (SaleOrderCode)
);


CREATE TABLE  [Essentials].[Operation] (
  OperationID INT NOT NULL IDENTITY(1,1),
  OperationCode VARCHAR(64) NOT NULL,
  OperationName VARCHAR(64) NOT NULL,
  OperationDescription VARCHAR(64) NOT NULL,
  Department VARCHAR(64) NOT NULL,
  PieceRate FLOAT DEFAULT NULL,
  OperationType VARCHAR(64) NOT NULL,
  OperationImageUrl VARCHAR(MAX) DEFAULT NULL,
  OperationThumbnailUrl VARCHAR(MAX) DEFAULT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_OperationID PRIMARY KEY (OperationID),
  CONSTRAINT UQ_OperationCode UNIQUE (OperationCode),
  CONSTRAINT FK_Operation_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID)
);

CREATE TABLE  [Essentials].[TargetFeeding] (
  TargetFeedingID INT NOT NULL IDENTITY(1,1),
  TargetDate DATE NOT NULL,
  TargetShift VARCHAR(10) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  PlanEfficiency FLOAT NOT NULL,
  PlanProduction FLOAT NOT NULL,
  CreatedAt DATETIME NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NULL DEFAULT GETDATE(),
  CONSTRAINT PK_TargetFeedingID PRIMARY KEY (TargetFeedingID),
  CONSTRAINT CK_TargetFeeding_TargetShift CHECK (TargetShift IN('Morning','Evening','Night')),
  CONSTRAINT FK_TargetFeeding_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_TargetFeeding_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID)
);

CREATE TABLE  [Essentials].[ProductionOrder] (
  ProductionOrderID INT NOT NULL IDENTITY(1,1),
  ProductionOrderCode VARCHAR(100) NOT NULL,
  SaleOrderID INT NOT NULL,
  StyleTemplateID INT DEFAULT NULL,
  IsFollowOperationSequence BIT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_ProductionOrderID PRIMARY KEY (ProductionOrderID),
  CONSTRAINT UQ_ProductionOrderCode UNIQUE (ProductionOrderCode),
  CONSTRAINT FK_ProductionOrder_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES [Essentials].[SaleOrder] (SaleOrderID),
  CONSTRAINT FK_ProductionOrder_StyleTempate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID)
);

CREATE TABLE  [Essentials].[Marker] (
  MarkerID INT NOT NULL IDENTITY(1,1),
  MarkerCode VARCHAR(64) NOT NULL,
  ProductionOrderID INT NOT NULL,
  MarkerMapping JSON NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_MarkerID PRIMARY KEY (MarkerID),
  CONSTRAINT UQ_MarkerCodePOID  UNIQUE (MarkerCode,ProductionOrderID),
  CONSTRAINT FK_Marker_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID),
  CONSTRAINT CK_MarkerMapping CHECK (ISJSON(MarkerMapping)>0)
);


CREATE TABLE  [Essentials].[StyleBulletin] (
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
  CONSTRAINT PK_StyleBulletinID PRIMARY KEY (StyleBulletinID),
  CONSTRAINT UQ_StyleBulletin_StyleTemplateID_OperationID  UNIQUE (StyleTemplateID,OperationID),
  CONSTRAINT FK_StyleBulletin_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType] (MachineTypeID),
  CONSTRAINT FK_StyleBulletin_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_StyleBulletin_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID)
);


CREATE TABLE  [Essentials].[CutJob] (
  CutJobID INT NOT NULL IDENTITY(1,1),
  CutNo VARCHAR(32) NOT NULL,
  ProductionOrderID INT NOT NULL,
  CutQuantity INT NOT NULL,
  MarkerID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CutJobID PRIMARY KEY (CutJobID),
  CONSTRAINT UQ_ProductionOrder_CutNo  UNIQUE (ProductionOrderID,CutNo),
  CONSTRAINT FK_CutJob_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker] (MarkerID),
  CONSTRAINT FK_CutJob_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID)
);

CREATE TABLE  [Essentials].[CutReport] (
  BundleID INT NOT NULL IDENTITY(1,1),
  BundleCode VARCHAR(64) NOT NULL,
  BundleQuantity INT NOT NULL,
  ScannedQuantity INT NOT NULL DEFAULT 0,
  RemainingQuantity INT NOT NULL,
  CutJobID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_BundleID PRIMARY KEY (BundleID),
  CONSTRAINT UQ_CutJobID_BundleCode UNIQUE (CutJobID,BundleCode),
  CONSTRAINT FK_CutReport_CutJob FOREIGN KEY (CutJobID) REFERENCES [Essentials].[CutJob] (CutJobID)
);

CREATE TABLE  [Essentials].[PieceWiseCutReport] (
  PieceID INT NOT NULL IDENTITY(1,1),
  BundleID INT NOT NULL,
  PieceNumber INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_PieceID PRIMARY KEY (PieceID),
  CONSTRAINT UQ_BundleID_PieceNo  UNIQUE (BundleID,PieceNumber),
  CONSTRAINT FK_PieceWiseCutReport_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID)
);

CREATE TABLE  [Essentials].[Machine] (
  MachineID INT NOT NULL IDENTITY(1,1),
  MachineCode VARCHAR(64) NOT NULL,
  MachineDescription VARCHAR(64) NOT NULL,
  MachineImageUrl VARCHAR(MAX) DEFAULT NULL,
  MachineThumbnailUrl VARCHAR(MAX) DEFAULT NULL,
  MachineTypeID INT NOT NULL,
  ActiveWorkerID INT DEFAULT NULL,
  LineID INT DEFAULT NULL,
  Operations JSON DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  BoxID INT DEFAULT NULL,
  IsMachineDown BIT DEFAULT NULL,
  CONSTRAINT PK_MachineID PRIMARY KEY (MachineID),
  CONSTRAINT UQ_MachineCode UNIQUE (MachineCode),
  CONSTRAINT UQ_ActiveWorker UNIQUE (ActiveWorkerID),
  CONSTRAINT FK_Machine_ActiveWorker FOREIGN KEY (ActiveWorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
  CONSTRAINT FK_Machine_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_Machine_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType] (MachineTypeID),
  CONSTRAINT CK_Operations CHECK (ISJSON(Operations)>0)
);

CREATE TABLE  [Essentials].[MachineDownTime] (
  MachineDownTimeID INT NOT NULL IDENTITY(1,1),
  MachineID INT NOT NULL,
  DownReason VARCHAR(MAX) DEFAULT NULL, -- VARCHAR(9999)
  StartTime DATETIME NOT NULL DEFAULT GETDATE(),
  EndTime   DATETIME DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_MachineDownTimeID PRIMARY KEY (MachineDownTimeID),
  CONSTRAINT FK_MachineDownTime FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID)
);

CREATE TABLE  [Data].[WorkerScan] (
  WorkerScanID bigINT NOT NULL IDENTITY(1,1),
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  WorkerOperations JSON NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  HasExpired BIT NOT NULL DEFAULT 0,
  EndedAt DATETIME NULL DEFAULT NULL,
  CONSTRAINT PK_WorkerScanID PRIMARY KEY (WorkerScanID),
  CONSTRAINT FK_WorkerScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_WorkerScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_WorkerScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
  CONSTRAINT CK_WorkerOperations CHECK (ISJSON(WorkerOperations)>0)
);

CREATE TABLE  [Essentials].[LineLayout] (
  LineLayoutID INT NOT NULL IDENTITY(1,1),
  RevisionNo INT NOT NULL,
  LineID INT NOT NULL,
  ProductionOrderID INT NOT NULL,
  LineLayoutDate date NOT NULL,
  LineLayoutStatus VARCHAR(8) NOT NULL,
  LineLayoutOperationMachines JSON NOT NULL,
  IsAnyMachines BIT NOT NULL,
  ParentLineLayoutID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  LineLayoutName VARCHAR(256) NOT NULL,
  CONSTRAINT PK_LineLayoutID PRIMARY KEY (LineLayoutID),
  CONSTRAINT FK_LineLayout_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_LineLayout_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID),
  CONSTRAINT FK_Parent_LineLayoutID FOREIGN KEY (ParentLineLayoutID) REFERENCES [Essentials].[LineLayout] (LineLayoutID),
  CONSTRAINT CK_LineLayout_LineLayoutOperationMachines CHECK (ISJSON(LineLayoutOperationMachines)>0)
);


CREATE TABLE  [Essentials].[Tag] (
  TagID INT NOT NULL IDENTITY(1,1),
  BundleID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  PieceID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  CONSTRAINT PK_TagID PRIMARY KEY (TagID),
  CONSTRAINT FK_Tag_Bundle FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_Tag_Group FOREIGN KEY (GroupID) REFERENCES [Essentials].[ScanGroup] (GroupID),
  CONSTRAINT FK_Tag_Piece FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID)
);


CREATE TABLE  [Essentials].[PieceWiseGroup] (
  PieceWiseGroupID INT NOT NULL IDENTITY(1,1),
  GroupID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  GroupName VARCHAR(20) DEFAULT NULL,
  CONSTRAINT PK_PieceWiseGroupID PRIMARY KEY (PieceWiseGroupID),
  CONSTRAINT FK_CutReport_PieceWiseGroup FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_PieceWiseGroup FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_PieceWiseGroup_Group FOREIGN KEY (GroupID) REFERENCES [Essentials].[ScanGroup] (GroupID)
);

CREATE TABLE  [Essentials].[Fault] (
  FaultID INT NOT NULL IDENTITY(1,1),
  FaultCode VARCHAR(64) NOT NULL,
  FaultDescription VARCHAR(256) NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_FaultID PRIMARY KEY (FaultID),
  CONSTRAINT UQ_Section_FaultCode  UNIQUE (SectionID,FaultCode),
  CONSTRAINT FK_Fault_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID)
);


CREATE TABLE  [Data].[Scan] (
  ScanID bigINT NOT NULL IDENTITY(1,1),
  WorkerScanID bigINT NOT NULL,
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


CREATE TABLE  [Data].[PieceWiseScan] (
  PieceWiseScanningID INT NOT NULL IDENTITY(1,1),
  ScanID bigINT NOT NULL,
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
  CONSTRAINT PK_PieceWiseScanningID PRIMARY KEY (PieceWiseScanningID),
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

CREATE TABLE  [Essentials].[User] (
  UserID INT NOT NULL IDENTITY(1,1),
  UserName VARCHAR(64) NOT NULL,
  Password VARCHAR(1024) NOT NULL,
  UserType VARCHAR(64) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_UserID PRIMARY KEY (UserID),
  CONSTRAINT UQ_UserName UNIQUE (UserName),
  CONSTRAINT FK_User_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_User_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID)
);


CREATE TABLE  [UserPermission] (
  UserPermissionID INT NOT NULL IDENTITY(1,1),
  UserID INT NOT NULL,
  ModuleID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_UserPermissionID PRIMARY KEY (UserPermissionID),
  CONSTRAINT UQ_UserPermission  UNIQUE (UserID,ModuleID),
  CONSTRAINT FK_UserPermission_Module FOREIGN KEY (ModuleID) REFERENCES [Essentials].[Module] (ModuleID),
  CONSTRAINT FK_UserPermission_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID)
);


CREATE TABLE  [Data].[AuditFormSession] (
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
  CONSTRAINT PK_AuditFormSessionID PRIMARY KEY (AuditFormSessionID),
  CONSTRAINT UQ_MachineID_MachineRound_CreatedAtDate_FollowUp UNIQUE (MachineID,CreatedAtDate,MachineRound,FollowUp),
  CONSTRAINT FK_InlineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_InlineSession_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID),
  CONSTRAINT FK_InlineSession_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
  CONSTRAINT FK_InlineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT FK_InlineSession_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID),
  CONSTRAINT FK_InlineSession_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
);

CREATE TABLE  [Data].[EndLineSession] (
  EndLineSessionID INT NOT NULL IDENTITY(1,1),
  DefectedPieces INT NOT NULL,
  RejectedPieces INT NOT NULL,
  CheckedPieces INT NOT NULL,
  IsPieceScan BIT NOT NULL,
  LineID INT NOT NULL,
  BundleID INT NOT NULL,
  ReworkState INT NOT NULL,
  SectionID INT NOT NULL,
  UserID INT NOT NULL,
  CreatedAtDate DATE NOT NULL DEFAULT (CAST(GETDATE() AS DATE)),
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_EndLineSessionID PRIMARY KEY (EndLineSessionID),
  CONSTRAINT UQ_BundleID_ReworkState_SectionID  UNIQUE (BundleID,ReworkState,SectionID),
  CONSTRAINT FK_EndLineSession_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport] (BundleID),
  CONSTRAINT FK_EndLineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
  CONSTRAINT FK_EndLineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
  CONSTRAINT FK_EndLineSession_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID)
);

CREATE TABLE  [Data].[EndLineFaultLog] (
  EndLineFaultLogID INT NOT NULL IDENTITY(1,1),
  FaultCount INT NOT NULL,
  EndLineSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultDescription VARCHAR(256) DEFAULT NULL,
  PieceID INT DEFAULT NULL,
  IsQualityChecked BIT NOT NULL DEFAULT 0,
  IsPieceQualityChecked BIT NOT NULL DEFAULT 0,
  PieceWiseScanID INT DEFAULT NULL,
  IsRework BIT DEFAULT NULL,
  IsRejected BIT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_EndLineFaultLogID PRIMARY KEY (EndLineFaultLogID),
  CONSTRAINT FK_EndLineFaultLog_EndLineSession FOREIGN KEY (EndLineSessionID) REFERENCES [Data].[EndLineSession] (EndLineSessionID),
  CONSTRAINT FK_EndLineFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault] (FaultID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseScan FOREIGN KEY (PieceWiseScanID) REFERENCES [Data].[PieceWiseScan] (PieceWiseScanningID)
);


CREATE TABLE  [Data].[AuditFormFaultLog] (
  AuditFormFaultLogID INT NOT NULL IDENTITY(1,1),
  AuditFormSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_AuditFormFaultLogID PRIMARY KEY (AuditFormFaultLogID),
  CONSTRAINT FK_AuditFormFaultLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES [Data].[AuditFormSession] (AuditFormSessionID),
  CONSTRAINT FK_AuditFormFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault] (FaultID)
);


CREATE TABLE  [Data].[CheckListResponseLog] (
  CheckListResponseLogID INT NOT NULL IDENTITY(1,1),
  AuditFormSessionID INT NOT NULL,
  CheckListDescription VARCHAR(64) NOT NULL,
  Response VARCHAR(6) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
  CONSTRAINT PK_CheckListResponseLogID PRIMARY KEY (CheckListResponseLogID),
  CONSTRAINT FK_CheckListResponseLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES [Data].[AuditFormSession] (AuditFormSessionID)
);
