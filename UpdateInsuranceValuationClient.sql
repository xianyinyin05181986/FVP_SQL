USE [fvp-database]
GO



update [dbo].[InsuranceValuation]
set [dbo].[InsuranceValuation].[Client] = [dbo].[Asset].[Client]
from [dbo].[InsuranceValuation]
inner join [dbo].[Asset]
on [dbo].[InsuranceValuation].[Oid] = [dbo].[Asset].[InsuranceValuation]
WHERE [dbo].[Asset].[GCRecord] is null and [dbo].[InsuranceValuation].[GCRecord] is null
 


Select [dbo].[Asset].[Client],[dbo].[FairValueProClient].[Name]
From [dbo].[Asset] 
inner join [dbo].[FairValueProClient]
On [dbo].[Asset].[Client] = [dbo].[FairValueProClient].[Oid]
where [dbo].[Asset].[InsuranceValuation] in
(
SELECT [Oid]
  FROM [dbo].[InsuranceValuation]
  where [client]  is null
)
and [dbo].[Asset].[GCRecord] is null