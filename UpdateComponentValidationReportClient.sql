USE [fvp-database]
GO

Select A.[Oid] ComponentInput,B.[Client]
From [dbo].[ComponentInput] A
Join  [dbo].[ComponentValidationReport] B
On A.[ComponentValidationReport] = B.[Oid]


 Update [dbo].[ComponentValidationReport]
 Set [dbo].[ComponentValidationReport].[Client] = [dbo].[ComponentInput].[Client]
 from [dbo].[ComponentValidationReport]
 inner join [dbo].[ComponentInput]
 on [dbo].[ComponentValidationReport].[Oid] = [dbo].[ComponentInput].[ComponentValidationReport]
 and [dbo].[ComponentInput].[ComponentValidationReport] is not null