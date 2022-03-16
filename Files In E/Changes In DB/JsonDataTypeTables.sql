CREATE TABLE  [Essentials].[AllocatedMachines]( 
    AllocatedMachinesID INT NOT NULL IDENTITY(1,1),
    WorkerID INT NOT NULL,
    MachineID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_AllocatedMachinesID PRIMARY KEY (AllocatedMachinesID),
    CONSTRAINT FK_AllocatedMachines_Worker FOREIGN KEY (WorkerID) REFERENCES [Essentials].[Worker] (WorkerID),
    CONSTRAINT FK_AllocatedMachines_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[MachineID] (MachineID)
);

CREATE TABLE  [Essentials].[MachineOperations](
    MachineOperationsID INT NOT NULL IDENTITY(1,1),
    MachineID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MachineOperationsID PRIMARY KEY (MachineOperationsID),
    CONSTRAINT FK_MachineOperations_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
    CONSTRAINT FK_MachineOperations_Machine FOREIGN KEY (MachineID) REFERENCES [Essentials].[MachineID] (MachineID)    
);


CREATE TABLE [Data].[WorkerOperations](
    WorkerOperationsID INT NOT NULL IDENTITY(1,1),
    WorkerScanID INT NOT NULL,
    OperationID INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_WorkerOperationsID PRIMARY KEY (WorkerOperationsID),
    CONSTRAINT FK_WorkerOperations_Operation FOREIGN KEY (OperationID) REFERENCES [Essentials].[Operation] (OperationID),
    CONSTRAINT FK_WorkerOperations_WorkerScan FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan] (WorkerScanID)   
);


CREATE TABLE [Essentials].[MarkerMapping](
    MarkerMappingID INT NOT NULL IDENTITY(1,1),
    MarkerID INT NOT NULL,
    Size INT NOT NULL,
    Ratio INT NOT NULL,
    Inseam NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_MarkerMappingID PRIMARY KEY (MarkerMappingID),
    CONSTRAINT FK_MarkerMappingID_Marker FOREIGN KEY (MarkerID) REFERENCES [Essentials].[Marker](MarkerID)

);


