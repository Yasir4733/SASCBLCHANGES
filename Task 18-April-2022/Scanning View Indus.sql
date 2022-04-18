USE [SooperWizer]
GO


CREATE view [Report].[vw_PieceWiseScan] as

SELECT [PieceWiseScanningID]
      ,[ScanID]
      ,t7.SaleOrderID
      ,t8.SaleOrderCode
      ,t8.Customer
      ,t8.OrderQuantity
      ,t6.ProductionOrderID
      ,t7.ProductionOrderCode
      ,t1.[BundleID]
      ,t2.BundleCode
      ,t2.BundleQuantity
	  ,t2.Size
      ,t2.CutJobID
      ,t6.CutNo
      ,t1.[PieceID]
      ,t3.PieceNumber
      ,t3.StyleTemplateID
      ,t4.StyleBulletinID
      ,t5.DepartmentID
      ,t5.SectionID,t11.SectionCode, t11.SectionDescription
      ,t1.[OperationID]
      ,t5.OperationCode
      ,t5.OperationDescription
      ,t5.OperationName
      ,t5.OperationType
      ,t4.OperationSequence
      ,t4.IsFirst
      ,t4.IsLast
      ,t4.SMV
      ,t4.PieceRate
      ,t4.IsCritical
      ,t4.MachineTypeID
      ,t1.[WorkerID]
      ,t9.WorkerCode
      ,t9.WorkerDescription
      ,t1.[LineID],t10.LineCode, t10.LineDescription
      ,[MachineID]
      ,t1.[CreatedAt]
      ,t1.[UpdatedAt]
      ,[PieceWiseGroupID]
      ,[GroupID]
      ,[ShortAddress]
      ,[LongAddress]
      ,[HostIP]
  FROM [Data].[PieceWiseScan] t1 
 Left JOIN [Essentials].[CutReport] t2 
  on t1.BundleID = t2.BundleID
  left join [Essentials].[PieceWiseCutReport] t3
  on t1.PieceID=t3.PieceID
  Left Join [Essentials].[StyleBulletin] t4
  on t3.StyleTemplateID=t4.StyleTemplateID AND
    t1.OperationID=t4.OperationID
    Left Join [Essentials].[Operation] t5
    on t1.OperationID=t5.OperationID
    Left join [Essentials].[CutJob] t6
    on t2.CutJobID=t6.CutJobID
    left join [Essentials].[ProductionOrder] t7
    on t6.ProductionOrderID=t7.ProductionOrderID
    left join [Essentials].[SaleOrder] t8
    on t7.SaleOrderID=t8.SaleOrderID
    Left join [Essentials].[Worker] t9
    on t1.WorkerID=t9.WorkerID
    left join [Essentials].[Line] t10
    on t1.LineID=t10.LineID
 left join [Essentials].[Section] t11
 on t5.SectionID=t11.SectionID
    
	Where t3.PieceNumber=1



GO


