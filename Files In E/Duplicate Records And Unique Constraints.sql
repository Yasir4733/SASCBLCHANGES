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



-- USE `sooperwizer`;
-- SHOW INDEX FROM cut_report;

-- DROP INDEX UQ_CutJobID_BundleCode ON cut_report;



-- WITH cte AS (
-- SELECT BundleCode,CutJobID,ROW_NUMBER() OVER (PARTITION BY BundleCode,CutJobID) rownum
-- FROM cut_report
-- ) 
-- DELETE
-- FROM 
--    cte 
-- WHERE rownum>1;




-- Duplicate Records

-- WITH cte AS (
-- SELECT BundleCode,CutJobID,ROW_NUMBER() OVER (PARTITION BY BundleCode,CutJobID) rownum
-- FROM cut_report
-- ) 
-- SELECT 
--  * 
-- FROM 
--    cte 
-- WHERE rownum>1;

-- Delete Duplicate Records

-- USE `sooperwizer`;
-- DELETE FROM cut_report WHERE BundleID IN(  
--     SELECT BundleID FROM (SELECT BundleID,BundleCode,CutJobID, ROW_NUMBER()   
--        OVER (PARTITION BY BundleCode,CutJobID ORDER BY BundleID) AS row_num   
--     FROM cut_report) AS temp_table WHERE row_num>1  
-- );


-- USE `sooperwizer`;

-- ALTER TABLE cut_report DROP INDEX UQ_CutJobID_BundleCode;
-- SHOW INDEX FROM cut_report;

-- USE `sooperwizer`;

-- ALTER TABLE cut_report
-- ADD CONSTRAINT UQ_CutJobID_BundleCode UNIQUE (CutJobID,BundleCode);
-- SHOW INDEX FROM cut_report;
