USE [fvp-database]
GO

UPDATE [dbo].[ComponentInput]
   SET 
      [dbo].[ComponentInput].[ConsumptionProfile] = [dbo].[ComponentMatrixConsumptionProfileView].[ValuationProfile]
     From  [dbo].[ComponentInput]
	inner join [dbo].[ComponentMatrixConsumptionProfileView]
		On [dbo].[ComponentMatrixConsumptionProfileView].[ComponentId] = [dbo].[ComponentInput].[Oid]
	Where [dbo].[ComponentInput].[Asset] In
 (
		Select [Oid]  
		From [dbo].[Asset]
			where [Client] In 
		  (
			Select [Oid]
			From [dbo].[FairValueProClient]
			Where [Name] ='APV_Ballina_Shire_Council'
		  ) And [GCRecord] is Null
	 
  ) 

