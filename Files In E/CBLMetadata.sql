USE [MASTER];

GO
    CREATE DATABASE [CBL];

GO
    USE [CBL];

GO
    CREATE SCHEMA [Essentials];

GO
    CREATE SCHEMA [Data];

GO
    CREATE SCHEMA [Rebundle];

GO
    CREATE SCHEMA [Excel];

GO
    CREATE TABLE [Essentials].[MachineType](
        MachineTypeID INT IDENTITY(1, 1),
        MachineTypeCode VARCHAR(64) NOT NULL,
        MachineTypeDescription VARCHAR(64) NOT NULL,
        Allowance FLOAT NOT NULL,
        CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
        UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT UQ_MachineTypeCode UNIQUE (MachineTypeCode),
        CONSTRAINT PK_MachineTypeID PRIMARY KEY (MachineTypeID)
    );

CREATE TABLE [Essentials].[Section](
    SectionID INT IDENTITY(1, 1),
    SectionCode VARCHAR(64) NOT NULL,
    SectionDescription VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_SectionID PRIMARY KEY (SectionID),
    CONSTRAINT UQ_SectionCode UNIQUE (SectionCode)
);

CREATE TABLE [Essentials].[Line](
    LineID INT IDENTITY(1, 1),
    LineCode VARCHAR(64) NOT NULL,
    LineDescription VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LineID PRIMARY KEY (LineID),
    CONSTRAINT UQ_LineCode UNIQUE (LineCode)
);

CREATE TABLE [Essentials].[Worker](
    WorkerID INT IDENTITY(1, 1),
    WorkerCode VARCHAR(64) NOT NULL,
    WorkerDescription VARCHAR(64) NOT NULL,
    WorkerImageUrl VARCHAR(max),
    WorkerThumbnailUrl VARCHAR(max),
    LoginTimeToday DATETIME,
    TotalPiecesToday INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_WorkerID PRIMARY KEY (WorkerID),
    CONSTRAINT UQ_WorkerCode UNIQUE (WorkerCode)
);

CREATE TABLE [Essentials].[SkillLevel](
    SkillLevelID INT IDENTITY(1, 1),
    SkillName VARCHAR(10) NOT NULL,
    SkillRate FLOAT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_SkillLevelID PRIMARY KEY (SkillLevelID),
    CONSTRAINT UQ_SkillLevelName UNIQUE (SkillName)
);

CREATE TABLE [Essentials].[Operation](
    OperationID INT IDENTITY(1, 1),
    OperationCode VARCHAR(64) NOT NULL,
    OperationName VARCHAR(64) NOT NULL,
    OperationDescription VARCHAR(64) NOT NULL,
    Department VARCHAR(64) NOT NULL,
    PieceRate INT,
    -- This will not be used here it'll be used for other projects
    OperationType VARCHAR(64) NOT NULL,
    SkillLevelID INT NOT NULL,
    OperationImageUrl VARCHAR(max),
    OperationThumbnailUrl VARCHAR(max),
    SectionID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_OperationID PRIMARY KEY (OperationID),
    CONSTRAINT UQ_OperationCode UNIQUE (OperationCode),
    CONSTRAINT CK_Operation_Department CHECK(Department In ('PreWash', 'PostWash')),
    CONSTRAINT CK_Operation_OperationType CHECK(OperationType In ('Manual', 'Machine')),
    CONSTRAINT FK_Operation_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID),
    CONSTRAINT FK_Operation_SkillLevel FOREIGN KEY (SkillLevelID) REFERENCES [Essentials].[SkillLevel](SkillLevelID),
);

CREATE TABLE [Essentials].[Machine](
    MachineID INT IDENTITY(1, 1),
    MachineCode VARCHAR(64) NOT NULL,
    MachineDescription VARCHAR(64) NOT NULL,
    MachineImageUrl VARCHAR(max),
    MachineThumbnailUrl VARCHAR(max),
    MachineTypeID INT NOT NULL,
    WorkerID INT,
    LineID INT,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MachineID PRIMARY KEY (MachineID),
    CONSTRAINT UQ_MachineCode UNIQUE (MachineCode),
    CONSTRAINT FK_Machine_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_Machine_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_Machine_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID)
);

CREATE TABLE [Essentials].[MachineMapping](
    MachineMappingID INT IDENTITY(1, 1),
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MachineMappingID PRIMARY KEY (MachineMappingID),
    CONSTRAINT UQ_MachineOperations UNIQUE (MachineID, OperationID),
    CONSTRAINT FK_MachineMapping_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_MachineMapping_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Data].[WorkerScan](
    WorkerScanID INT IDENTITY(1, 1),
    WorkerID INT NOT NULL,
    WorkerCode VARCHAR(64),
    WorkerDescription VARCHAR(64),
    LineID INT NOT NULL,
    LineCode VARCHAR(64),
    LineDescription VARCHAR(64),
    MachineID INT NOT NULL,
    MachineCode VARCHAR(64),
    MachineDescription VARCHAR(64),
    MachineTypeID INT,
    MachineTypeCode VARCHAR(64),
    MachineTypeDescription VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_WorkerScanID PRIMARY KEY (WorkerScanID),
    CONSTRAINT FK_WorkerScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_WorkerScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_WorkerScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_WorkerScan_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID)
);

CREATE TABLE [Data].[WorkerScanOperationMapping](
    WorkerScanOperationMappingID INT IDENTITY(1, 1),
    WorkerScanID INT NOT NULL,
    OperationID INT NOT NULL,
    OperationCode VARCHAR(64),
    OperationName VARCHAR(64),
    OperationDescription VARCHAR(64),
    Department VARCHAR(64),
    PieceRate INT,
    OperationType VARCHAR(64),
    SkillLevelID INT,
    SkillName VARCHAR(10),
    SkillRate FLOAT,
    SectionID INT,
    SectionCode VARCHAR(64),
    SectionDescription VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_WorkerScanOperationMapping PRIMARY KEY (WorkerScanOperationMappingID),
    CONSTRAINT UQ_WorkerScanOperationMappings UNIQUE (WorkerScanID, OperationID),
    CONSTRAINT FK_WorkerScan_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID),
    CONSTRAINT FK_WorkerScan_SkillLevel FOREIGN KEY (SkillLevelID) REFERENCES [Essentials].[SkillLevel](SkillLevelID),
    CONSTRAINT FK_WorkerScanOperationMapping_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan](WorkerScanID),
    CONSTRAINT FK_WorkerScanOperationMapping_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Essentials].[StyleTemplate](
    StyleTemplateID INT IDENTITY(1, 1),
    StyleTemplateCode VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_StyleTemplateID PRIMARY KEY (StyleTemplateID),
    CONSTRAINT UQ_StyleTemplateCode UNIQUE (StyleTemplateCode)
);

CREATE TABLE [Essentials].[StyleBulletin](
    StyleBulletinID INT IDENTITY(1, 1),
    StyleTemplateID INT NOT NULL,
    StyleTemplateCode VARCHAR(64),
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
    CONSTRAINT PK_StyleBulletinID PRIMARY KEY (StyleBulletinID),
    CONSTRAINT UQ_StyleBulletin_StyleTemplateID_OperationID UNIQUE (StyleTemplateID, OperationID),
    CONSTRAINT FK_StyleBulletin_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID),
    CONSTRAINT FK_StyleBulletin_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID),
    CONSTRAINT FK_StyleBulletin_SkillLevel FOREIGN KEY (SkillLevelID) REFERENCES [Essentials].[SkillLevel](SkillLevelID),
    CONSTRAINT FK_StyleBulletin_MachineType FOREIGN KEY (MachineTypeID) REFERENCES [Essentials].[MachineType](MachineTypeID),
    CONSTRAINT FK_StyleBulletin_StyleTemplate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID)
);

CREATE TABLE [Essentials].[SaleOrder](
    SaleOrderID INT IDENTITY(1, 1),
    PpcOrderNum VARCHAR(64) NOT NULL,
    Customer VARCHAR(64) NOT NULL,
    CustomerStyle VARCHAR(64) NOT NULL,
    RequestCustomerPoCode VARCHAR(64) NOT NULL,
    PoNo VARCHAR(64) NOT NULL,
    CblPo VARCHAR(64) NOT NULL,
    ContractCode VARCHAR(64) NOT NULL,
    OrderNum VARCHAR(64) NOT NULL,
    OrderQuantity INT NOT NULL,
    XMillDate DATE NOT NULL,
    FabricYield FLOAT NOT NULL,
    FabricStyle VARCHAR(64) NOT NULL,
    Wash INT NOT NULL,
    Fabric VARCHAR(64) NOT NULL,
    TypeFly VARCHAR(64) NOT NULL,
    BackPocketTemplate VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_SaleOrderID PRIMARY KEY (SaleOrderID),
    CONSTRAINT UQ_PpcOrderNum UNIQUE (PpcOrderNum)
);

CREATE TABLE [Essentials].[ProductionOrder](
    ProductionOrderID INT IDENTITY(1, 1),
    OrderPartID INT NOT NULL,
    SaleOrderID INT NOT NULL,
    StyleTemplateID INT,
    FollowsOperationSequence BIT,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_ProductionOrderID PRIMARY KEY (ProductionOrderID),
    CONSTRAINT UQ_OrderPartID UNIQUE (OrderPartID),
    CONSTRAINT FK_ProductionOrder_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES [Essentials].[SaleOrder](SaleOrderID),
    CONSTRAINT FK_ProductionOrder_StyleTempate FOREIGN KEY (StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID)
);

CREATE TABLE [Essentials].[Marker](
    MarkerID INT IDENTITY(1, 1),
    MarkerCode VARCHAR(64) NOT NULL,
    ProductionOrderID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MarkerID PRIMARY KEY (MarkerID),
    CONSTRAINT UQ_MarkerCodePoID UNIQUE (MarkerCode, ProductionOrderID),
    CONSTRAINT FK_Marker_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder](ProductionOrderID)
);

CREATE TABLE [Essentials].[MarkerMapping](
    MarkerMappingID INT IDENTITY(1, 1),
    MarkerID INT NOT NULL,
    Size VARCHAR(20) NOT NULL,
    Inseam INT NOT NULL,
    Ratio INT NOT NULL,
    CONSTRAINT UQ_MarkerIDSizeInseamRatio UNIQUE (MarkerID, Size, Inseam, Ratio),
    CONSTRAINT PK_MarkerMappingID PRIMARY KEY (MarkerMappingID),
    CONSTRAINT FK_MarkerMapping_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker](MarkerID)
);

CREATE TABLE [Essentials].[CutJob](
    CutJobID INT IDENTITY(1, 1),
    CutNo INT NOT NULL,
    ProductionOrderID INT NOT NULL,
    Plies INT NOT NULL,
    CutQuantity INT NOT NULL,
    Repeats INT NOT NULL,
    MarkerID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_CutJobID PRIMARY KEY (CutJobID),
    CONSTRAINT UQ_ProductionOrder_CutNo UNIQUE (ProductionOrderID, CutNo),
    CONSTRAINT FK_CutJob_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker](MarkerID),
    CONSTRAINT FK_CutJob_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder](ProductionOrderID)
);

CREATE TABLE [Essentials].[CutReport](
    BundleID INT IDENTITY(1, 1),
    BundleCode VARCHAR(64) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    Inseam INT NOT NULL,
    BundleQuantity INT NOT NULL,
    DimensionOneLKP VARCHAR(64) NOT NULL,
    CutJobID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_BundleID PRIMARY KEY (BundleID),
    CONSTRAINT UQ_BundleCode_CutJobID_Size UNIQUE (BundleCode, CutJobID, Size),
    CONSTRAINT FK_CutReport_CutJob FOREIGN KEY (CutJobID) REFERENCES [Essentials].[CutJob](CutJobID)
);

CREATE TABLE [Essentials].[PieceWiseCutReport](
    PieceID INT IDENTITY(1, 1),
    BundleID INT NOT NULL,
    PieceNumber INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_PieceID PRIMARY KEY (PieceID),
    CONSTRAINT UQ_BundleID_PieceNo UNIQUE(BundleID, PieceNumber),
    CONSTRAINT FK_PieceWiseCutReport_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport](BundleID)
);

CREATE TABLE [Data].[BundleWiseScan](
    BundleWiseScanID INT IDENTITY(1, 1),
    BundleID INT NOT NULL,
    WorkerScanID INT NOT NULL,
    WorkerID INT NOT NULL,
    LineID INT NOT NULL,
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    ShortAddress VARCHAR(64),
    LongAddress VARCHAR(64),
    HostIP VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_BundleWiseScanID PRIMARY KEY (BundleWiseScanID),
    CONSTRAINT UQ_BundleID_OperationID UNIQUE (BundleID, OperationID),
    CONSTRAINT FK_BundleWiseScan_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport](BundleID),
    CONSTRAINT FK_BundleWiseScan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan](WorkerScanID),
    CONSTRAINT FK_BundleWiseScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_BundleWiseScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_BundleWiseScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_BundleWiseScan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Data].[PieceWiseScan](
    PieceWiseScanID INT IDENTITY(1, 1),
    PieceID INT NOT NULL,
    WorkerScanID INT NOT NULL,
    WorkerID INT NOT NULL,
    LineID INT NOT NULL,
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    ShortAddress VARCHAR(64),
    LongAddress VARCHAR(64),
    HostIP VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_PieceWiseScanID PRIMARY KEY (PieceWiseScanID),
    CONSTRAINT UQ_PieceID_OperationID UNIQUE (PieceID, OperationID),
    CONSTRAINT FK_PieceWiseScan_CutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport](PieceID),
    CONSTRAINT FK_PieceWiseScan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan](WorkerScanID),
    CONSTRAINT FK_PieceWiseScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_PieceWiseScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_PieceWiseScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_PieceWiseScan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Rebundle].[RebundleCutReport](
    RebundleID INT IDENTITY(1, 1),
    RebundleCode VARCHAR(64) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    RebundleQuantity INT NOT NULL,
    Inseam INT,
    CutJobID INT,
    ProductionOrderID INT,
    SaleOrderID INT,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_RebundleCutReportID PRIMARY KEY (RebundleID),
    CONSTRAINT UQ_SaleOrderID_ProductionOrderID_Size UNIQUE (SaleOrderID, ProductionOrderID, Size),
    CONSTRAINT FK_RebundleCutReport_SaleOrder FOREIGN KEY (SaleOrderID) REFERENCES [Essentials].[SaleOrder](SaleOrderID),
    CONSTRAINT FK_RebundleCutReport_ProductionOrder FOREIGN KEY (ProductionOrderID) REFERENCES [Essentials].[ProductionOrder](ProductionOrderID)
);

-- CREATE TABLE [Rebundle].[RebundlePieceReport](
--     RebundlePieceID INT IDENTITY(1,1),
--     RebundleID INT NOT NULL,
--     RebundlePieceNumber INT NOT NULL,
--     PieceID INT NOT NULL,
--     CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
--     UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
--     CONSTRAINT PK_RebundlePieceReportID PRIMARY KEY (RebundlePieceID),
--     CONSTRAINT UQ_RebundleID_PieceNumber UNIQUE (RebundleID,RebundlePieceNumber),
--     CONSTRAINT FK_RebundlePieceReport_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport](PieceID),
--     CONSTRAINT FK_RebundlePieceReport_RebundleCutReport FOREIGN KEY (RebundleID) REFERENCES [Rebundle].[RebundleCutReport](RebundleID)
-- );
CREATE TABLE [Rebundle].[RebundleScan](
    RebundleScanID INT IDENTITY(1, 1),
    RebundleID INT NOT NULL,
    WorkerScanID INT NOT NULL,
    WorkerID INT NOT NULL,
    LineID INT NOT NULL,
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    ShortAddress VARCHAR(64),
    LongAddress VARCHAR(64),
    HostIP VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_RebundleScanID PRIMARY KEY (RebundleScanID),
    CONSTRAINT UQ_RebundleID_OperationID UNIQUE (RebundleID, OperationID),
    CONSTRAINT FK_RebundleScan_CutReport FOREIGN KEY (RebundleID) REFERENCES [Rebundle].[RebundleCutReport](RebundleID),
    CONSTRAINT FK_RebundleScan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan](WorkerScanID),
    CONSTRAINT FK_RebundleScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_RebundleScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_RebundleScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_RebundleScan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Rebundle].[RebundlePieceScan](
    RebundlePieceScanID INT IDENTITY(1, 1),
    RebundlePieceID INT NOT NULL,
    WorkerScanID INT NOT NULL,
    WorkerID INT NOT NULL,
    LineID INT NOT NULL,
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    ShortAddress VARCHAR(64),
    LongAddress VARCHAR(64),
    HostIP VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_RebundlePieceScanID PRIMARY KEY (RebundlePieceScanID),
    CONSTRAINT UQ_RebundlePieceScanID_OperationID UNIQUE (RebundlePieceID, OperationID),
    CONSTRAINT FK_RebundlePieceScan_CutReport FOREIGN KEY (RebundlePieceID) REFERENCES [Rebundle].[RebundlePieceReport](RebundlePieceID),
    CONSTRAINT FK_RebundlePieceScan_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan](WorkerScanID),
    CONSTRAINT FK_RebundlePieceScan_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker](WorkerID),
    CONSTRAINT FK_RebundlePieceScan_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_RebundlePieceScan_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine](MachineID),
    CONSTRAINT FK_RebundlePieceScan_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation](OperationID)
);

CREATE TABLE [Data].[TotalScanning](
    TotalScanningID INT IDENTITY(1, 1),
    BundleWiseScanID INT,
    PieceWiseScanID INT,
    RebundleScanID INT,
    RebundlePieceScanID INT,
    -- MachineType
    MachineTypeID INT,
    MachineTypeCode VARCHAR(64),
    MachineTypeDescription VARCHAR(64),
    -- MachineType
    -- Section
    SectionID INT,
    SectionCode VARCHAR(64),
    SectionDescription VARCHAR(64),
    -- Section
    -- Line
    LineID INT,
    LineCode VARCHAR(64),
    LineDescription VARCHAR(64),
    -- Line
    -- Worker
    WorkerID INT,
    WorkerCode VARCHAR(64),
    WorkerDescription VARCHAR(64),
    LoginTimeToday DATETIME,
    TotalPiecesToday INT,
    -- Worker
    -- SkillLevel
    SkillLevelID INT,
    SkillName VARCHAR(10),
    SkillRate FLOAT,
    -- SkillLevel
    -- Operation
    OperationID INT,
    OperationCode VARCHAR(64),
    OperationName VARCHAR(64),
    OperationDescription VARCHAR(64),
    Department VARCHAR(64),
    PieceRate FLOAT,
    OperationType VARCHAR(65),
    -- Operation
    -- Machine
    MachineID INT,
    MachineCode VARCHAR(64),
    MachineDescription VARCHAR(64),
    -- Machine
    -- WorkerScan
    WorkerScanID INT,
    -- WorkerScan
    -- StyleTemplate
    StyleTemplateID INT,
    StyleTemplateCode VARCHAR(64),
    -- StyleTemplate
    -- Sale Order
    SaleOrderID INT,
    PpcOrderNum VARCHAR(64),
    Customer VARCHAR(64),
    CustomerStyle VARCHAR(64),
    RequestCustomerPoCode VARCHAR(64),
    PoNo VARCHAR(64),
    CblPo VARCHAR(64),
    ContractCode VARCHAR(64),
    OrderNum VARCHAR(64),
    OrderQuantity INT,
    XMillDate DATE,
    FabricYield FLOAT,
    FabricStyle VARCHAR(64),
    Wash INT,
    Fabric VARCHAR(64),
    TypeFly VARCHAR(64),
    BackPocketTemplate VARCHAR(64),
    -- Sale Order
    -- Production Order
    ProductionOrderID INT,
    OrderPartID INT,
    FollowsOperationSequence BIT,
    -- Production Order
    -- Marker
    MarkerID INT,
    MarkerCode VARCHAR(64),
    -- Marker
    -- CutJob
    CutJobID INT,
    CutNo INT,
    Plies INT,
    CutQuantity INT,
    Repeats INT,
    -- CutJob
    -- CutReport
    BundleID INT NOT NULL,
    BundleCode VARCHAR(64),
    Size VARCHAR(20),
    Inseam INT,
    BundleQuantity INT,
    -- CutReport
    -- PieceWiseCutReport
    PieceID INT,
    PieceNumber INT,
    -- PieceWiseCutReport
    -- Rebundle CutReport
    RebundleID INT,
    -- Rebundle CutReport
    -- Rebundle Piece Report
    -- Rebundle Piece Report
    ShortAddress VARCHAR(64),
    LongAddress VARCHAR(64),
    HostIP VARCHAR(64),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_TotalScanningID PRIMARY KEY (TotalScanningID),
    CONSTRAINT FK_TotalScanning_PieceWiseScan FOREIGN KEY (PieceWiseScanID) REFERENCES [Data].[PieceWiseScan](PieceWiseScanID),
    CONSTRAINT FK_TotalScanning_BundleWiseScan FOREIGN KEY (BundleWiseScanID) REFERENCES [Data].[BundleWiseScan](BundleWiseScanID),
    CONSTRAINT FK_TotalScanning_RebundlePieceScan FOREIGN KEY (RebundlePieceScanID) REFERENCES [Rebundle].[RebundlePieceScan](RebundlePieceScanID),
    CONSTRAINT FK_TotalScanning_RebundleScan FOREIGN KEY (RebundleScanID) REFERENCES [Rebundle].[RebundleScan](RebundleScanID),
    CONSTRAINT FK_TotalScanning_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] ([OperationID])
);

CREATE TABLE [Essentials].[User](
    UserID INT IDENTITY(1, 1),
    UserName VARCHAR(64) NOT NULL,
    Password VARCHAR(max) NOT NULL,
    UserType VARCHAR(64) NOT NULL,
    LineID INT NOT NULL,
    SectionID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_UserID PRIMARY KEY (UserID),
    CONSTRAINT UQ_UserName UNIQUE (UserName),
    CONSTRAINT FK_User_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_User_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID)
);

CREATE TABLE [Essentials].[Module](
    ModuleID INT IDENTITY(1, 1),
    ModuleCode VARCHAR(64) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_ModuleID PRIMARY KEY (ModuleID),
    CONSTRAINT UQ_ModuleCode UNIQUE (ModuleCode)
);

CREATE TABLE [Essentials].[UserPermission](
    UserPermissionID INT IDENTITY(1, 1),
    UserID INT NOT NULL,
    ModuleID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_UserPermissionID PRIMARY KEY (UserPermissionID),
    CONSTRAINT UQ_UserPermission UNIQUE (UserID, ModuleID),
    CONSTRAINT FK_UserPermission_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User](UserID),
    CONSTRAINT FK_UserPermission_Module FOREIGN KEY (ModuleID) REFERENCES [Essentials].[Module](ModuleID)
);

CREATE TABLE [Essentials].[Tag](
    TagID INT IDENTITY(1, 1),
    BundleID INT,
    RebundleID INT,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_TagID PRIMARY KEY (TagID),
    CONSTRAINT FK_Tag_Bundle FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport](BundleID),
    CONSTRAINT FK_Tag_Rebundle FOREIGN KEY (RebundleID) REFERENCES [Rebundle].[RebundleCutReport](RebundleID)
);

CREATE TABLE [Excel].[ExcelCutReport](
    ExcelCutReportID INT IDENTITY(1, 1),
    ORDER_NUM VARCHAR(64) NOT NULL,
    MARKER_CODE CHAR(1) NOT NULL,
    REPEATS INT NOT NULL,
    BUNDLE_QTY INT NOT NULL,
    WAIST INT NOT NULL,
    DIMENSION_ONE_LKP VARCHAR(64) NOT NULL,
    INSEAM INT NOT NULL,
    MARKER_RATIO INT NOT NULL,
    QTY INT NOT NULL,
    BUNDLE_QTY_1 INT NOT NULL,
    BUNDLE_NO INT NOT NULL,
    PARENT_ORDER_PART_ID INT NOT NULL,
    CONSTRAINT PK_ExcelCutReportID PRIMARY KEY (ExcelCutReportID)
);

CREATE TABLE [Excel].[ExcelOrder](
    ExcelOrderID INT IDENTITY(1, 1),
    CUSTOMER VARCHAR(64),
    REQUESTED_CUSTOMER_PO_CODE VARCHAR(64),
    PO_NO VARCHAR(64) NOT NULL,
    CBL_PO VARCHAR(64) NOT NULL,
    CONTRACT_CODE VARCHAR(64),
    ORDER_NUM VARCHAR(64) NOT NULL,
    ORDERED_QTY INT NOT NULL,
    XMILL_DATE VARCHAR(50),
    FABRIC_YIELD FLOAT,
    FABRIC VARCHAR(64),
    FAB_STYLE VARCHAR(64),
    CUST_STYLE VARCHAR(64),
    CBL_STYLE VARCHAR(64),
    WASH INT,
    PLIES INT NOT NULL,
    TYPE_FLY VARCHAR(64),
    BACK_POCKET_TEMPLATE VARCHAR(64),
    MARKER_CODE CHAR(1) NOT NULL,
    REPEATS INT NOT NULL,
    WAIST INT NOT NULL,
    INSEAM INT NOT NULL,
    MARKER_RATIO INT NOT NULL,
    QTY INT NOT NULL,
    CUT_SIZE INT NOT NULL,
    CUT_NO INT NOT NULL,
    PPC_ORDER_NUM VARCHAR(64) NOT NULL,
    ORDER_PART_ID INT NOT NULL,
    CONSTRAINT PK_ExcelOrderID PRIMARY KEY (ExcelOrderID)
);

CREATE TABLE [Essentials].[AppVersion](
    AppVersionID INT IDENTITY(1, 1),
    Version VARCHAR(5) NOT NULL,
    Address VARCHAR(64) NOT NULL,
    AppType VARCHAR(24) NOT NULL,
    CONSTRAINT PK_AppVersionID PRIMARY KEY(AppVersionID)
);

Insert Into
    Essentials.AppVersion
Values
    (
        '1.0',
        'http://172.16.1.83/APKS/SQMS/CBL_SQMS.apk',
        'CBL_SQMS'
    );

Insert Into
    Essentials.Module(ModuleCode)
values
    ('7/0 AUDIT FORM'),
    ('ENDLINE'),
    ('INLINE'),
    ('CARD MANAGER');

Insert Into
    Essentials.Section(SectionCode, SectionDescription)
values
    ('testSectionCode', 'testSectionDescription');

Insert Into
    Essentials.Line(LineCode, LineDescription)
values
    ('testLineCode', 'testLineDescription');

ALTER TABLE
    [Essentials].[PieceWiseCutReport]
Alter COLUMN
    [BundleID] INT;

ALTER TABLE
    [Essentials].[PieceWiseCutReport]
ADD
    [RebundleID] INT CONSTRAINT FK_PieceWiseCutReport_RebundleCutReport FOREIGN KEY (RebundleID) REFERENCES [Rebundle].[RebundleCutReport](RebundleID);

ALTER TABLE
    [Rebundle].[RebundlePieceScan] DROP CONSTRAINT IF EXISTS FK_RebundlePieceScan_CutReport;

ALTER TABLE
    [Rebundle].[RebundlePieceScan]
ALTER COLUMN
    RebundlePieceID INT;

ALTER TABLE
    [Rebundle].[RebundlePieceScan]
ADD
    CONSTRAINT FK_RebundlePieceScan_CutReport FOREIGN KEY (RebundlePieceID) REFERENCES [Essentials].[PieceWiseCutReport](PieceID);

DROP TABLE IF EXISTS [Rebundle].[RebundlePieceReport];

ALTER TABLE
    [Essentials].[SaleOrder]
ALTER COLUMN
    Wash VARCHAR(64) NOT NULL;

ALTER TABLE
    [Excel].[ExcelOrder]
ALTER COLUMN
    Wash VARCHAR(64) NOT NULL;

ALTER TABLE
    [Data].[TotalScanning]
ALTER COLUMN
    Wash VARCHAR(64);

ALTER TABLE
    [Essentials].[StyleBulletin]
ALTER COLUMN
    BasicMinutes FLOAT;

CREATE TABLE [Essentials].[PieceWiseCutReportPrint](
    PiecePrintID INT IDENTITY(1, 1),
    PieceID INT NOT NULL,
    BundleID INT NOT NULL,
    PieceNumber INT NOT NULL,
    PieceQRCode VARCHAR(20) NOT NULL,
    -- Sale Order
    SaleOrderID INT,
    PpcOrderNum VARCHAR(64),
    Customer VARCHAR(64),
    CustomerStyle VARCHAR(64),
    RequestCustomerPoCode VARCHAR(64),
    PoNo VARCHAR(64),
    CblPo VARCHAR(64),
    ContractCode VARCHAR(64),
    OrderNum VARCHAR(64),
    OrderQuantity INT,
    XMillDate DATE,
    FabricYield FLOAT,
    FabricStyle VARCHAR(64),
    Wash INT,
    Fabric VARCHAR(64),
    TypeFly VARCHAR(64),
    BackPocketTemplate VARCHAR(64),
    -- Sale Order
    -- Production Order
    ProductionOrderID INT,
    FollowsOperationSequence BIT,
    -- Production Order
    -- Marker
    MarkerID INT,
    MarkerCode VARCHAR(64),
    -- Marker
    -- CutJob
    CutJobID INT,
    CutNo INT,
    Plies INT,
    CutQuantity INT,
    Repeats INT,
    -- CutJob
    -- CutReport
    BundleCode VARCHAR(64),
    Size VARCHAR(20),
    Inseam INT,
    BundleQuantity INT,
    DimensionOneLKP VARCHAR(64),
    -- CutReport
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_PiecePrintID PRIMARY KEY (PiecePrintID)
);

CREATE TABLE [Essentials].[CutReportPrint](
    BundlePrintID INT IDENTITY(1, 1),
    BundleID INT NOT NULL,
    BundleCode VARCHAR(64) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    Inseam VARCHAR(64) NOT NULL,
    BundleQuantity INT NOT NULL,
    DimensionOneLKP VARCHAR(64) NOT NULL,
    CutJobID INT NOT NULL,
     -- Sale Order
    SaleOrderID INT,
    PpcOrderNum VARCHAR(64),
    Customer VARCHAR(64),
    CustomerStyle VARCHAR(64),
    RequestCustomerPoCode VARCHAR(64),
    PoNo VARCHAR(64),
    CblPo VARCHAR(64),
    ContractCode VARCHAR(64),
    OrderNum VARCHAR(64),
    OrderQuantity INT,
    XMillDate DATE,
    FabricYield FLOAT,
    FabricStyle VARCHAR(64),
    Wash INT,
    Fabric VARCHAR(64),
    TypeFly VARCHAR(64),
    BackPocketTemplate VARCHAR(64),
    -- Sale Order
    -- Production Order
    ProductionOrderID INT,
    FollowsOperationSequence BIT,
    -- Production Order
    -- Marker
    MarkerID INT,
    MarkerCode VARCHAR(64),
    -- Marker
    -- CutJob
    CutNo INT,
    Plies INT,
    CutQuantity INT,
    Repeats INT,
    -- CutJob
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_BundlePrintID PRIMARY KEY (BundlePrintID)
);

CREATE TABLE [Essentials].[Fault](
    FaultID INT IDENTITY(1, 1),
    FaultCode VARCHAR(64) NOT NULL,
    FaultDescription VARCHAR(256) NOT NULL,
    SectionID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_FaultID PRIMARY KEY (FaultID),
    CONSTRAINT UK_FaultCode_SectionID UNIQUE(FaultCode, SectionID),
    CONSTRAINT FK_Fault_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID)
);

CREATE TABLE [Data].[InlineSession](
    InlineSessionID INT IDENTITY(1, 1),
    DefectedPieces INT NOT NULL,
    RoundColor VARCHAR(64) NOT NULL,
    WorkerID INT NOT NULL,
    WorkerCode VARCHAR(64),
    WorkerDescription VARCHAR(64),
    OperationID INT NOT NULL,
    OperationCode VARCHAR(64),
    OperationName VARCHAR(64),
    OperationDescription VARCHAR(64),
    Department VARCHAR(64),
    PieceRate FLOAT,
    OperationType VARCHAR(65),
    UserID INT NOT NULL,
    UserName VARCHAR(64),
    UserType VARCHAR(64),
    LineID INT NOT NULL,
    LineCode VARCHAR(64),
    LineDescription VARCHAR(64),
    SectionID INT NOT NULL,
    SectionCode VARCHAR(64),
    SectionDescription VARCHAR(64),
    MachineID INT NOT NULL,
    MachineCode VARCHAR(64),
    MachineDescription VARCHAR(64),
    MachineRound INT NOT NULL,
    CreatedAtDate Date NOT NULL DEFAULT GETDATE(),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_InlineSessionID PRIMARY KEY (InlineSessionID),
    CONSTRAINT UQ_MachineID_MachineRound_CreatedAtDate UNIQUE(MachineID, MachineRound, CreatedAtDate),
    CONSTRAINT FK_InlineSession_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
    CONSTRAINT FK_InlineSession_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
    CONSTRAINT FK_InlineSession_User FOREIGN KEY (UserID) REFERENCES [Essentials].[User] (UserID),
    CONSTRAINT FK_InlineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line] (LineID),
    CONSTRAINT FK_InlineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section] (SectionID),
    CONSTRAINT FK_InlineSession_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[Machine] (MachineID)
);

CREATE TABLE [Essentials].[CheckList](
    CheckListID INT IDENTITY(1, 1),
    CheckListDescription VARCHAR(64) NOT NULL,
    Response VARCHAR(64) NOT NULL,
    ResponseScore INT NOT NULL,
    ModuleID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_CheckListID PRIMARY KEY(CheckListID),
    CONSTRAINT FK_CheckList_Module FOREIGN KEY (ModuleID) REFERENCES [Essentials].[Module](ModuleID)
);

CREATE TABLE [Data].[CheckListResponseLog](
    CheckListResponseLogID INT IDENTITY(1, 1),
    CheckListID INT NOT NULL,
    CheckListDescription VARCHAR(64),
    Response VARCHAR(64),
    ResponseScore INT,
    InlineSessionID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_CheckListResponseLogID PRIMARY KEY (CheckListResponseLogID),
    CONSTRAINT FK_CheckListResponseLog_CheckList FOREIGN KEY (CheckListID) REFERENCES [Essentials].[CheckList](CheckListID),
    CONSTRAINT FK_CheckListResponse_InlineSession FOREIGN KEY (InlineSessionID) REFERENCES [Data].[InlineSession](InlineSessionID)
);

CREATE TABLE [Data].[InlineFaultLog](
    InlineFaultLogID INT IDENTITY(1, 1),
    FaultCount INT NOT NULL,
    InlineSessionID INT NOT NULL,
    FaultID INT NOT NULL,
    FaultCode VARCHAR(64),
    FaultDescription VARCHAR(256),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_InlineFaultLog PRIMARY KEY(InlineFaultLogID),
    CONSTRAINT FK_InlineFaultLog_FaultID FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault](FaultID),
    CONSTRAINT FK_InlineFaultLog_InlineSession FOREIGN KEY (InlineSessionID) REFERENCES [Data].[InlineSession](InlineSessionID)
);

CREATE TABLE [Data].[EndLineSession](
    EndLineSessionID INT IDENTITY(1, 1),
    DefectedPieces INT NOT NULL,
    RejectedPieces INT NOT NULL,
    CheckedPieces INT NOT NULL,
    IsPieceScan BIT NOT NULL,
    LineID INT NOT NULL,
    LineCode VARCHAR(64),
    LineDescription VARCHAR(64),
    BundleID INT NOT NULL,
    BundleCode VARCHAR(64),
    ReworkState INT NOT NULL,
    SectionID INT NOT NULL,
    SectionCode VARCHAR(64),
    SectionDescription VARCHAR(64),
    UserID INT NOT NULL,
    CreatedAtDate DATE NOT NULL DEFAULT GETDATE(),
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_EndLineSessionID PRIMARY KEY(EndLineSessionID),
    CONSTRAINT UQ_BundleID_ReworkState_SectionID UNIQUE(BundleID, ReworkState, SectionID),
    CONSTRAINT FK_EndLineSession_User FOREIGN KEY(UserID) REFERENCES [Essentials].[User],
    CONSTRAINT FK_EndLineSession_Line FOREIGN KEY (LineID) REFERENCES [Essentials].[Line](LineID),
    CONSTRAINT FK_EndLineSession_CutReport FOREIGN KEY (BundleID) REFERENCES [Essentials].[CutReport](BundleID),
    CONSTRAINT FK_EndLineSession_Section FOREIGN KEY (SectionID) REFERENCES [Essentials].[Section](SectionID)
);


CREATE TABLE [Data].[EndLineFaultLog](
    EndLineFaultLogID INT IDENTITY(1, 1),
    FaultCount INT NOT NULL,
    EndLineSessionID INT NOT NULL,
    FaultID INT NOT NULL,
    FaultCode VARCHAR(64),
    FaultDescription VARCHAR(256),
    PieceID INT,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_EndLineFaultLogID PRIMARY KEY (EndLineFaultLogID),
    CONSTRAINT FK_EndLineFaultLog_EndLineSession FOREIGN KEY (EndLineSessionID) REFERENCES [Data].[EndLineSession](EndLineSessionID),
    CONSTRAINT FK_EndLineFaultLog_Fault FOREIGN KEY (FaultID) REFERENCES [Essentials].[Fault](FaultID)
);

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    CONSTRAINT FK_EndLineFaultLog_PieceWiseCutReport FOREIGN KEY (PieceID) REFERENCES [Essentials].[PieceWiseCutReport](PieceID);

ALTER TABLE
    [Essentials].[CutReport]
ADD
    IsQualityChecked BIT NOT NULL DEFAULT 0;

ALTER TABLE
    [Essentials].[PieceWiseCutReport]
ADD
    IsPieceQualityChecked BIT NOT NULL DEFAULT 0;

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    TotalScanningID INT CONSTRAINT FK_EndLineFaultLog_TotalScanning FOREIGN KEY (TotalScanningID) REFERENCES [Data].[TotalScanning] (TotalScanningID);

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    IsRework BIT;

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    IsRejected BIT;

Insert Into
    Essentials.CheckList(
        [Response],
        [ResponseScore],
        [CheckListDescription],
        [CreatedAt],
        [UpdatedAt],
        [ModuleID]
    )
Values
    (
        'Ok',
        '-1',
        'MACHINE CALIBRATION',
        GETDATE(),
        GETDATE(),
        3
    ),
    (
        'Not Ok',
        '-1',
        'MACHINE CALIBRATION',
        GETDATE(),
        GETDATE(),
        3
    ),
    (
        'N/A',
        '-1',
        'MACHINE CALIBRATION',
        GETDATE(),
        GETDATE(),
        3
    ),
    ('Ok', '-1', 'SPI', GETDATE(), GETDATE(), 3),
    ('Not Ok', '-1', 'SPI', GETDATE(), GETDATE(), 3),
    ('N/A', '-1', 'SPI', GETDATE(), GETDATE(), 3),
    ('Ok', '-1', 'GAUGE', GETDATE(), GETDATE(), 3),
    ('Not Ok', '-1', 'GAUGE', GETDATE(), GETDATE(), 3),
    ('N/A', '-1', 'GAUGE', GETDATE(), GETDATE(), 3),
    (
        'Ok',
        '-1',
        'FINAL CHECK',
        GETDATE(),
        GETDATE(),
        3
    ),
    (
        'Not Ok',
        '-1',
        'FINAL CHECK',
        GETDATE(),
        GETDATE(),
        3
    ),
    (
        'N/A',
        '-1',
        'FINAL CHECK',
        GETDATE(),
        GETDATE(),
        3
    );

ALTER TABLE
    [Data].[EndLineFaultLog] DROP CONSTRAINT IF EXISTS FK_EndLineFaultLog_TotalScanning;

ALTER TABLE
    [Data].[EndLineFaultLog] DROP COLUMN TotalScanningID;

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    BundleWiseScanID INT CONSTRAINT FK_EndLineFaultLog_BundleWiseScan FOREIGN KEY (BundleWiseScanID) REFERENCES [Data].[BundleWiseScan](BundleWiseScanID);

ALTER TABLE
    [Data].[EndLineFaultLog]
ADD
    PieceWiseScanID INT CONSTRAINT FK_EndLineFaultLog_PieceWiseScan FOREIGN KEY (PieceWiseScanID) REFERENCES [Data].[PieceWiseScan](PieceWiseScanID);

ALTER TABLE
    Essentials.Operation DROP CONSTRAINT CK_Operation_Department;

ALTER TABLE
    Essentials.Operation
ADD
    CONSTRAINT CK_Operation_Department CHECK(Department In ('PreWash', 'PostWash', 'Washing'));

INSERT INTO
    Essentials.Section(SectionCode, SectionDescription)
Values
    ('W-0', 'Washing');

INSERT INTO
    Essentials.SkillLevel(SkillName, SkillRate)
values
    ('Washing', 0.0);

INSERT INTO
    Essentials.Operation(
        OperationCode,
        OperationName,
        OperationDescription,
        Department,
        OperationType,
        SkillLevelID,
        SectionID
    )
Values
    (
        'W-0',
        'Washing',
        'Washing',
        'Washing',
        'Manual',
        7,
        62
    );

sp_rename 'Essentials.ProductionOrder.OrderPartID',
'PpcOrderNum',
'COLUMN';

ALTER TABLE
    [Data].[TotalScanning] DROP COLUMN OrderPartID;

ALTER TABLE [Data].[InlineSession]
ADD FollowUp INT NOT NULL DEFAULT 0;

ALTER TABLE [Data].[InlineSession] 
ADD  CONSTRAINT [UQ_MachineID_MachineRound_CreatedAtDate_FollowUp]
UNIQUE NONCLUSTERED 
([MachineID] ASC,[MachineRound] ASC,[CreatedAtDate] ASC,[FollowUp] ASC)

-- Change inseam to varchar

ALTER TABLE [Essentials].[SaleOrder]
ADD CBLStyle VARCHAR(64);

ALTER TABLE [Essentials].[CutReportPrint]
ADD CBLStyle VARCHAR(64);

ALTER TABLE [Essentials].[PieceWiseCutReportPrint]
ADD CBLStyle VARCHAR(64);

ALTER TABLE [Essentials].[CutReportPrint]
ADD LotNum VARCHAR(64);

ALTER TABLE [Essentials].[CutReportPrint]
ADD SeqNum VARCHAR(64);

ALTER TABLE [Essentials].[PieceWiseCutReportPrint]
ADD LotNum VARCHAR(64);

ALTER TABLE [Essentials].[PieceWiseCutReportPrint]
ADD SeqNum VARCHAR(64);

-- wash changed on server done

CREATE TABLE [Essentials].[Lot](
    LotID INT IDENTITY(1,1),
    Weight FLOAT NOT NULL,
    TotalBundles INT NOT NULL,
    TotalPieces INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LotID
        PRIMARY KEY (LotID)
);

CREATE TABLE [Data].[LotBundles](
    LotBundlesID INT IDENTITY(1,1),
    PieceID INT NOT NULL,
    PieceNumber INT NOT NULL,
    BundleID INT NOT NULL,
    BundleCode VARCHAR(64) NOT NULL,
    BundleQuantity INT NOT NULL,
    CutJobID INT NOT NULL,
    CutNo INT NOT NULL,
    PpcOrderNum VARCHAR(64) NOT NULL,
    Size VARCHAR(20) NOT NULL,
    LotType VARCHAR(20) NOT NULL CHECK(LotType In ('BundleWise','PieceWise')),
    LotID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_LotBundleID
        PRIMARY KEY (LotBundlesID),
    CONSTRAINT FK_LotBundles_CutReportPiece
        FOREIGN KEY (PieceID)
        REFERENCES [Essentials].[PieceWiseCutReport] (PieceID),
    CONSTRAINT FK_LotBundles_Bundle
        FOREIGN KEY (BundleID)
        REFERENCES [Essentials].[CutReport] (BundleID),
    CONSTRAINT FK_LotBundles_CutJob
        FOREIGN KEY (CutJobID)
        REFERENCES [Essentials].[CutJob] (CutJobID),
    CONSTRAINT FK_LotBundles_Lot
        FOREIGN KEY (LotID)
        REFERENCES [Essentials].[Lot] (LotID)
);

-- changed totalscanning id on production in data.endlinefaultlog 29/12/2021
-- pending
ALTER TABLE Essentials.CutReport
ADD TagID INT
CONSTRAINT FK_CutReport_Tag FOREIGN KEY(TagID) REFERENCES Essentials.Tag;

ALTER TABLE Essentials.Worker
ADD LastBundle VARCHAR(64);
