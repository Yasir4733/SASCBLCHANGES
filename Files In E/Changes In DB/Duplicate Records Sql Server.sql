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