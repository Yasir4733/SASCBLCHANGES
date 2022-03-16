--SELECT COUNT([MachineDescription])
--      ,[MachineDescription]
--  FROM [CBL].[Essentials].[Machine]
--  GROUP BY [MachineDescription]
--  HAVING COUNT(*)>1

--WITH cte AS (
--    SELECT  
--        [MachineDescription], 
--        ROW_NUMBER() OVER (
--            PARTITION BY [MachineDescription]
--            ORDER BY [MachineDescription]) rownum
--    FROM 
--        [CBL].[Essentials].[Machine]
--) 
--SELECT 
--  * 
--FROM 
--    cte 
--WHERE 
--    rownum > 1;



--WITH cte AS (
--    SELECT  
--        [MachineDescription], 
--        ROW_NUMBER() OVER (
--            PARTITION BY [MachineDescription]
--            ORDER BY [MachineDescription]) rownum
--    FROM 
--        [CBL].[Essentials].[Machine]
--) 
--DELETE
--FROM 
--    cte 
--WHERE 
--    rownum > 1;



--WITH cte AS (
--    SELECT 
--        [MachineDescription],
--        ROW_NUMBER() OVER ( PARTITION BY [MachineDescription]
--							ORDER BY [MachineDescription]) row_num
--     FROM 
--        [CBL].[Essentials].[Machine]
--)
--DELETE FROM cte
--WHERE row_num > 1;


--ALTER TABLE [CBL].[Essentials].[Machine]
--ADD CONSTRAINT UQ_Machine_MachineDescription UNIQUE (MachineDescription);

-- SELECT [product_id]
--       ,[product_name]
--       ,[brand_id]
--       ,[category_id]
--       ,[model_year]
--       ,[list_price],
-- 	  DENSE_RANK() OVER (ORDER BY [brand_id]) rnk
--   FROM [BikeStore].[production].[products]




-- CONSTARINT ON A TABLE
-- USE `sooperwizer`;
-- SHOW CREATE TABLE cut_report;





-- USE `sooperwizer`;
-- ALTER TABLE cut_report
-- ADD CONSTRAINT  UQ_CutJobID_BundleCode UNIQUE (`CutJobID`,`BundleCode`);







-- SELECT COUNT(BundleCode)
--      ,BundleCode,CutJobID
--  FROM cut_report
--  GROUP BY BundleCode,CutJobID
--  HAVING COUNT(*)>1

-- WITH cte AS (
-- SELECT BundleCode,CutJobID,ROW_NUMBER() OVER (PARTITION BY BundleCode,CutJobID) rownum
-- FROM cut_report
-- ) 
-- SELECT 
--  * 
-- FROM 
--    cte 
-- WHERE rownum>1;

-- SELECT BundleCode,CutJobID FROM cut_report WHERE BundleCode=9;