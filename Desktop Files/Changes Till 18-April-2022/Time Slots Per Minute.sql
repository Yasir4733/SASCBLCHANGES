With temp
As
(
   SELECT 1 as Time_ID, DATEADD(day, DATEDIFF(day,0,GETDATE()),0)  as Time_Slot
	UNION ALL
   SELECT Time_ID+1, DATEADD(minute, 1, Time_Slot)
   FROM temp
   WHERE Time_ID < 24 * 60 
)
SELECT *

FROM temp OPTION (maxrecursion 0)


---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

With temp
As
(
	SELECT 1 as Time_ID, CAST('2022-04-06 00:00:00.000' AS datetime)  as Time_Slot
	UNION ALL
   SELECT Time_ID+1, DATEADD(minute, 1, Time_Slot)
   FROM temp
   WHERE Time_ID < 24 * (60 * ( DATEDIFF(day,'2022-04-05 00:00:00.000',GETDATE())))
)
SELECT *

FROM temp OPTION (maxrecursion 0)


---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @start_date DATETIME;
DECLARE @end_date DATETIME;
SET @start_date =  CAST('2022-04-06 00:00:00.000' AS DATETIME);
SET @end_date = GETDATE();


With temp(Time_ID,Time_Slot)
As
(
	SELECT 1 as Time_ID, @start_date  as Time_Slot

	UNION ALL
	SELECT Time_ID+1, DATEADD(minute, 1, Time_Slot)
	FROM temp
	WHERE Time_ID < ((DATEDIFF(day,'2022-04-05 00:00:00.000',@end_date))*24) * 60  
)
SELECT *

FROM temp OPTION (maxrecursion 0)


