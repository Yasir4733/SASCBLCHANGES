SELECT COUNT(*) FROM primary_essentials.numbers;
SELECT COUNT(*) FROM primary_essentials.Clients;

--INSERT INTO primary_essentials.Clients (ClientName)
--SELECT TOP 50 'Client ' + CAST(numberId AS nvarchar(2))
--FROM primary_essentials.numbers
--ORDER BY numberId;


---- SET IDENTITY_INSERT primary_essentials.MajorOrder ON;
--INSERT INTO primary_essentials.MajorOrder(MajorOrderID, ClientID)
--SELECT T1.numberId, T2.ClientID
--FROM primary_essentials.numbers AS T1
--CROSS JOIN primary_essentials.Clients AS T2
--WHERE T1.numberId <= 2500;
---- SET IDENTITY_INSERT primary_essentials.MajorOrder OFF;

SELECT T1.numberId, T2.BundleCutReportID,t3.StyleTemplateID
FROM primary_essentials.numbers AS T1
CROSS JOIN [primary_essentials].[BundleCutReport] AS T2
CROSS JOIN [primary_essentials].[StyleTemplate] AS t3
WHERE T1.numberId <= 5
ORDER BY T2.BundleCutReportID, T1.numberId,t3.StyleTemplateID;



SELECT T1.numberId,T2.StyleTemplateID
FROM primary_essentials.numbers AS T1
CROSS JOIN [primary_essentials].[StyleTemplate] AS T2

WHERE T1.numberId <= 5
ORDER BY T1.numberId,T2.StyleTemplateID;


SELECT T1.numberId,T2.StyleTemplateID,T3.MajorOperationID , 1 AS MachineType,T3.MajorOperationID AS OperationSequence ,ROUND(RAND(),2) AS PieceRate,ROUND(RAND(),2) AS SMV
FROM [primary_essentials].[numbers] AS T1
CROSS JOIN [primary_essentials].[StyleTemplate] AS T2
CROSS JOIN [primary_essentials].[MajorOperation] AS T3

WHERE T1.numberId <= 1
ORDER BY T1.numberId,T2.StyleTemplateID;