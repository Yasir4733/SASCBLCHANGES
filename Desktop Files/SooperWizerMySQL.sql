CREATE DATABASE IF NOT EXISTS SooperWizeMySQL;
USE SooperWizeMySQL;
-- ================================================
-- =================================================

CREATE TABLE IF NOT EXISTS style_template (
  StyleTemplateID INT NOT NULL AUTO_INCREMENT,
  StyleTemplateCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (StyleTemplateID),
  UNIQUE KEY UQ_StyleTemplateCode (StyleTemplateCode)
); 

CREATE TABLE IF NOT EXISTS section (
  SectionID INT NOT NULL AUTO_INCREMENT,
  SectionCode VARCHAR(64) NOT NULL,
  SectionDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (SectionID),
  UNIQUE KEY UQ_SectionCode (SectionCode)
); 

CREATE TABLE IF NOT EXISTS scan_group (
  GroupID INT NOT NULL AUTO_INCREMENT,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (GroupID)
);

CREATE TABLE IF NOT EXISTS line (
  LineID INT NOT NULL AUTO_INCREMENT,
  LineCode VARCHAR(64) NOT NULL,
  LineDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (LineID),
  UNIQUE KEY UQ_LineCode (LineCode)
);

CREATE TABLE IF NOT EXISTS worker (
  WorkerID INT NOT NULL AUTO_INCREMENT,
  WorkerCode VARCHAR(64) NOT NULL,
  WorkerDescription VARCHAR(64) NOT NULL,
  WorkerImageUrl VARCHAR(2056) DEFAULT NULL,
  WorkerThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  AllocatedMachines json DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (WorkerID),
  UNIQUE KEY UQ_WorkerCode (WorkerCode),
  CONSTRAINT worker_chk_1 CHECK (json_valid(AllocatedMachines))
);

CREATE TABLE IF NOT EXISTS module (
  ModuleID INT NOT NULL AUTO_INCREMENT,
  ModuleCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ModuleID),
  UNIQUE KEY UQ_ModuleCode (ModuleCode)
);

CREATE TABLE IF NOT EXISTS box (
  BoxID INT NOT NULL AUTO_INCREMENT,
  BoxCode VARCHAR(64) NOT NULL,
  IssueDate DATETIME NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (BoxID),
  UNIQUE KEY UQ_BoxCode (BoxCode)
);

CREATE TABLE IF NOT EXISTS machine_type (
  MachineTypeID INT NOT NULL AUTO_INCREMENT,
  MachineTypeCode VARCHAR(64) NOT NULL,
  MachineTypeDescription VARCHAR(64) NOT NULL,
  Allowance FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MachineTypeID),
  UNIQUE KEY UQ_MachineTypeCode (MachineTypeCode)
);

CREATE TABLE IF NOT EXISTS sale_order (
  SaleOrderID INT NOT NULL AUTO_INCREMENT,
  SaleOrderCode VARCHAR(100) NOT NULL,
  Customer VARCHAR(64) NOT NULL,
  OrderQuantity INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (SaleOrderID),
  UNIQUE KEY UQ_SaleOrderCode (SaleOrderCode)
);

-- =================================================================
-- =================================================================
CREATE TABLE IF NOT EXISTS operation (
  OperationID INT NOT NULL AUTO_INCREMENT,
  OperationCode VARCHAR(64) NOT NULL,
  OperationName VARCHAR(64) NOT NULL,
  OperationDescription VARCHAR(64) NOT NULL,
  Department VARCHAR(64) NOT NULL,
  PieceRate FLOAT DEFAULT NULL,
  OperationType VARCHAR(64) NOT NULL,
  OperationImageUrl VARCHAR(2056) DEFAULT NULL,
  OperationThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (OperationID),
  UNIQUE KEY UQ_OperationCode (OperationCode),
  KEY FK_Operation_Section (SectionID),
  CONSTRAINT FK_Operation_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

CREATE TABLE IF NOT EXISTS target_feeding (
  TargetFeedingID INT NOT NULL AUTO_INCREMENT,
  TargetDate DATE NOT NULL,
  TargetShift ENUM('Morning','Evening','Night') NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  PlanEfficiency FLOAT NOT NULL,
  PlanProduction FLOAT NOT NULL,
  CreatedAt DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (TargetFeedingID),
  KEY LineID (LineID),
  KEY SectionID (SectionID),
  CONSTRAINT FK_Target_Feeding_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_Target_Feeding_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

CREATE TABLE IF NOT EXISTS production_order (
  ProductionOrderID INT NOT NULL AUTO_INCREMENT,
  ProductionOrderCode VARCHAR(100) NOT NULL,
  SaleOrderID INT NOT NULL,
  StyleTemplateID INT DEFAULT NULL,
  IsFollowOperationSequence bit(1) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ProductionOrderID),
  UNIQUE KEY UQ_ProductionOrderCode (ProductionOrderCode),
  KEY FK_ProductionOrder_SaleOrder (SaleOrderID),
  KEY FK_ProductionOrder_StyleTempate (StyleTemplateID),
  CONSTRAINT FK_ProductionOrder_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES sale_order (SaleOrderID),
  CONSTRAINT FK_ProductionOrder_StyleTempate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID)
);

CREATE TABLE IF NOT EXISTS marker (
  MarkerID INT NOT NULL AUTO_INCREMENT,
  MarkerCode VARCHAR(64) NOT NULL,
  ProductionOrderID INT NOT NULL,
  MarkerMapping json NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MarkerID),
  UNIQUE KEY UQ_MarkerCodePoID (MarkerCode,ProductionOrderID),
  KEY FK_Marker_ProductionOrder (ProductionOrderID),
  CONSTRAINT FK_Marker_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID),
  CONSTRAINT marker_chk_1 CHECK (json_valid(MarkerMapping))
);

CREATE TABLE IF NOT EXISTS style_bulletin (
  StyleBulletinID INT NOT NULL AUTO_INCREMENT,
  StyleTemplateID INT NOT NULL,
  OperationID INT NOT NULL,
  OperationSequence INT NOT NULL,
  ScanType VARCHAR(10) NOT NULL,
  IsFirst bit(1) NOT NULL DEFAULT b'0',
  IsLast bit(1) NOT NULL DEFAULT b'0',
  MachineTypeID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (StyleBulletinID),
  UNIQUE KEY UQ_StyleBulletin_StyleTemplateID_OperationID (StyleTemplateID,OperationID),
  KEY FK_StyleBulletin_Operation (OperationID),
  KEY FK_StyleBulletin_MachineType (MachineTypeID),
  CONSTRAINT FK_StyleBulletin_MachineType FOREIGN KEY (MachineTypeID) REFERENCES machine_type (MachineTypeID),
  CONSTRAINT FK_StyleBulletin_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_StyleBulletin_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID)
);

CREATE TABLE IF NOT EXISTS cut_job (
  CutJobID INT NOT NULL AUTO_INCREMENT,
  CutNo VARCHAR(32) NOT NULL,
  ProductionOrderID INT NOT NULL,
  CutQuantity INT NOT NULL,
  MarkerID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CutJobID),
  UNIQUE KEY UQ_ProductionOrder_CutNo (ProductionOrderID,CutNo),
  KEY FK_CutJob_Marker (MarkerID),
  CONSTRAINT FK_CutJob_Marker FOREIGN KEY (MarkerID) REFERENCES marker (MarkerID),
  CONSTRAINT FK_CutJob_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID)
);

CREATE TABLE IF NOT EXISTS cut_report (
  BundleID INT NOT NULL AUTO_INCREMENT,
  BundleCode VARCHAR(64) NOT NULL,
  BundleQuantity INT NOT NULL,
  ScannedQuantity INT NOT NULL DEFAULT '0',
  RemainingQuantity INT NOT NULL,
  CutJobID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (BundleID),
  KEY FK_CutReport_CutJob (CutJobID),
  KEY UQ_CutJobID_BundleCode (CutJobID,BundleCode),
  CONSTRAINT FK_CutReport_CutJob FOREIGN KEY (CutJobID) REFERENCES cut_job (CutJobID)
);

CREATE TABLE IF NOT EXISTS piece_wise_cut_report (
  PieceID INT NOT NULL AUTO_INCREMENT,
  BundleID INT NOT NULL,
  PieceNumber INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (PieceID),
  UNIQUE KEY UQ_BundleID_PieceNo (BundleID,PieceNumber),
  CONSTRAINT FK_PieceWiseCutReport_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID)
);

CREATE TABLE IF NOT EXISTS machine (
  MachineID INT NOT NULL AUTO_INCREMENT,
  MachineCode VARCHAR(64) NOT NULL,
  MachineDescription VARCHAR(64) NOT NULL,
  MachineImageUrl VARCHAR(2056) DEFAULT NULL,
  MachineThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  MachineTypeID INT NOT NULL,
  ActiveWorkerID INT DEFAULT NULL,
  LineID INT DEFAULT NULL,
  Operations json DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  BoxID INT DEFAULT NULL,
  IsMachineDown bit(1) DEFAULT NULL,
  PRIMARY KEY (MachineID),
  UNIQUE KEY UQ_MachineCode (MachineCode),
  UNIQUE KEY UQ_ActiveWorker (ActiveWorkerID),
  KEY FK_Machine_Line (LineID),
  KEY FK_Machine_MachineType (MachineTypeID),
  KEY FK_Machine_Box (BoxID),
  CONSTRAINT FK_Machine_ActiveWorker FOREIGN KEY (ActiveWorkerID) REFERENCES worker (WorkerID),
  CONSTRAINT FK_Machine_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_Machine_MachineType FOREIGN KEY (MachineTypeID) REFERENCES machine_type (MachineTypeID),
  CONSTRAINT machine_chk_1 CHECK (json_valid(Operations))
);

CREATE TABLE IF NOT EXISTS machine_down_time (
  MachineDownTimeID INT NOT NULL AUTO_INCREMENT,
  MachineID INT NOT NULL,
  DownReason VARCHAR(9999) DEFAULT NULL,
  StartTime datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  EndTime datetime DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (MachineDownTimeID),
  KEY FK_MachineDownTime (MachineID),
  CONSTRAINT FK_MachineDownTime FOREIGN KEY (MachineID) REFERENCES machine (MachineID)
);

CREATE TABLE IF NOT EXISTS worker_scan (
  WorkerScanID BIGINT NOT NULL AUTO_INCREMENT,
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  WorkerOperations longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  HasExpired bit(1) NOT NULL DEFAULT 0,
  EndedAt timestamp NULL DEFAULT NULL,
  PRIMARY KEY (WorkerScanID),
  KEY FK_WorkerScan_Line (LineID),
  KEY FK_WorkerScan_Worker (WorkerID),
  KEY FK_WorkerScan_Machine (MachineID),
  CONSTRAINT FK_WorkerScan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_WorkerScan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_WorkerScan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID),
  CONSTRAINT worker_scan_chk_1 CHECK (json_valid(WorkerOperations))
);

CREATE TABLE IF NOT EXISTS line_layout (
  LineLayoutID INT NOT NULL AUTO_INCREMENT,
  RevisionNo INT NOT NULL,
  LineID INT NOT NULL,
  ProductionOrderID INT NOT NULL,
  LineLayoutDate date NOT NULL,
  LineLayoutStatus VARCHAR(8) NOT NULL,
  LineLayoutOperationMachines json NOT NULL,
  IsAnyMachines bit(1) NOT NULL,
  ParentLineLayoutID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  LineLayoutName VARCHAR(256) NOT NULL,
  PRIMARY KEY (LineLayoutID),
  KEY FK_LineLayout_Line (LineID),
  KEY FK_LineLayout_ProductionOrder (ProductionOrderID),
  KEY FK_Parent_LineLayoutID (ParentLineLayoutID),
  CONSTRAINT FK_LineLayout_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_LineLayout_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID),
  CONSTRAINT FK_Parent_LineLayoutID FOREIGN KEY (ParentLineLayoutID) REFERENCES line_layout (LineLayoutID)
);

-- ===================================================================
-- ===================================================================

CREATE TABLE IF NOT EXISTS tag (
  TagID INT NOT NULL AUTO_INCREMENT,
  BundleID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PieceID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  PRIMARY KEY (TagID),
  KEY FK_Tag_Bundle (BundleID),
  KEY FK_Tag_Piece (PieceID),
  KEY FK_Tag_Group (GroupID),
  CONSTRAINT FK_Tag_Bundle FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_Tag_Group FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID),
  CONSTRAINT FK_Tag_Piece FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID)
);

CREATE TABLE IF NOT EXISTS piece_wise_group (
  PieceWiseGroupID INT NOT NULL AUTO_INCREMENT,
  GroupID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  GroupName VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (PieceWiseGroupID),
  KEY FK_PieceWiseGroup_Group (GroupID),
  KEY FK_CutReport_PieceWiseGroup (BundleID),
  KEY FK_PieceWiseCutReport_PieceWiseGroup (PieceID),
  CONSTRAINT FK_CutReport_PieceWiseGroup FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_PieceWiseGroup FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_PieceWiseGroup_Group FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID)
);

CREATE TABLE IF NOT EXISTS fault (
  FaultID INT NOT NULL AUTO_INCREMENT,
  FaultCode VARCHAR(64) NOT NULL,
  FaultDescription VARCHAR(256) NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (FaultID),
  UNIQUE KEY UQ_Section_FaultCode (SectionID,FaultCode),
  CONSTRAINT FK_Fault_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

-- ====================================================================
-- ====================================================================

CREATE TABLE IF NOT EXISTS scan (
  ScanID bigINT NOT NULL AUTO_INCREMENT,
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
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (ScanID),
  UNIQUE KEY UQ_Scan_BundleID_PieceID_OperationID (BundleID,PieceID,OperationID),
  KEY FK_Scan_WorkerScan (WorkerScanID),
  KEY FK_Scan__PieceWiseCutReport (PieceID),
  KEY FK_Scan_Operation (OperationID),
  KEY FK_Scan_Worker (WorkerID),
  KEY FK_Scan_Line (LineID),
  KEY FK_Scan_Machine (MachineID),
  CONSTRAINT FK_Scan__PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_Scan_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_Scan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_Scan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_Scan_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_Scan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID),
  CONSTRAINT FK_Scan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES worker_scan (WorkerScanID)
);

CREATE TABLE IF NOT EXISTS piece_wise_scan (
  PieceWiseScanningID INT NOT NULL AUTO_INCREMENT,
  ScanID bigINT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  OperationID INT NOT NULL,
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PieceWiseGroupID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  PRIMARY KEY (PieceWiseScanningID),
  UNIQUE KEY UQ_PieceWiseScan_BundleID_PieceID_OperationID (BundleID,PieceID,OperationID),
  KEY FK_PieceWiseScan_Scan (ScanID),
  KEY FK_PieceWiseScan_PieceWiseCutReport (PieceID),
  KEY FK_PieceWiseScan_Operation (OperationID),
  KEY FK_PieceWiseScan_Worker (WorkerID),
  KEY FK_PieceWiseScan_Line (LineID),
  KEY FK_PieceWiseScan_Machine (MachineID),
  KEY FK_PieceWiseScan_PieceWiseGroup (PieceWiseGroupID),
  KEY FK_PieceWiseScan_GroupScan (GroupID),
  CONSTRAINT FK_PieceWiseScan_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_PieceWiseScan_GroupScan FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID),
  CONSTRAINT FK_PieceWiseScan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_PieceWiseScan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_PieceWiseScan_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseGroup FOREIGN KEY (PieceWiseGroupID) REFERENCES piece_wise_group (PieceWiseGroupID),
  CONSTRAINT FK_PieceWiseScan_Scan FOREIGN KEY (ScanID) REFERENCES scan (ScanID),
  CONSTRAINT FK_PieceWiseScan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE IF NOT EXISTS user (
  UserID INT NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(64) NOT NULL,
  Password VARCHAR(1024) NOT NULL,
  UserType VARCHAR(64) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UserID),
  UNIQUE KEY UQ_UserName (UserName),
  KEY FK_User_Line (LineID),
  KEY FK_User_Section (SectionID),
  CONSTRAINT FK_User_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_User_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

CREATE TABLE IF NOT EXISTS userpermission (
  UserPermissionID INT NOT NULL AUTO_INCREMENT,
  UserID INT NOT NULL,
  ModuleID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (UserPermissionID),
  UNIQUE KEY UQ_UserPermission (UserID,ModuleID),
  KEY FK_UserPermission_Module (ModuleID),
  CONSTRAINT FK_UserPermission_Module FOREIGN KEY (ModuleID) REFERENCES module (ModuleID),
  CONSTRAINT FK_UserPermission_User FOREIGN KEY (UserID) REFERENCES user (UserID)
);

CREATE TABLE IF NOT EXISTS audit_form_session (
  AuditFormSessionID INT NOT NULL AUTO_INCREMENT,
  WorkerID INT NOT NULL,
  OperationID INT NOT NULL,
  UserID INT NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  MachineID INT NOT NULL,
  MachineRound INT NOT NULL,
  FollowUp INT NOT NULL DEFAULT '0',
  DefectedPieces INT NOT NULL,
  RoundColor VARCHAR(6) NOT NULL,
  CreatedAtDate date NOT NULL DEFAULT (cast(now() as date)),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (AuditFormSessionID),
  UNIQUE KEY UQ_MachineID_MachineRound_CreatedAtDate_FollowUp (MachineID,CreatedAtDate,MachineRound,FollowUp),
  KEY FK_InlineSession_User (UserID),
  KEY FK_InlineSession_Line (LineID),
  KEY FK_InlineSession_Section (SectionID),
  KEY FK_InlineSession_Operation (OperationID),
  KEY FK_InlineSession_Worker (WorkerID),
  CONSTRAINT FK_InlineSession_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_InlineSession_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_InlineSession_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_InlineSession_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT FK_InlineSession_User FOREIGN KEY (UserID) REFERENCES user (UserID),
  CONSTRAINT FK_InlineSession_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE IF NOT EXISTS end_line_session (
  EndLineSessionID INT NOT NULL AUTO_INCREMENT,
  DefectedPieces INT NOT NULL,
  RejectedPieces INT NOT NULL,
  CheckedPieces INT NOT NULL,
  IsPieceScan bit(1) NOT NULL,
  LineID INT NOT NULL,
  BundleID INT NOT NULL,
  ReworkState INT NOT NULL,
  SectionID INT NOT NULL,
  UserID INT NOT NULL,
  CreatedAtDate date NOT NULL DEFAULT (cast(now() as date)),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (EndLineSessionID),
  UNIQUE KEY UQ_BundleID_ReworkState_SectionID (BundleID,ReworkState,SectionID),
  KEY FK_EndLineSession_User (UserID),
  KEY FK_EndLineSession_Line (LineID),
  KEY FK_EndLineSession_Section (SectionID),
  CONSTRAINT FK_EndLineSession_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_EndLineSession_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_EndLineSession_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT FK_EndLineSession_User FOREIGN KEY (UserID) REFERENCES user (UserID)
);

CREATE TABLE IF NOT EXISTS end_line_fault_log (
  EndLineFaultLogID INT NOT NULL AUTO_INCREMENT,
  FaultCount INT NOT NULL,
  EndLineSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultDescription VARCHAR(256) DEFAULT NULL,
  PieceID INT DEFAULT NULL,
  IsQualityChecked bit(1) NOT NULL DEFAULT b'0',
  IsPieceQualityChecked bit(1) NOT NULL DEFAULT b'0',
  PieceWiseScanID INT DEFAULT NULL,
  IsRework bit(1) DEFAULT NULL,
  IsRejected bit(1) DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (EndLineFaultLogID),
  KEY FK_EndLineFaultLog_EndLineSession (EndLineSessionID),
  KEY FK_EndLineFaultLog_Fault (FaultID),
  KEY FK_EndLineFaultLog_PieceWiseCutReport (PieceID),
  KEY FK_EndLineFaultLog_PieceWiseScan (PieceWiseScanID),
  CONSTRAINT FK_EndLineFaultLog_EndLineSession FOREIGN KEY (EndLineSessionID) REFERENCES end_line_session (EndLineSessionID),
  CONSTRAINT FK_EndLineFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES fault (FaultID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseScan FOREIGN KEY (PieceWiseScanID) REFERENCES piece_wise_scan (PieceWiseScanningID)
);

CREATE TABLE IF NOT EXISTS audit_form_fault_log (
  AuditFormFaultLogID INT NOT NULL AUTO_INCREMENT,
  AuditFormSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (AuditFormFaultLogID),
  KEY FK_AuditFormFaultLog_AuditFormSession (AuditFormSessionID),
  KEY FK_AuditFormFaultLog_Fault (FaultID),
  CONSTRAINT FK_AuditFormFaultLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES audit_form_session (AuditFormSessionID),
  CONSTRAINT FK_AuditFormFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES fault (FaultID)
);

CREATE TABLE IF NOT EXISTS check_list_response_log (
  CheckListResponseLogID INT NOT NULL AUTO_INCREMENT,
  AuditFormSessionID INT NOT NULL,
  CheckListDescription VARCHAR(64) NOT NULL,
  Response VARCHAR(6) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (CheckListResponseLogID),
  KEY FK_CheckListResponseLog_AuditFormSession (AuditFormSessionID),
  CONSTRAINT FK_CheckListResponseLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES audit_form_session (AuditFormSessionID)
);

CREATE TABLE  allocated_machines( 
    AllocatedMachinesID INT NOT NULL AUTO_INCREMENT,
    WorkerID INT NOT NULL,
    MachineID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_AllocatedMachinesID PRIMARY KEY (AllocatedMachinesID),
    CONSTRAINT FK_AllocatedMachines_Worker FOREIGN KEY (WorkerID) REFERENCES worker(WorkerID),
    CONSTRAINT FK_AllocatedMachines_Machine FOREIGN KEY (MachineID) REFERENCES machine(MachineID)
);

CREATE TABLE  machine_operations(
    MachineOperationsID INT NOT NULL AUTO_INCREMENT,
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_MachineOperationsID PRIMARY KEY (MachineOperationsID),
    CONSTRAINT FK_MachineOperations_Operation FOREIGN KEY (OperationID) REFERENCES operation(OperationID),
    CONSTRAINT FK_MachineOperations_Machine FOREIGN KEY (MachineID) REFERENCES machine(MachineID)    
);


CREATE TABLE worker_operations(
    WorkerOperationsID INT NOT NULL AUTO_INCREMENT,
    WorkerScanID BIGINT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_WorkerOperationsID PRIMARY KEY (WorkerOperationsID),
    CONSTRAINT FK_WorkerOperations_Operation FOREIGN KEY (OperationID) REFERENCES operation(OperationID),
    CONSTRAINT FK_WorkerOperations_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES worker_scan (WorkerScanID)   
);


CREATE TABLE marker_mapping(
    MarkerMappingID INT NOT NULL AUTO_INCREMENT,
    MarkerID INT NOT NULL,
    Size INT NOT NULL,
    Ratio INT NOT NULL,
    Inseam  INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_MarkerMappingID PRIMARY KEY (MarkerMappingID),
    CONSTRAINT FK_MarkerMappingID_Marker FOREIGN KEY (MarkerID) REFERENCES marker(MarkerID)

);
