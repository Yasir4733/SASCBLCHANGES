USE [SooperWizer];
GO

ALTER TABLE [Essentials].[ProductionOrder]
ADD IsPoClosed BIT NOT NULL DEFAULT 0;
GO

CREATE TABLE [Essentials].[DownReason](
DownReasonID INT IDENTITY(1,1) NOT NULL,
Reason VARCHAR(64) NOT NULL,
CONSTRAINT PK_DownReason PRIMARY KEY (DownReasonID));
GO

CREATE TABLE [Data].[MachineDownTime](
MachineDownTimeID INT IDENTITY(1,1) NOT NULL,
LineID INT NOT NULL,
LineCode VARCHAR(64) NOT NULL,
MachineID INT NOT NULL,
MachineCode VARCHAR(64) NOT NULL,
MachineDescription nVARCHAR(64) NOT NULL,
WorkerID INT NOT NULL,
WorkerCode VARCHAR(64) NOT NULL,
WorkerName VARCHAR(64) NOT NULL,
DownReasonID INT NOT NULL,
Reason VARCHAR(64) NOT NULL,
Remarks VARCHAR(255) NOT NULL,
IsDown BIT NOT NULL DEFAULT 1,
StartDownTime DATETIME NOT NULL DEFAULT GETDATE(),
EndDownTime DATETIME NULL,
CONSTRAINT PK_MachineDownTime PRIMARY KEY (MachineDownTimeID),
CONSTRAINT FK_MachineDownTime_DownReason FOREIGN KEY(DownReasonID) REFERENCES [Essentials].[DownReason] (DownReasonID),
CONSTRAINT FK_MachineDownTime_Line FOREIGN KEY(LineID) REFERENCES [Essentials].[Line] (LineID),
CONSTRAINT FK_MachineDownTime_Machine FOREIGN KEY(MachineID) REFERENCES [Essentials].[Machine] (MachineID),
CONSTRAINT FK_MachineDownTime_Worker FOREIGN KEY(WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
 );
 GO
