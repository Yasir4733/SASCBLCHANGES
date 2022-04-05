--Ahsan Bhai


-- Local SooperWizer

USE [SooperWizerCP]
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Size VARCHAR(32),
Ratio INT, 
Inseam INT;


USE [SooperWizer]
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Size VARCHAR(32),
Ratio INT, 
Inseam INT;


USE [SooperWizerRT]
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Size VARCHAR(32),
Ratio INT, 
Inseam INT;


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------


-- CLIENT INDUS
-- SooperWizer AND SooperWizerQA


USE [SooperWizer]
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Size VARCHAR(32),
Ratio INT, 
Inseam INT;


USE [SooperWizerQA]
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Size VARCHAR(32),
Ratio INT, 
Inseam INT;



------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- Pending
ALTER TABLE [Essentials].[PrintCutReport]
ADD
Color VARCHAR(32);