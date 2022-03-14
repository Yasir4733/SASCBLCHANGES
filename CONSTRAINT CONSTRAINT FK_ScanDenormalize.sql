CONSTRAINT FK_ScanDenormalize_CutReport FOREIGN KEY(BundleID)
REFERENCES [Essentials].[CutReport] (BundleID)

CONSTRAINT FK_ScanDenormalize_StyleTemplate FOREIGN KEY(StyleTemplateID)
REFERENCES [Essentials].[StyleTemplate] (StyleTemplateID)

CONSTRAINT FK_ScanDenormalize_ParentStyleTemplate FOREIGN KEY(ParentStyleTemplateID)
REFERENCES [Essentials].[ParentStyleTemplateID] (ParentStyleTemplateID)

CONSTRAINT FK_ScanDenormalize_CutJob FOREIGN KEY(CutJobID)
REFERENCES [Essentials].[CutJob] (CutJobID)

CONSTRAINT FK_ScanDenormalize_Marker FOREIGN KEY(CutJobID)
REFERENCES [Essentials].[Marker] (MarkerID)

CONSTRAINT FK_ScanDenormalize_ProductionOrder FOREIGN KEY(ProductionOrderID)
REFERENCES [Essentials].[ProductionOrder] (ProductionOrderID)

CONSTRAINT FK_ScanDenormalize_SaleOrder FOREIGN KEY(SaleOrderID)
REFERENCES [Essentials].[SaleOrder] (SaleOrderID)

CONSTRAINT FK_ScanDenormalize_PieceWiseCutReport FOREIGN KEY(PieceID)
REFERENCES [Essentials].[PieceWiseCutReport] (PieceID)

CONSTRAINT FK_ScanDenormalize_Operation FOREIGN KEY(OperationID)
REFERENCES [Essentials].[Operation] (OperationID)

CONSTRAINT FK_ScanDenormalize_Section FOREIGN KEY(SectionID)
REFERENCES [Essentials].[Section] (SectionID)

CONSTRAINT FK_ScanDenormalize_Department FOREIGN KEY(DepartmentID)
REFERENCES [Essentials].[Department] (DepartmentID)


CONSTRAINT FK_ScanDenormalize_Worker FOREIGN KEY(WorkerID)
REFERENCES [Essentials].[Worker] (WorkerID)

CONSTRAINT FK_ScanDenormalize_Line FOREIGN KEY(LineID)
REFERENCES [Essentials].[Line] (LineID)

CONSTRAINT FK_ScanDenormalize_Machine FOREIGN KEY(MachineID)
REFERENCES [Essentials].[Machine] (MachineID)

CONSTRAINT FK_ScanDenormalize_MachineType FOREIGN KEY(MachineTypeID)
REFERENCES [Essentials].[MachineType] (MachineTypeID)


CONSTRAINT FK_ScanDenormalize_Box FOREIGN KEY(BoxID)
REFERENCES [Essentials].[Box] (BoxID)



CONSTRAINT FK_ScanDenormalize_WorkerScan FOREIGN KEY(WorkerScanID)
REFERENCES [Data].[WorkerScan] (WorkerScanID)


