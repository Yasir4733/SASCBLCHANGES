-- AHSAN BHAI 
-- CLIENT COLONY

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