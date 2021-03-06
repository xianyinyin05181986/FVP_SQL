/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  [Oid]
      ,[Name]
      ,[Client]
      ,[FairValueProGroup]
      ,[Effectivedatepreviouscomprehensive]
      ,[RelianceonCostapproach]
      ,[RelianceonMarketapproach]
      ,[RelianceonIncomeapproach]
      ,[Comments]
      ,[Asset]
      ,[OptimisticLockField]
      ,[GCRecord]
FROM [dbo].[AnalysisOfApproach]
  where [GCRecord] is null

  And [Client] in 
	 (
			Select [Oid]
			From [dbo].[FairValueProClient]
			where [GCRecord] is null 
			And [Oid] in 
			(
				Select [dbo].[FairValueProUser].[Client]
				From [dbo].[FairValueProUser]
				where [Oid] in 
				(
					Select [Oid] 
					From [dbo].[SecuritySystemUser]
					where [GCRecord] is null 
					And [UserName] = 'APV_Test_User'
				)
			)
		  )

  And [Asset] in 
	  (
		Select [Oid]
		From [dbo].[Asset]
		where [GCRecord] is null
		And [Client] in 
		  (
			Select [Oid]
			From [dbo].[FairValueProClient]
			where [GCRecord] is null 
			And [Oid] in 
			(
				Select [dbo].[FairValueProUser].[Client]
				From [dbo].[FairValueProUser]
				where [Oid] in 
				(
					Select [Oid] 
					From [dbo].[SecuritySystemUser]
					where [GCRecord] is null 
					And [UserName] = 'APV_Test_User'
				)
			)
		  )
	  )
  
  