




		Select d1.TagID,c1.* from
		(



							Select b1.MachineID,a1.* FROM
	



							(

									Select  MachineID,MajorOperationID from primary_assignment.MachineOperationMapping 
									where MachineID = 1 and MajorOperationID = 1
		

							) b1

							left JOIN


		
							(


									Select 
				
									a.*,b.BundleCutReportID,c.PieceCutReportID,c.PieceNumber,c.StyleTemplateID,d.StyleLayoutID,
									d.OperationSequence,d.MajorOperationID,d.MinorOperationID 
				
									FROM
									(


									SELECT  *
									  FROM [SaaS_v7].[primary_essentials].[MinorOrder]
									

									) a left join
									primary_essentials.BundleCutReport b on (a.MinorOrderID = b.MinorOrderID) left join
									primary_essentials.PieceCutReport c on (b.BundleCutReportID = c.BundleCutReportID) left join
									primary_essentials.StyleLayout d on (c.StyleTemplateID = d.StyleTemplateID)
				

							) a1 on (a1.MajorOperationID = b1.majoroperationID)

		) c1 inner join 
		
		(
		
		Select TagID,PieceCutReportID from  primary_essentials.Tag t left join primary_essentials.GroupCardDetails g on (t.GroupCardID = g.GroupCardID)
		
		) d1 on (c1.PieceCutReportID = d1.PieceCutReportID)


-- ===========================================================================================================================================================
-- ===========================================================================================================================================================

Select a.MachineID,b.*,c.BundleCutReportID,c.PieceCutReportID,c.PieceNumber,c.TagID into primary_log.PossibleScanning_v2 
		FROM
		( 
			Select  MachineID,MajorOperationID from primary_assignment.MachineOperationMapping 
			--where MachineID = 1 --and MajorOperationID = 1
		) a
		left join primary_essentials.StyleLayout b on (a.MajorOperationID = b.MajorOperationID)
		left join 
		(
					Select t.TagID,t.GroupCardID,c.*   from primary_essentials.Tag t inner join primary_essentials.GroupCardDetails g on (t.GroupCardID = g.GroupCardID)
			inner join primary_essentials.PieceCutReport c on (g.PieceCutReportID = c.PieceCutReportID)	

		) c on (b.StyleTemplateID = c.StyleTemplateID)
		
-- ===========================================================================================================================================================
-- ===========================================================================================================================================================

--set statistics time on 
SELECT  *
  FROM [SaaS_v7].[primary_log].[PossibleScanning_v2]
  where tagID = 1815 and machineID = 23

  create index idxabc on [primary_log].[PossibleScanning_v2]
   (tagID,machineID)