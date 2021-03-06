/****** Script for SelectTopNRows command from SSMS  ******/
SELECT dbo.Job.Oid AS JobOid
      ,dbo.AssetRegister.AssetClass
      ,[dbo].[Job].[FairValueProGroup] As GroupOid
      ,[dbo].[Job].[Client] AS ClientOid
	  ,dbo.FairValueProGroup.Name AS GroupName
	  ,[dbo].[FairValueProClient].[Name] AS ClientName
      ,[dbo].[Job].[Name] AS JobName
	  ,dbo.AssetHierarchy.Name AS AssetClassName
      ,[dbo].[Job].[JobType] as jobtype
      ,[dbo].[Job].[JobStatus] as Status
      ,[dbo].[Job].[JobNumber]
      ,[dbo].[Job].[EffectiveDateofValuation] as EDate
      ,[dbo].[Job].[DraftDueDate] as DraftDate
      ,[dbo].[Job].[FinalDueDate]  as FinalDate
	  ,SUM(dbo.AssetLevelSummaryValuationView.FAIRVALUE) AS FV
	  ,SUM(dbo.AssetLevelSummaryValuationView.GROSSMV) AS GMV   
      ,Count (dbo.Job.GCRecord) As GCRecord
	  ,Count (dbo.AssetRegister.Job) As NoOfAssets
	  ,Count (dbo.AssetRegister.Oid) AS AssetRegisterOid
	 
  FROM [dbo].[Job] Left Outer JOIN
       dbo.AssetRegister ON [dbo].[Job].[Oid] = dbo.AssetRegister.Job 
	   Left Outer JOIN
	   dbo.AssetHierarchy ON dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass 
	   Left Outer JOIN
	   dbo.AssetLevelSummaryValuationView ON dbo.AssetRegister.Asset = dbo.AssetLevelSummaryValuationView.AssetOid
	    Left Outer JOIN
	   [dbo].[FairValueProGroup] ON [dbo].[FairValueProGroup].[Oid] = [dbo].[Job].[FairValueProGroup]
	    Left Outer JOIN
       [dbo].[FairValueProClient] ON [dbo].[FairValueProClient].[Oid] = [dbo].[Job].[Client]
 Group By 
   dbo.Job.Oid 
 ,[dbo].[Job].[Name]
 ,[dbo].[Job].[Client]
 ,[dbo].[Job].[FairValueProGroup]
 ,dbo.FairValueProGroup.Name 
 ,dbo.AssetRegister.AssetClass
 ,dbo.AssetHierarchy.Name 
  ,[dbo].[FairValueProClient].[Name]
      ,[dbo].[Job].[JobType]
      ,[dbo].[Job].[JobStatus]
      ,[dbo].[Job].[JobNumber]
      ,[dbo].[Job].[EffectiveDateofValuation]
      ,[dbo].[Job].[DraftDueDate]
      ,[dbo].[Job].[FinalDueDate]  
