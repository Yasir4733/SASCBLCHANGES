--  Check Owner of Database

-- -- SELECT suser_sname(owner_sid) FROM sys.databases WHERE NAME  = 'CBL'
-- -- SELECT suser_sname(owner_sid ), * FROM sys.databases

-- Change Owner Of Database

-- -- USE [TestCDC];
-- -- GO
-- -- EXEC sp_changedbowner 'admin'
-- -- GO

---- Create  Database
--CREATE DATABASE TestCDC;
--GO


--USE [TestCDC];
--GO

---- Create Schema
--CREATE SCHEMA [Test];
--GO

---- Create Table
--CREATE TABLE [Test].[User](
--	UserID INT NOT NULL IDENTITY(1,1),
--	FirstName VARCHAR(32) NOT NULL,
--	LastName VARCHAR(32) NOT NULL,
--	EmailAddress VARCHAR(64) NOT NULL,
--	CONSTRAINT PK_User PRIMARY KEY(UserID)
--	);

---- Create Table
--CREATE TABLE [Test].[Employee](
--	EmployeeID INT NOT NULL IDENTITY(1,1),
--	FirstName VARCHAR(32) NOT NULL,
--	LastName VARCHAR(32) NOT NULL,
--	EmailAddress VARCHAR(64) NOT NULL,
--	CONSTRAINT PK_Employee PRIMARY KEY(EmployeeID)
--	);



---- [Test].[User]
--DECLARE @ID INT;
--SET @ID =1;

--WHILE @ID<=100
--BEGIN
--    INSERT INTO [Test].[User](FirstName,LastName,EmailAddress)
--    VALUES('FirstName-'+CAST(@ID AS VARCHAR(10)),'LastName-'+CAST(@ID AS VARCHAR(10)),'User'+CAST(@ID AS VARCHAR(10))+'@gmail.com');
--    PRINT @ID;
--    SET @ID = @ID+1;
--END

--SELECT * FROM [Test].[User];


---- [Test].[Employee]
--DECLARE @ID INT;
--SET @ID =1;

--WHILE @ID<=100
--BEGIN
--    INSERT INTO [Test].[Employee](FirstName,LastName,EmailAddress)
--    VALUES('FirstName-'+CAST(@ID AS VARCHAR(10)),'LastName-'+CAST(@ID AS VARCHAR(10)),'Employee'+CAST(@ID AS VARCHAR(10))+'@gmail.com');
--    PRINT @ID;
--    SET @ID = @ID+1;
--END

--SELECT * FROM [Test].[Employee];


-- ====  
-- Enable Database for CDC template
-- Enable For Entire Database
-- ====  

USE [TestCDC] 
GO  
EXEC sys.sp_cdc_enable_db  
GO

-- Check That CDC is Enabled ON The Database

SELECT name, is_cdc_enabled
FROM sys.databases WHERE database_id = DB_ID();



-- =========  
-- Enable a Table Specifying Filegroup Option Template  
-- =========  
USE [TestCDC]  
GO  
  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'Test',  
@source_name   = N'User',  
@role_name     = NULL,  
@filegroup_name = NULL,  
@supports_net_changes = 1  
GO 




SELECT * FROM [Test].[User];

UPDATE [Test].[User]
SET EmailAddress = 'Changed@change.com'
WHERE UserID = 102;

DELETE FROM [Test].[User]
WHERE UserID = 101;


INSERT INTO [Test].[User](FirstName,LastName,EmailAddress)
VALUES('FirstName-102','LastName-102','NewEmail@test.com')

SELECT * FROM [cdc].[Test_User_CT] 
GO




-- =========  
-- Disable For Table
-- Disable a Table Specifying Filegroup Option Template  
-- =========  
USE [TestCDC]  
GO  
  
EXEC sys.sp_cdc_disable_table  
@source_schema = N'Test',  
@source_name   = N'User',
@capture_instance = N'Test_User'
GO 


-- ====  
-- Disable Database for CDC template
-- Disable For Entire Database
-- ====  

USE [TestCDC] 
GO  
EXEC sys.sp_cdc_disable_db  
GO

-- Check That CDC is Enabled ON The Database

SELECT name, is_cdc_enabled
FROM sys.databases WHERE database_id = DB_ID();






ALTER TABLE [Data].[WorkerOperations] 
DROP
CONSTRAINT FK_WorkerOperations_WorkerScan
GO

ALTER TABLE [Data].[WorkerOperations]
ALTER COLUMN WorkerScanID BIGINT;

ALTER TABLE [Data].[WorkerOperations] 
ADD
   CONSTRAINT FK_WorkerOperations_WorkerScan  
   FOREIGN KEY (WorkerScanID) REFERENCES [Data].[WorkerScan] (WorkerScanID)
   ON DELETE SET NULL;



-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------


USE [SooperWizerRT] 
GO  
EXEC sys.sp_cdc_enable_db  
GO

-- Check That CDC is Enabled ON The Database

SELECT name, is_cdc_enabled
FROM sys.databases WHERE database_id = DB_ID();



-- =========  
-- Enable a Table Specifying Filegroup Option Template  
--[Essentials].[StyleBulletin]
--[Essentials].[PieceWiseCutReport]
--[Data].[PieceWiseScan]
--[Data].[WorkerScan]
-- =========  
USE [SooperWizerRT]  
GO  
  
EXEC sys.sp_cdc_enable_table  
@source_schema = N'Essentials',  
@source_name   = N'StyleBulletin',  
@role_name     = NULL,  
@filegroup_name = NULL,  
@supports_net_changes = 1  
GO 


EXEC sys.sp_cdc_enable_table  
@source_schema = N'Data',  
@source_name   = N'WorkerScan',  
@role_name     = NULL,  
@filegroup_name = NULL,  
@supports_net_changes = 1  
GO 

EXEC sys.sp_cdc_enable_table  
@source_schema = N'Essentials',  
@source_name   = N'PieceWiseCutReport',  
@role_name     = NULL,  
@filegroup_name = NULL,  
@supports_net_changes = 1  
GO 

EXEC sys.sp_cdc_enable_table  
@source_schema = N'Data',  
@source_name   = N'PieceWiseScan',  
@role_name     = NULL,  
@filegroup_name = NULL,  
@supports_net_changes = 1  
GO 

