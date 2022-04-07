-- AHSAN BHAI

--CLIENT  COLONY 
USE [SooperWizer];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

USE [SooperWizerQA];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

--CLIENT  CFL
USE [SooperWizer];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

USE [SooperWizerQA];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

--CLIENT INDUS 
USE [SooperWizer];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

USE [SooperWizerQA];
ALTER TABLE [Essentials].[CutJob]
ADD StyleTemplateID INT,
CONSTRAINT FK_CutJob_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID);

