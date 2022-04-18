--  Ahsan Bhai
USE [SooperWizerNCL]
GO

ALTER TABLE [Essentials].[SaleOrder]
ADD 
OrID VARCHAR(30),
BuyMonth VARCAHR(8) NOT NULL,
Buyer VARCHAR(30), 
WOClose BIT,
StyleNo VARCHAR(15)
;
GO


ALTER TABLE [Essentials].[ProductionOrder]
ADD
PO VARCHAR(15),
Season VARCHAR(10),
OldPO VARCHAR(15),
POClose BIT,
POCloseDate SMALLDATETIME 
;
GO


ALTER TABLE [Essentials].[ProductionOrderClient]
ADD
ColorDesc VARCHAR(30),
ItemSize VARCHAR(10),
OrderQty DECIMAL(9,0)
;
GO


ALTER TABLE [Essentials].[Machine]
ADD
BarCode CHAR(5) NOT NULL,
Company_ID CHAR(10) NOT NULL,
Machine_Fileno CHAR(13) NOT NULL,
Serial_No NVARCHAR(100),
Machine_Brand NVARCHAR(100),
Machine_Model NVARCHAR(50),
Machine_Loc NVARCHAR(50)
;


