CREATE DATABASE IF NOT EXISTS ApperalSooperwizer;
USE ApperalSooperwizer;
-- ================================================
-- =================================================
CREATE TABLE style_template (
  StyleTemplateID INT NOT NULL AUTO_INCREMENT,
  StyleTemplateCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_StyleTemplate PRIMARY KEY (StyleTemplateID),
  CONSTRAINT UQ_StyleTemplateCode UNIQUE (StyleTemplateCode)
);


CREATE TABLE section (
  SectionID INT NOT NULL AUTO_INCREMENT,
  SectionCode VARCHAR(64) NOT NULL,
  SectionDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Section PRIMARY KEY (SectionID),
  CONSTRAINT UQ_SectionCode UNIQUE (SectionCode)
);
CREATE TABLE scan_group (
  GroupID INT NOT NULL AUTO_INCREMENT,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_ScanGroup PRIMARY KEY (GroupID)
);

CREATE TABLE line (
  LineID INT NOT NULL AUTO_INCREMENT,
  LineCode VARCHAR(64) NOT NULL,
  LineDescription VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Line PRIMARY KEY (LineID),
  CONSTRAINT UQ_LineCode UNIQUE(LineCode)
);

CREATE TABLE worker (
  WorkerID INT NOT NULL AUTO_INCREMENT,
  WorkerCode VARCHAR(64) NOT NULL,
  WorkerDescription VARCHAR(64) NOT NULL,
  WorkerImageUrl VARCHAR(2056) DEFAULT NULL,
  WorkerThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  AllocatedMachines json DEFAULT NULL,
  TodayCheckin DATETIME DEFAULT NULL,
  TodayProduction INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Worker PRIMARY KEY (WorkerID),
  CONSTRAINT UQ_WorkerCode UNIQUE (WorkerCode)
);


CREATE TABLE module (
  ModuleID INT NOT NULL AUTO_INCREMENT,
  ModuleCode VARCHAR(64) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Module PRIMARY KEY (ModuleID),
  CONSTRAINT UQ_ModuleCode UNIQUE (ModuleCode)
);


CREATE TABLE box (
  BoxID INT NOT NULL AUTO_INCREMENT,
  BoxCode VARCHAR(64) NOT NULL,
  CurrentAddress INT unsigned NOT NULL DEFAULT '0',
  IssueDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Box PRIMARY KEY (BoxID),
  CONSTRAINT UQ_BoxCode UNIQUE   (BoxCode)
);


CREATE TABLE machine_type (
  MachineTypeID INT NOT NULL AUTO_INCREMENT,
  MachineTypeCode VARCHAR(64) NOT NULL,
  MachineTypeDescription VARCHAR(64) NOT NULL,
  Allowance FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_MachineType PRIMARY KEY (MachineTypeID),
  CONSTRAINT UQ_MachineTypeCode UNIQUE (MachineTypeCode)
);


CREATE TABLE sale_order (
  SaleOrderID INT NOT NULL AUTO_INCREMENT,
  SaleOrderCode VARCHAR(100) NOT NULL,
  Customer VARCHAR(64) NOT NULL,
  OrderQuantity INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_SaleOrder PRIMARY KEY (SaleOrderID),
  CONSTRAINT UQ_SaleOrderCode UNIQUE (SaleOrderCode)
);


CREATE TABLE department (
  DepartmentID INT NOT NULL AUTO_INCREMENT,
  DepartmentName VARCHAR(40) NOT NULL,
  CreatedAt DATETIME DEFAULT (now()),
  UpdatedAt DATETIME DEFAULT (now()),
  CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

CREATE TABLE operation (
  OperationID INT NOT NULL AUTO_INCREMENT,
  OperationCode VARCHAR(64) NOT NULL,
  OperationName VARCHAR(64) NOT NULL,
  OperationDescription VARCHAR(64) NOT NULL,
  PieceRate FLOAT DEFAULT NULL,
  OperationType VARCHAR(64) NOT NULL,
  OperationImageUrl VARCHAR(2056) DEFAULT NULL,
  OperationThumbnailUrl VARCHAR(2056) DEFAULT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  DepartmentID INT NOT NULL,
  SMV FLOAT DEFAULT NULL,
  CONSTRAINT PK_Operation PRIMARY KEY (OperationID),
  CONSTRAINT UQ_OperationCode UNIQUE (OperationCode),
  CONSTRAINT FK_operation_department FOREIGN KEY (DepartmentID) REFERENCES department (DepartmentID),
  CONSTRAINT FK_Operation_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT CK_Operation_OperationType CHECK ((OperationType in ('Manual','Machine')))
);

CREATE TABLE cutting_table (
  CuttingTableID INT NOT NULL AUTO_INCREMENT,
  CuttingTableCode VARCHAR(40) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_CuttingTable PRIMARY KEY (CuttingTableID)
);

CREATE TABLE cutting_manpower (
  CuttingManpowerID INT NOT NULL AUTO_INCREMENT,
  CuttingTableID INT NOT NULL,
  CuttingManpowerDate date NOT NULL,
  Manpower FLOAT NOT NULL,
  Shift VARCHAR(20) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_CuttingManpower PRIMARY KEY (CuttingManpowerID),
  CONSTRAINT FK_CuttingManpower_CuttingTable FOREIGN KEY (CuttingTableID) REFERENCES cutting_table (CuttingTableID),
  CONSTRAINT CK_CuttingManpower_Shift CHECK ((Shift IN ('Morning','Evening','Night')))
  );


CREATE TABLE target_feeding (
  TargetFeedingID INT NOT NULL AUTO_INCREMENT,
  TargetDate date NOT NULL,
  TargetShift VARCHAR(20) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  PlanEfficiency FLOAT NOT NULL,
  PlanProduction FLOAT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_TargetFeeding PRIMARY KEY (TargetFeedingID),
  CONSTRAINT FK_TargetFeeding_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_TargetFeeding_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT CK_TargetFeeding_TargetShift CHECK ((TargetShift in ('Morning','Evening','Night'))));

CREATE TABLE production_order (
  ProductionOrderID INT NOT NULL AUTO_INCREMENT,
  ProductionOrderCode VARCHAR(100) NOT NULL,
  StyleCode VARCHAR(100) NOT NULL,
  Article VARCHAR(100) NOT NULL,
  CuttingSAM FLOAT DEFAULT NULL,
  ExFactoryDate date DEFAULT NULL,
  SaleOrderID INT NOT NULL,
  StyleTemplateID INT DEFAULT NULL,
  IsFollowOperationSequence BIT(1) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_ProductionOrder PRIMARY KEY (ProductionOrderID),
  CONSTRAINT UQ_ProductionOrderCode UNIQUE (ProductionOrderCode),
  CONSTRAINT FK_ProductionOrder_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES sale_order (SaleOrderID),
  CONSTRAINT FK_ProductionOrder_StyleTempate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID)
);


CREATE TABLE production_order_client (
  ProductionOrderClientID INT NOT NULL AUTO_INCREMENT,
  ProductionOrderID INT NOT NULL,
  Size VARCHAR(20) NOT NULL,
  Color VARCHAR(20) NOT NULL,
  RequiredPieces INT NOT NULL,
  PlannedPieces INT NOT NULL,
  MainBodyFabricType VARCHAR(100) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_ProductionOrderClient PRIMARY KEY (ProductionOrderClientID),
  CONSTRAINT UQ_ProductionOrderID_Size_Color UNIQUE (ProductionOrderID,Size,Color),
  CONSTRAINT FK_ProductionOrderClient_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID)
);


CREATE TABLE marker (
  MarkerID INT NOT NULL AUTO_INCREMENT,
  MarkerCode VARCHAR(64) NOT NULL,
  ProductionOrderID INT NOT NULL,
  MarkerMapping json NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Marker PRIMARY KEY (MarkerID),
  CONSTRAINT UQ_MarkerCodePoID UNIQUE (MarkerCode,ProductionOrderID),
  CONSTRAINT FK_Marker_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID)
);


CREATE TABLE style_bulletin (
  StyleBulletinID INT NOT NULL AUTO_INCREMENT,
  StyleTemplateID INT NOT NULL,
  OperationID INT NOT NULL,
  OperationSequence INT NOT NULL,
  ScanType VARCHAR(10) NOT NULL,
  IsFirst BIT(1) NOT NULL DEFAULT b'0',
  IsLast BIT(1) NOT NULL DEFAULT b'0',
  MachineTypeID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  SMV FLOAT DEFAULT NULL,
  PieceRate FLOAT DEFAULT NULL,
  IsCritical BIT(1) DEFAULT b'0',
  CONSTRAINT PK_StyleBulletin PRIMARY KEY (StyleBulletinID),
  CONSTRAINT UQ_StyleBulletin_StyleTemplateID_OperationID UNIQUE (StyleTemplateID,OperationID),
  CONSTRAINT FK_StyleBulletin_MachineType FOREIGN KEY (MachineTypeID) REFERENCES machine_type (MachineTypeID),
  CONSTRAINT FK_StyleBulletin_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_StyleBulletin_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID),
  CONSTRAINT CK_StyleBulletin_ScanType CHECK ((ScanType in ('Bundle','Piece')))
);

CREATE TABLE cut_job (
  CutJobID INT NOT NULL AUTO_INCREMENT,
  CutNo VARCHAR(32) NOT NULL,
  ProductionOrderID INT NOT NULL,
  Size VARCHAR(20) NOT NULL,
  Color VARCHAR(20) NOT NULL,
  CutQuantity INT NOT NULL,
  MarkerID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_CutJob PRIMARY KEY (CutJobID),
  CONSTRAINT UQ_ProductionOrder_CutNo UNIQUE (ProductionOrderID,CutNo),
  CONSTRAINT FK_CutJob_Marker FOREIGN KEY (MarkerID) REFERENCES marker (MarkerID),
  CONSTRAINT FK_CutJob_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID)
);

CREATE TABLE cut_report (
  BundleID INT NOT NULL AUTO_INCREMENT,
  BundleCode VARCHAR(64) NOT NULL,
  BundleQuantity INT NOT NULL,
  ScannedQuantity INT NOT NULL DEFAULT '0',
  RemainingQuantity INT NOT NULL,
  CutJobID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  Embellishment BIT(1) DEFAULT (0),
  CONSTRAINT PK_CutReport PRIMARY KEY (BundleID),
  CONSTRAINT UQ_CutJobID_BundleCode UNIQUE(CutJobID,BundleCode),
  CONSTRAINT FK_CutReport_CutJob FOREIGN KEY (CutJobID) REFERENCES cut_job (CutJobID)
);


CREATE TABLE piece_wise_cut_report (
  PieceID INT NOT NULL AUTO_INCREMENT,
  BundleID INT NOT NULL,
  PieceNumber INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  StyleTemplateID INT DEFAULT NULL,
  CONSTRAINT PK_PieceWiseCutReport PRIMARY KEY (PieceID),
  CONSTRAINT UQ_BundleID_PieceNo UNIQUE (BundleID,PieceNumber),
  CONSTRAINT FK_PieceWiseCutReport_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID)
);


CREATE TABLE machine (
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
  IsMachineDown BIT(1) DEFAULT NULL,
  CONSTRAINT PK_Machine PRIMARY KEY (MachineID),
  CONSTRAINT UQ_MachineCode UNIQUE (MachineCode),
  CONSTRAINT UQ_ActiveWorker UNIQUE (ActiveWorkerID),
  CONSTRAINT UQ_Machine_Box UNIQUE (BoxID),
  CONSTRAINT FK_Machine_ActiveWorker FOREIGN KEY (ActiveWorkerID) REFERENCES worker (WorkerID),
  CONSTRAINT FK_Machine_Box FOREIGN KEY (BoxID) REFERENCES box (BoxID),
  CONSTRAINT FK_Machine_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_Machine_MachineType FOREIGN KEY (MachineTypeID) REFERENCES machine_type (MachineTypeID)
);

CREATE TABLE machine_down_time (
  MachineDownTimeID INT NOT NULL AUTO_INCREMENT,
  MachineID INT NOT NULL,
  DownReason VARCHAR(9999) DEFAULT NULL,
  StartTime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  EndTime DATETIME DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_MachineDownTime PRIMARY KEY (MachineDownTimeID),
  CONSTRAINT FK_MachineDownTime_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID)
);


CREATE TABLE worker_scan (
  WorkerScanID INT NOT NULL AUTO_INCREMENT,
  WorkerID INT NOT NULL,
  LineID INT NOT NULL,
  MachineID INT NOT NULL,
  WorkerOperations json NOT NULL,
  Extras VARCHAR(64) DEFAULT NULL,
  HasExpire BIT(1) DEFAULT b'0',
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  EndedAt DATETIME DEFAULT NULL,
  CONSTRAINT PK_WorkerScan PRIMARY KEY (WorkerScanID),
  CONSTRAINT FK_WorkerScan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_WorkerScan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_WorkerScan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE line_layout (
  LineLayoutID INT NOT NULL AUTO_INCREMENT,
  RevisionNo INT NOT NULL,
  LineID INT NOT NULL,
  ProductionOrderID INT NOT NULL,
  LineLayoutDate date NOT NULL,
  LineLayoutStatus VARCHAR(8) NOT NULL,
  LineLayoutOperationMachines json NOT NULL,
  IsAnyMachines BIT(1) NOT NULL,
  ParentLineLayoutID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  LineLayoutName VARCHAR(256) NOT NULL,
  CONSTRAINT PK_LineLayout PRIMARY KEY (LineLayoutID),
  CONSTRAINT FK_LineLayout_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_LineLayout_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES production_order (ProductionOrderID),
  CONSTRAINT FK_Parent_LineLayoutID FOREIGN KEY (ParentLineLayoutID) REFERENCES line_layout (LineLayoutID)
);


CREATE TABLE tag (
  TagID INT NOT NULL,
  BundleID INT DEFAULT NULL,
  StyleTemplateID INT DEFAULT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PieceID INT DEFAULT NULL,
  GroupID INT DEFAULT NULL,
  CONSTRAINT PK_Tag PRIMARY KEY (TagID),
  CONSTRAINT FK_Tag_Bundle FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_Tag_Group FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID),
  CONSTRAINT FK_Tag_Piece FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_Tag_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES style_template (StyleTemplateID)
);



CREATE TABLE piece_wise_group (
  PieceWiseGroupID INT NOT NULL AUTO_INCREMENT,
  GroupID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_CutReport PRIMARY KEY (PieceWiseGroupID),
  CONSTRAINT FK_CutReport_PieceWiseGroup FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_PieceWiseCutReport_PieceWiseGroup FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_PieceWiseGroup_Group FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID)
);


CREATE TABLE fault (
  FaultID INT NOT NULL AUTO_INCREMENT,
  FaultCode VARCHAR(64) NOT NULL,
  FaultDescription VARCHAR(256) NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Fault PRIMARY KEY (FaultID),
  CONSTRAINT UQ_Section_FaultCode UNIQUE (SectionID,FaultCode),
  CONSTRAINT FK_Fault_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

CREATE TABLE scan (
  ScanID INT NOT NULL AUTO_INCREMENT,
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
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_Scan PRIMARY KEY (ScanID),
  CONSTRAINT UQ_Scan_BundleID_PieceID_OperationID UNIQUE (BundleID,PieceID,OperationID),
  CONSTRAINT FK_Scan__PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_Scan_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_Scan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_Scan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_Scan_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_Scan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE piece_wise_scan (
  PieceWiseScanningID INT NOT NULL AUTO_INCREMENT,
  ScanID INT DEFAULT NULL,
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
  CONSTRAINT PK_PieceWiseScan PRIMARY KEY (PieceWiseScanningID),
  CONSTRAINT UQ_PieceWiseScan_BundleID_PieceID_OperationID UNIQUE (BundleID,PieceID,OperationID),
  CONSTRAINT FK_PieceWiseScan_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_PieceWiseScan_GroupScan FOREIGN KEY (GroupID) REFERENCES scan_group (GroupID),
  CONSTRAINT FK_PieceWiseScan_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_PieceWiseScan_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_PieceWiseScan_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_PieceWiseScan_PieceWiseGroup FOREIGN KEY (PieceWiseGroupID) REFERENCES piece_wise_group (PieceWiseGroupID),
  CONSTRAINT FK_PieceWiseScan_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE user (
  UserID INT NOT NULL AUTO_INCREMENT,
  UserName VARCHAR(64) NOT NULL,
  Password VARCHAR(1024) NOT NULL,
  UserType VARCHAR(64) NOT NULL,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_User PRIMARY KEY (UserID),
  CONSTRAINT UQ_UserName UNIQUE (UserName),
  CONSTRAINT FK_User_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_User_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID)
);

CREATE TABLE userpermission (
  UserPermissionID INT NOT NULL AUTO_INCREMENT,
  UserID INT NOT NULL,
  ModuleID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_UserPermission PRIMARY KEY (UserPermissionID),
  CONSTRAINT UQ_UserPermission UNIQUE (UserID,ModuleID),
  CONSTRAINT FK_UserPermission_Module FOREIGN KEY (ModuleID) REFERENCES module (ModuleID),
  CONSTRAINT FK_UserPermission_User FOREIGN KEY (UserID) REFERENCES user (UserID)
);

CREATE TABLE audit_form_session (
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
  CreatedAtDate DATE NOT NULL DEFAULT (cast(now() as date)),
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_InlineSession PRIMARY KEY (AuditFormSessionID),
  CONSTRAINT UQ_MachineID_MachineRound_CreatedAtDate_FollowUp UNIQUE (MachineID,CreatedAtDate,MachineRound,FollowUp),
  CONSTRAINT FK_InlineSession_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_InlineSession_Machine FOREIGN KEY (MachineID) REFERENCES machine (MachineID),
  CONSTRAINT FK_InlineSession_Operation FOREIGN KEY (OperationID) REFERENCES operation (OperationID),
  CONSTRAINT FK_InlineSession_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT FK_InlineSession_User FOREIGN KEY (UserID) REFERENCES user (UserID),
  CONSTRAINT FK_InlineSession_Worker FOREIGN KEY (WorkerID) REFERENCES worker (WorkerID)
);

CREATE TABLE audit_form_fault_log (
  AuditFormFaultLogID INT NOT NULL AUTO_INCREMENT,
  AuditFormSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_AuditFormFaultLog PRIMARY KEY (AuditFormFaultLogID),
  CONSTRAINT FK_AuditFormFaultLog_AuditFormSession FOREIGN KEY (AuditFormSessionID) REFERENCES audit_form_session (AuditFormSessionID),
  CONSTRAINT FK_AuditFormFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES fault (FaultID)
);


CREATE TABLE end_line_session (
  EndLineSessionID INT NOT NULL AUTO_INCREMENT,
  LineID INT NOT NULL,
  SectionID INT NOT NULL,
  BundleID INT NOT NULL,
  PieceID INT NOT NULL,
  UserID INT NOT NULL,
  Status TINYINT NOT NULL DEFAULT '0',
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_EndLineSession PRIMARY KEY (EndLineSessionID),
  CONSTRAINT FK_EndLineSession_CutReport FOREIGN KEY (BundleID) REFERENCES cut_report (BundleID),
  CONSTRAINT FK_EndLineSession_Line FOREIGN KEY (LineID) REFERENCES line (LineID),
  CONSTRAINT FK_EndLineSession_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES piece_wise_cut_report (PieceID),
  CONSTRAINT FK_EndLineSession_Section FOREIGN KEY (SectionID) REFERENCES section (SectionID),
  CONSTRAINT FK_EndLineSession_User FOREIGN KEY (UserID) REFERENCES user (UserID),
  CONSTRAINT CK_EndLineSession_Status CHECK ((Status in (0,1,2,3,4,5,6,7,8)))
);

CREATE TABLE end_line_fault_log (
  EndLineFaultLogID INT NOT NULL AUTO_INCREMENT,
  EndLineSessionID INT NOT NULL,
  FaultID INT NOT NULL,
  FaultCount INT NOT NULL,
  PieceWiseScanningID INT NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_EndLineFaultLog PRIMARY KEY (EndLineFaultLogID),
  CONSTRAINT FK_EndLineFaultLog_EndLineSession FOREIGN KEY (EndLineSessionID) REFERENCES end_line_session (EndLineSessionID),
  CONSTRAINT FK_EndLineFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES fault (FaultID),
  CONSTRAINT FK_EndLineFaultLog_PieceWiseScan FOREIGN KEY (PieceWiseScanningID) REFERENCES piece_wise_scan (PieceWiseScanningID)
);


CREATE TABLE check_list_response_log (
  CheckListResponseLogID INT NOT NULL AUTO_INCREMENT,
  AuditFormSessionID INT NOT NULL,
  CheckListDescription VARCHAR(64) NOT NULL,
  Response VARCHAR(6) NOT NULL,
  CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT PK_CheckListResponseLog PRIMARY KEY (CheckListResponseLogID),
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
    WorkerScanID INT NOT NULL,
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
