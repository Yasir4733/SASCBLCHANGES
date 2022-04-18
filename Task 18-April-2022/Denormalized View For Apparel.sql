SELECT 
pws.PieceWiseScanningID, 
pws.ScanID, 
pws.BundleID,
cr.BundleCode,
cr.BundleQuantity,
cr.CutJobID,
cr.Embellishment,
pws.PieceID, 
pwcr.PieceNumber,
pwcr.StyleTemplateID,
stb.StyleBulletinID,
stb.OperationSequence,
stb.IsFirst,
stb.IsLast,
stb.SMV,
stb.PieceRate,
stb.IsCritical,
pws.OperationID,
op.OperationCode,
op.OperationDescription,
op.OperationName,
op.OperationType,
op.SectionID,
op.DepartmentID,
cj.CutNo,
cj.ProductionOrderID,
cj.Size,
cj.Color,
po.ProductionOrderCode,
po.StyleCode,
po.Article,
po.StyleCode,
po.IsFollowOperationSequence,
po.SaleOrderID,
so.SaleOrderCode,
so.Customer,
so.OrderQuantity,
pws.WorkerID,
w.WorkerCode,
w.WorkerDescription,
pws.LineID,
l.LineCode, 
l.LineDescription,
pws.MachineID,
pws.PieceWiseGroupID, 
pws.GroupID, 
pws.ShortAddress, 
pws.LongAddress, 
pws.HostIP, 
pws.CreatedAt, 
pws.UpdatedAt



FROM [Data].[PieceWiseScan] pws
LEFT JOIN [Essentials].[CutReport] cr
ON pws .BundleID = cr .BundleID
LEFT JOIN [Essentials].[PieceWiseCutReport] pwcr
ON pws.PieceID=pwcr.PieceID
LEFT JOIN [Essentials].[StyleBulletin] stb
ON pwcr.StyleTemplateID=stb.StyleTemplateID AND pws.OperationID=stb.OperationID
LEFT JOIN [Essentials].[Operation] op
ON pws.OperationID=op.OperationID
LEFT JOIN [Essentials].[CutJob] cj
ON cr.CutJobID=cj.CutJobID
LEFT JOIN [Essentials].[ProductionOrder] po
ON cj.ProductionOrderID=po.ProductionOrderID
LEFT JOIN [Essentials].[SaleOrder] so
ON po.SaleOrderID=so.SaleOrderID
LEFT JOIN [Essentials].[Worker] w
ON pws.WorkerID=w.WorkerID
LEFT JOIN [Essentials].[Line] l
ON pws.LineID=l.LineID
LEFT JOIN [Essentials].[Section] t11
ON op.SectionID=op.SectionID
WHERE pwcr.PieceNumber=1;


