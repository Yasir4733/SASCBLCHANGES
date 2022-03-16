---- Changes in SooperWizer
USE [SooperWizer];

ALTER TABLE [Essentials].[Worker]
ADD 
TodayCheckin DATETIME DEFAULT NULL,
TodayProduction INT DEFAULT NULL;


ALTER TABLE [Essentials].[Box]
ADD 
CurrentAddress INT NOT NULL DEFAULT 0;

CREATE TABLE [Essentials].[Department] (
 DepartmentID INT NOT NULL IDENTITY(1,1),
 DepartmentName VARCHAR(40) NOT NULL,
 CreatedAt DATETIME DEFAULT GETDATE(),
 UpdatedAt DATETIME DEFAULT GETDATE(),
 CONSTRAINT UQ_Department_DepartmentName UNIQUE(DepartmentName),
 CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

ALTER TABLE [Essentials].[Operation]
DROP COLUMN Department;

ALTER TABLE [Essentials].[Operation]
ADD 
DepartmentID INT,
SMV FLOAT DEFAULT NULL,
CONSTRAINT FK_operation_department FOREIGN KEY (DepartmentID) REFERENCES [Essentials].[Department] (DepartmentID),
CONSTRAINT CK_Operation_OperationType CHECK ((OperationType in ('Manual','Machine')));


ALTER TABLE [Essentials].[StyleBulletin]
ADD 
SMV FLOAT DEFAULT NULL,
PieceRate FLOAT DEFAULT NULL,
IsCritical BIT NOT NULL DEFAULT 0;

ALTER TABLE [Essentials].[Machine]
ADD 
CONSTRAINT FK_Machine_Box FOREIGN KEY (BoxID) REFERENCES [Essentials].[Box] (BoxID);

ALTER TABLE [Essentials].[Machine]
ADD
  CONSTRAINT UQ_Machine_Box UNIQUE (BoxID);

ALTER TABLE [Data].[WorkerScan]
ADD 
Extras VARCHAR(64) DEFAULT NULL;


ALTER TABLE [Essentials].[PieceWiseCutReport]
ADD 
StyleTemplateID INT DEFAULT NULL ,
CONSTRAINT FK_PieceWiseCutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);



ALTER TABLE [Essentials].[StyleTemplate]
DROP CONSTRAINT UQ_StyleTemplateCode;


ALTER TABLE [Essentials].[StyleTemplate]
ADD CONSTRAINT UQ_StyleTemplateCode_ParentStyleTemplate
UNIQUE(StyleTemplateCode,ParentStyleTemplateID);
  





--ALTER TABLE [Essentials].[PieceWiseCutReport]
--ADD 
--StyleTemplateID INT DEFAULT NULL ,
--CONSTRAINT FK_PieceWiseCutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);


--ALTER TABLE [Essentials].[StyleBulletin]
--DROP COLUMN IsCritical;

--ALTER TABLE [Essentials].[StyleBulletin]
--ADD IsCritical BIT NOT NULL DEFAULT 0;



-- ALTER TABLE [Essentials].[PieceWiseCutReport]
-- ADD 
-- StyleTemplateID INT DEFAULT NULL ,
-- CONSTRAINT FK_PieceWiseCutReport_StyleTemplate FOREIGN KEY(StyleTemplateID) REFERENCES [Essentials].[StyleTemplate](StyleTemplateID);



--   INSERT INTO [Essentials].[Department](DepartmentName)
--   VALUES('PreWash');

--   update [Essentials].[Operation]
--   SET DepartmentID = 1
--   WHERE OperationID >=1;

-- THEN SET DepartmentID TO NOT NULL IN Operation TABLE
-- ===============================================================================
-- ===============================================================================

-- SooperWizer

USE [SooperWizer];

ALTER TABLE [Essentials].[Worker]
ADD 
TodayCheckin DATETIME DEFAULT NULL,
TodayProduction INT DEFAULT NULL;


ALTER TABLE [Essentials].[Box]
ADD 
CurrentAddress INT NOT NULL DEFAULT 0;


CREATE TABLE [Essentials].[Department] (
 DepartmentID INT NOT NULL IDENTITY(1,1),
 DepartmentName VARCHAR(40) NOT NULL,
 CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
 UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),
 CONSTRAINT UQ_Department_DepartmentName UNIQUE(DepartmentName),
 CONSTRAINT PK_Department PRIMARY KEY (DepartmentID)
);

ALTER TABLE [Essentials].[Operation]
DROP COLUMN Department;

ALTER TABLE [Essentials].[Operation]
ADD 
DepartmentID INT,
SMV FLOAT DEFAULT NULL,
CONSTRAINT FK_Operation_Department FOREIGN KEY (DepartmentID) REFERENCES [Essentials].[Department] (DepartmentID),
CONSTRAINT CK_Operation_OperationType CHECK ((OperationType in ('Manual','Machine')));


ALTER TABLE [Essentials].[StyleBulletin]
ADD 
SMV FLOAT DEFAULT NULL,
PieceRate FLOAT DEFAULT NULL,
IsCritical BIT NOT NULL DEFAULT 0;

ALTER TABLE [Essentials].[Machine]
ADD 
CONSTRAINT FK_Machine_Box FOREIGN KEY (BoxID) REFERENCES [Essentials].[Box] (BoxID);


ALTER TABLE [Data].[WorkerScan]
ADD 
Extras VARCHAR(64) DEFAULT NULL;

ALTER TABLE [Essentials].[StyleTemplate]
DROP CONSTRAINT UQ_StyleTemplateCode;


ALTER TABLE [Essentials].[StyleTemplate]
ADD CONSTRAINT UQ_StyleTemplateCode_ParentStyleTemplate
UNIQUE(StyleTemplateCode,ParentStyleTemplateID);
  