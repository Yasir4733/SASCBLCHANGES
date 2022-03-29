select COUNT(*) from primary_essentials.numbers;
select COUNT(*) from primary_essentials.Clients;

--insert into primary_essentials.Clients (ClientName)
--select top 50 'Client ' + cast(numberId as nvarchar(2))
--from primary_essentials.numbers
--order by numberId;


---- set identity_insert primary_essentials.MajorOrder on;
--insert into primary_essentials.MajorOrder(CL_MajorOrderID, ClientID)
--select t1.numberId, t2.ClientID
--from primary_essentials.numbers as t1
--cross join primary_essentials.Clients as t2
--where t1.numberId <= 2500;
---- set identity_insert primary_essentials.MajorOrder off;

select t1.numberId, t2.BundleCutReportID,t3.StyleTemplateID
from primary_essentials.numbers as t1
cross join [primary_essentials].[BundleCutReport] as t2
cross join [primary_essentials].[StyleTemplate] as t3
where t1.numberId <= 5
order by t2.BundleCutReportID, t1.numberId,t3.StyleTemplateID;