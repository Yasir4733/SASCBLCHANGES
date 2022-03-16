DECLARE @JSONData AS VARCHAR(1000)
SET @JSONData = '{
    "EmployeeInfo":{
        "FirstName":"Jignesh",
        "LastName":"Trivedi",
        "Code":"CCEEDD",
        "Addresses":[
            { "Address":"Test 0", "City":"Gandhinagar", "State":"Gujarat"},
            { "Address":"Test 1", "City":"Gandhinagar", "State":"Gujarat"}
        ]
    }
}'

IF ISJSON(@JSONData) =1
	PRINT 'Valid Json'
ELSE 
	PRINT 'InValid Json';



DECLARE @JSONData1 AS VARCHAR(1000)
SET @JSONData1 = '[1,2,3,4,5,6,7]'

IF ISJSON(@JSONData1) =1
	PRINT 'Valid Json'
ELSE 
	PRINT 'InValid Json';


SELECT TOP (1000) [WorkerID]
      ,[WorkerCode]
      ,[AllocatedMachines]
  FROM [SooperWizerReplica].[Essentials].[Worker]