DROP PROCEDURE [dbo].[SelectAssetDetail]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 24/11/2016 2:07:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SelectAssetDetail]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
Begin
	Select dbo.asset.Oid into #assetstoShow
	From dbo.Asset
	Where dbo.Asset.AssetRegister =@assetRegisterOid

	Select * From dbo.Asset 
	where dbo.Asset.Oid 
	in (Select * from #assetstoShow)

	Select dbo.Valuer.Oid As Valuer
	   ,dbo.Valuer.Asset As Asset
	From dbo.Valuer
	Where dbo.Valuer.Asset  in 
   (Select * from #assetstoShow)

	Select dbo.InsuranceValuation.Oid As InsuranceOid
	From dbo.InsuranceValuation
	Where dbo.InsuranceValuation.Asset in 
	(Select * from #assetstoShow)

	Select dbo.AssetValidationReport.Oid As AssetValidationReportOid
	From dbo.AssetValidationReport
	Where dbo.AssetValidationReport.Asset in
	(Select * from #assetstoShow)

	Select dbo.AReportUserList.Oid As AReportUserListOid
	From dbo.AReportUserList
	Where dbo.AReportUserList.Asset in
	(Select * from #assetstoShow)

	Select dbo.AssetLevelReport.Oid As AssetLevelReportOid
	From dbo.AssetLevelReport
	Where dbo.AssetLevelReport.Asset in
	(Select * from #assetstoShow)

	Select  dbo.AnalysisOfApproach.Oid As AnalysisOfApproachOid
	From  dbo.AnalysisOfApproach
	Where  dbo.AnalysisOfApproach.Asset in 
	(Select * from #assetstoShow)

	Print ('Replacement Cost Direcot Cost')
	Select dbo.ReplacementCostDetailComponent.*
	From dbo.AssetRegister 
	inner join dbo.ReplacementCost on dbo.AssetRegister.Asset = dbo.ReplacementCost.Asset
	inner join dbo.ReplacementCostDetailComponent on dbo.ReplacementCost.Oid = dbo.ReplacementCostDetailComponent.ReplacmentCost
	inner join dbo.ReplacementCostDirectCost on dbo.ReplacementCost.Oid = dbo.ReplacementCostDirectCost.Oid
	Where dbo.AssetRegister.GCRecord is null and dbo.AssetRegister.Asset in (Select * from #assetstoShow)

	
	Select dbo.MarketValue.Oid As MarketValueOid
		,dbo.MarketValue.VacantLand
		,dbo.MarketValue.CapitalisationOfIncome
		,dbo.MarketValue.DirectComparison
	From dbo.MarketValue
	Where dbo.MarketValue.Asset in 
	(Select * from #assetstoShow)

	Select dbo.VacantLand.Oid As VacantLandOid
	From dbo.VacantLand
	Where dbo.VacantLand.Oid in 
	(
		Select dbo.MarketValue.VacantLand
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(Select * from #assetstoShow)
	)

	Select dbo.CapitalisationOfIncome.Oid As CapitalisationOfIncomeOid
	From dbo.CapitalisationOfIncome
	Where dbo.CapitalisationOfIncome.Oid in 
	(
		Select dbo.MarketValue.CapitalisationOfIncome
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(Select * from #assetstoShow)
	)


	Select dbo.DirectComparison.Oid As DirectComparisonOid
	From dbo.DirectComparison
	Where dbo.DirectComparison.Oid in 
	(
		Select dbo.MarketValue.DirectComparison
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(Select * from #assetstoShow)
	)



	Select dbo.SummaryValuationBase.Oid As SummaryValuationBaseOid
	,dbo.SummaryValuationBase.Name
	,dbo.SummaryValuationBase.ObjectType
	From dbo.SummaryValuationBase
	Where dbo.SummaryValuationBase.Asset in
   (Select * from #assetstoShow)

	Select dbo.FinancialReportingClassification.Oid As FinancialReportingClassificationOid
	From [dbo].[FinancialReportingClassification]
	Where dbo.FinancialReportingClassification.Asset in
   (Select * from #assetstoShow)

    IF OBJECT_ID('tempdb..#ComponentToCreate') IS NOT NULL
	    DROP TABLE #ComponentToCreate
	   Select
	   Distinct
	   dbo.AssetHierarchy.AssetHierarchyName As AssetClass,
	   dbo.AssetType.AssetTypeName As AssetType,
	   dbo.AssetSubType.AssetSubTypeName As AssetSubtype,
	   dbo.AssetRegister.AssetId,
	   dbo.ComponentAssetHierarchy.ComponentName As Component,
	   dbo.ComponentAssetHierarchy.Oid As ComponentHierarchyOid,
	   dbo.ComponentAssetHierarchy.Apportionment
	   into #ComponentToCreate
	   From  dbo.AssetRegister
	   inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
	   inner join dbo.AssetType on dbo.AssetType.Oid =dbo.AssetRegister.AssetType
	   inner join dbo.AssetSubType on dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType
	   inner join dbo.ComponentAssetHierarchy on dbo.ComponentAssetHierarchy.AssetSubtype = dbo.AssetSubType.Oid
	   Where dbo.AssetRegister.Asset in 
	   (Select * from #assetstoShow)
  
  Select * From #ComponentToCreate
 

   Select dbo.ComponentInput.Asset,
		 dbo.AssetHierarchy.AssetHierarchyName,
		 dbo.AssetType.AssetTypeName,
		 dbo.AssetSubType.AssetSubTypeName
   From dbo.ComponentInput
   inner join dbo.AssetRegister on dbo.ComponentInput.Asset = dbo.AssetRegister.Asset
   inner join dbo.AssetHierarchy on dbo.AssetHierarchy.Oid = dbo.AssetRegister.AssetClass
   inner join dbo.AssetType on dbo.AssetType.Oid =dbo.AssetRegister.AssetType
   inner join dbo.AssetSubType on dbo.AssetSubType.Oid = dbo.AssetRegister.AssetSubType
   inner join dbo.ComponentAssetHierarchy on dbo.ComponentInput.Component_AssetHierarchy= dbo.ComponentAssetHierarchy.Oid
   Where dbo.ComponentInput.Asset in 
   (Select * from #assetstoShow)

    IF OBJECT_ID('tempdb..#ComponentToCreate') IS NOT NULL
	    DROP TABLE #ComponentToCreate
	IF OBJECT_ID('tempdb..#assetstoShow') IS NOT NULL
		DROP TABLE #assetstoShow
   
End