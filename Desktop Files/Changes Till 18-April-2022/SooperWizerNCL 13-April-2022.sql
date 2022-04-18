--  Ahsan Bhai
USE [SooperWizerNCL]
GO

ALTER TABLE [Essentials].[SaleOrder]
ADD 
BuyMonth VARCHAR(8) NOT NULL,
Buyer VARCHAR(30), 
WOClose BIT,
StyleNo VARCHAR(15);
GO


ALTER TABLE [Essentials].[ProductionOrder]
ADD
Season VARCHAR(10),
OldPO VARCHAR(15),
POClose BIT,
POCloseDate SMALLDATETIME ;
GO

ALTER TABLE [Essentials].[ProductionOrderClient]
ADD
OrderQty DECIMAL(9,0);
GO

ALTER TABLE [Essentials].[Machine]
ADD
BarCode CHAR(5) NOT NULL,
CompanyID CHAR(10) NOT NULL,
MachineFileNo CHAR(13) NOT NULL,
SerialNo VARCHAR(100),
MachineBrand VARCHAR(100),
MachineModel VARCHAR(50),
MachineLoc VARCHAR(50);
GO

