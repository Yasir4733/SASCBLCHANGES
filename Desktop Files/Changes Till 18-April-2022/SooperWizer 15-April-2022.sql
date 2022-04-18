-- LOCAL 
-- AHSAN BHAI

USE [SooperWizer];
GO

ALTER TABLE [Essentials].[LineLayoutOperationMachines]
ADD
WorkerID INT NOT NULL,
OperationID INT NOT NULL,
CONSTRAINT FK_LineLayoutOperationMachines_Operation FOREIGN KEY(OperationID) REFERENCES [Essentials].[Operation] (OperationID),
CONSTRAINT FK_LineLayoutOperationMachines_Worker FOREIGN KEY(WorkerID) REFERENCES [Essentials].[Worker] (WorkerID)
;