USE [fvp-database]
GO

/****** Object:  View [dbo].[JobHistoryReportView]    Script Date: 25/10/2016 5:13:58 PM ******/
DROP VIEW [dbo].[JobHistoryReportView]
GO

/****** Object:  View [dbo].[JobHistoryReportView]    Script Date: 25/10/2016 5:13:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[JobHistoryReportView]
AS
SELECT        dbo.Job.Oid AS JobOid, dbo.AssetRegister.AssetClass, dbo.Job.FairValueProGroup AS GroupOid, dbo.Job.Client AS ClientOid, dbo.FairValueProGroup.Name AS GroupName, 
                         dbo.FairValueProClient.Name AS ClientName, dbo.Job.Name AS JobName, dbo.AssetHierarchy.Name AS AssetClassName, dbo.Job.JobType, dbo.Job.JobStatus AS Status, dbo.Job.JobNumber, 
                         dbo.Job.EffectiveDateofValuation AS EDate, dbo.Job.DraftDueDate AS DraftDate, dbo.Job.FinalDueDate AS FinalDate, CASE WHen SUM(dbo.AssetLevelSummaryValuationView.FAIRVALUE) is Null Then 0 else  SUM(dbo.AssetLevelSummaryValuationView.FAIRVALUE) END AS FV, 
                         CASE WHEN SUM(dbo.AssetLevelSummaryValuationView.GROSSMV) is not Null Then SUM(dbo.AssetLevelSummaryValuationView.GROSSMV) Else 0 END  AS GMV, COUNT(dbo.Job.GCRecord) AS GCRecord, COUNT(dbo.AssetRegister.Job) AS NoOfAssets, COUNT(dbo.AssetRegister.Oid) 
                         AS AssetRegisterOid
FROM            dbo.Job LEFT OUTER JOIN
                         dbo.AssetRegister ON dbo.Job.Oid = dbo.AssetRegister.Job LEFT OUTER JOIN
                         dbo.AssetHierarchy ON dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass LEFT OUTER JOIN
                         dbo.AssetLevelSummaryValuationView ON dbo.AssetRegister.Asset = dbo.AssetLevelSummaryValuationView.AssetOid LEFT OUTER JOIN
                         dbo.FairValueProGroup ON dbo.FairValueProGroup.Oid = dbo.Job.FairValueProGroup LEFT OUTER JOIN
                         dbo.FairValueProClient ON dbo.FairValueProClient.Oid = dbo.Job.Client
						 where  dbo.AssetRegister.AssetClass is not null
GROUP BY dbo.Job.Oid, dbo.Job.Name, dbo.Job.Client, dbo.Job.FairValueProGroup, dbo.FairValueProGroup.Name, dbo.AssetRegister.AssetClass, dbo.AssetHierarchy.Name, dbo.FairValueProClient.Name, dbo.Job.JobType, 
                         dbo.Job.JobStatus, dbo.Job.JobNumber, dbo.Job.EffectiveDateofValuation, dbo.Job.DraftDueDate, dbo.Job.FinalDueDate



GO


