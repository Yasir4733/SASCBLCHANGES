
    BundleID int IDENTITY(1,1) NOT NULL,
	BundleCode varchar(64) NOT NULL,
	BundleQuantity int NOT NULL,
	ScannedQuantity int NOT NULL,
	RemainingQuantity int NOT NULL,
	CutJobID int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	StyleTemplateID int NULL,


    StyleTemplateID int IDENTITY(1,1) NOT NULL,
	StyleTemplateCode varchar(64) NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	ParentStyleTemplateID int NULL,

    ParentStyleTemplateID int IDENTITY(1,1) NOT NULL,
	ParentStyleTemplateDescription varchar(64) NOT NULL,

    CutJobID int IDENTITY(1,1) NOT NULL,
	CutNo varchar(32) NOT NULL,
	ProductionOrderID int NOT NULL,
	CutQuantity int NOT NULL,
	MarkerID int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,



    MarkerID int IDENTITY(1,1) NOT NULL,
	MarkerCode varchar(64) NOT NULL,
	ProductionOrderID int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    ProductionOrderID int IDENTITY(1,1) NOT NULL,
	ProductionOrderCode varchar(100) NOT NULL,
	SaleOrderID int NOT NULL,
	StyleTemplateID int NULL,
	IsFollowOperationSequence bit NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    SaleOrderID int IDENTITY(1,1) NOT NULL,
	SaleOrderCode varchar(100) NOT NULL,
	Customer varchar(64) NOT NULL,
	OrderQuantity int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    PieceID int IDENTITY(1,1) NOT NULL,
	BundleID int NOT NULL,
	PieceNumber int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	StyleTemplateID int NULL,



    OperationID int IDENTITY(1,1) NOT NULL,
	OperationCode varchar(64) NOT NULL,
	OperationName varchar(64) NOT NULL,
	OperationDescription varchar(64) NOT NULL,
	PieceRate float NULL,
	OperationType varchar(64) NOT NULL,
	OperationImageUrl varchar(max) NULL,
	OperationThumbnailUrl varchar(max) NULL,
	SectionID int NOT NULL,
    DepartmentID int NULL,
	SMV float NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	

    SectionID int IDENTITY(1,1) NOT NULL,
	SectionCode varchar(64) NOT NULL,
	SectionDescription varchar(64) NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    DepartmentID int IDENTITY(1,1) NOT NULL,
	DepartmentName varchar(40) NOT NULL,
	CreatedAt datetime NULL,
	UpdatedAt datetime NULL,



    WorkerID int IDENTITY(1,1) NOT NULL,
	WorkerCode varchar(64) NOT NULL,
	WorkerDescription varchar(64) NOT NULL,
	WorkerImageUrl varchar(max) NULL,
	WorkerThumbnailUrl varchar(max) NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	TodayCheckin datetime NULL,
	TodayProduction int NULL,


    LineID int IDENTITY(1,1) NOT NULL,
	LineCode varchar(64) NOT NULL,
	LineDescription varchar(64) NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    MachineID int IDENTITY(1,1) NOT NULL,
	MachineCode varchar(64) NOT NULL,
	MachineDescription varchar(64) NOT NULL,
	MachineImageUrl varchar(max) NULL,
	MachineThumbnailUrl varchar(max) NULL,
	MachineTypeID int NOT NULL,
	ActiveWorkerID int NULL,
	LineID int NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	BoxID int NULL,
	IsMachineDown bit NULL,


    MachineTypeID int IDENTITY(1,1) NOT NULL,
	MachineTypeCode varchar(64) NOT NULL,
	MachineTypeDescription varchar(64) NOT NULL,
	Allowance float NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,


    BoxID int IDENTITY(1,1) NOT NULL,
	BoxCode varchar(64) NOT NULL,
	IssueDate datetime NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	CurrentAddress int NOT NULL,





    WorkerScanID bigint IDENTITY(1,1) NOT NULL,
	WorkerID int NOT NULL,
	LineID int NOT NULL,
	MachineID int NOT NULL,
	CreatedAt datetime NOT NULL,
	UpdatedAt datetime NOT NULL,
	HasExpired bit NOT NULL,
	EndedAt datetime NULL,
	Extras varchar(64) NULL,







DEFAULT NULL
DEFAULT 0
DEFAULT GETDATE()
CONSTRAINT UQ_StyleTemplateCode
CONSTRAINT UQ_ProductionOrder_CutNo
CONSTRAINT UQ_CutJobID_BundleCode
CONSTRAINT UQ_ProductionOrderCode
CONSTRAINT DF_ProductionOrder_IsFollowOperationSequence  DEFAULT 0
CONSTRAINT UQ_MarkerCodePOID
CONSTRAINT UQ_SaleOrderCode
CONSTRAINT UQ_BundleID_PieceNo
CONSTRAINT UQ_SectionCode 
CONSTRAINT UQ_Department_DepartmentName
CONSTRAINT UQ_WorkerCode
CONSTRAINT UQ_Machine_MachineID_BoxID
CONSTRAINT UQ_MachineCode
CONSTRAINT UQ_MachineTypeCode
CONSTRAINT UQ_BoxCode

DEFAULT (NULL) FOR ActiveWorkerID
DEFAULT (NULL) FOR LineID
DEFAULT ((0)) FOR CurrentAddress
DEFAULT (NULL) FOR MachineImageUrl
DEFAULT ((0)) FOR HasExpired
DEFAULT (NULL) FOR Extras
DEFAULT (NULL) FOR EndedAt
    --  BundleId --> CutjobID,StyleTemplateId
    -- StyleTemplateID --> MarkerID
    -- MarkerID --> ProductionOrdrID
    -- ProductionOrderID --> SqlerOrderID




-- =======================================================
-- =======================================================

	-- BundleCode varchar(64) NOT NULL,
	-- BundleQuantity int NOT NULL,
	-- ScannedQuantity int NOT NULL DEFAULT 0,
	-- RemainingQuantity int NOT NULL,
	-- CutJobID int NOT NULL,
	-- CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	-- UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),

	-- StyleTemplateID int NULL,
    -- CutNo varchar(32) NOT NULL,
	-- ProductionOrderID int NOT NULL,
	-- CutQuantity int NOT NULL,
	-- MarkerID int NOT NULL,
	-- CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	-- UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),






    -- CONSTRAINT UQ_CutJobID_BundleCode
    -- CONSTRAINT UQ_ProductionOrder_CutNo


USE [SooperWizer];

CREATE TABLE [Data].[Scan_D](
    ScanID BIGINT IDENTITY(1,1) NOT NULL,
	WorkerScanID BIGINT NOT NULL,
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
    CONSTRAINT UQ_Scan_BundleID_PieceID_OperationID UNIQUE(BundleID,PieceID,OperationID)
)
    




--- ======================================
---- =====================================
CONSTRAINT CONSTRAINT FK_ScanDenormalize_CutReport FOREIGN KEY(BundleID)
REFERENCES [Essentials].[CutReport] (BundleID)