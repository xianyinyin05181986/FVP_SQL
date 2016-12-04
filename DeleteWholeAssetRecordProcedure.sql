USE [fvp-database]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 30/11/2016 11:46:41 AM ******/
DROP PROCEDURE [dbo].[DeleteAssetRecord]
GO

/****** Object:  StoredProcedure [dbo].[DeleteAssetRecord]    Script Date: 30/11/2016 11:46:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[DeleteAssetRecord]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
Begin
	Select dbo.asset.Oid into #assetstodelete
	--Delete
	From dbo.Asset
	Where dbo.Asset.AssetRegister =@assetRegisterOid

	Update dbo.AssetRegister
	Set dbo.AssetRegister.Asset= null
	where dbo.AssetRegister.Oid = @assetRegisterOid

	--=============================================
	--  Delete Valuer
	--=============================================
	Print('Delete Valuer')
	Delete
	From dbo.Valuer
	Where dbo.Valuer.Asset in 
	(select * from #assetstodelete)

	--=============================================
	--  Delete Insurance Valuation
	--=============================================

	
	IF OBJECT_ID('tempdb..#InsuranceValuationtoDelete') IS NOT NULL
		DROP TABLE #InsuranceValuationtoDelete

	Select [InsuranceValuation] into #InsuranceValuationtoDelete
	From [dbo].[Asset]
	Where [dbo].[Asset].[Oid]  in 
	(select * from #assetstodelete)

	Print('Delete Insurance Valuation')
	Delete
	From dbo.InsuranceValuation
	Where dbo.InsuranceValuation.Asset in 
	(select * from #assetstodelete) 
	
	Delete
	From dbo.InsuranceValuation
	Where dbo.InsuranceValuation.Oid in 
	(select * from #InsuranceValuationtoDelete)


	--=============================================
	--  Delete A Report User List
	--=============================================
	Print('Delete Report User List')
	Delete
	From dbo.AReportUserList
	Where dbo.AReportUserList.Asset in
	(select * from #assetstodelete)



	--=============================================
	--  Delete Analysis of Approach
	--=============================================
	Print('Delete Analysis of Approach')
	Delete
	From  dbo.AnalysisOfApproach
	Where  dbo.AnalysisOfApproach.Asset in 
	(select * from #assetstodelete)

	--=============================================
	--  Delete Market Value
	--=============================================
	Print ('Prepare Market to Delete')


	IF OBJECT_ID('tempdb..#MarketValuetoDelete') IS NOT NULL
		DROP TABLE #MarketValuetoDelete
	Select [Oid] into #MarketValuetoDelete
	From dbo.Asset 
	Where dbo.Asset.Oid in 
	(select * from #assetstodelete)


	Print ('Prepare Vacant Land to Delete')

	

	IF OBJECT_ID('tempdb..#VacantLandtoDelete') IS NOT NULL
		DROP TABLE #VacantLandtoDelete
	Select dbo.VacantLand.Oid into #VacantLandtoDelete
	From dbo.VacantLand
	Where dbo.VacantLand.Oid in 
	(
		Select dbo.MarketValue.VacantLand
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(select * from #assetstodelete)
	)
	-- Delete From Asset Table
	Delete
	From dbo.VacantLand
	Where dbo.VacantLand.Oid in 
	(
		Select dbo.MarketValue.VacantLand
		From dbo.MarketValue
		Where dbo.MarketValue.Oid in 
		(select * from #MarketValuetoDelete)
	)

	Print ('Prepare Capitalisation of Income to Delete')

	IF OBJECT_ID('tempdb..#CapitalisationOfIncometoDelete') IS NOT NULL
		DROP TABLE #CapitalisationOfIncometoDelete
	Select dbo.CapitalisationOfIncome.Oid into #CapitalisationOfIncometoDelete
	From dbo.CapitalisationOfIncome
	Where dbo.CapitalisationOfIncome.Oid in 
	(
		Select dbo.MarketValue.CapitalisationOfIncome
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(select * from #assetstodelete)
	)
	-- Delete From Asset Table
	Delete
	From dbo.CapitalisationOfIncome
	Where dbo.CapitalisationOfIncome.Oid in 
	(
		Select dbo.MarketValue.CapitalisationOfIncome
		From dbo.MarketValue
		Where dbo.MarketValue.Oid in 
		(select * from #MarketValuetoDelete)
	)

	Print ('Prepare Direct Comparison to Delete')
	
	IF OBJECT_ID('tempdb..#DirectComparisontoDelete') IS NOT NULL
		DROP TABLE #DirectComparisontoDelete
	
	Select dbo.DirectComparison.Oid into #DirectComparisontoDelete
	From dbo.DirectComparison
	Where dbo.DirectComparison.Oid in 
	(
		Select dbo.MarketValue.DirectComparison
		From dbo.MarketValue
		Where dbo.MarketValue.Asset in 
		(select * from #assetstodelete)
	)
	-- Delete From Asset Table
	Delete
	From dbo.DirectComparison
	Where dbo.DirectComparison.Oid in 
	(
		Select dbo.MarketValue.DirectComparison
		From dbo.MarketValue
		Where dbo.MarketValue.Oid in 
		(select * from #MarketValuetoDelete)
	)

	Print ('Unassign Vacant Land, Capitalisation of Income, Direct Comparison from Market Value')

	Update dbo.MarketValue
	Set 
	VacantLand=null,
	CapitalisationOfIncome=null,
	DirectComparison=null
	Where dbo.MarketValue.Asset in 
	(select * from #assetstodelete)

	Print('Delete Vacant Land')

	IF OBJECT_ID('tempdb..#VacantLandtoDelete') IS NOT NULL
	Delete From dbo.VacantLand where dbo.VacantLand.Oid in (Select * From #VacantLandtoDelete)

	Print('Delete Capitaolisation of Income')

	IF OBJECT_ID('tempdb..#CapitalisationOfIncometoDelete') IS NOT NULL
	Delete From dbo.CapitalisationOfIncome where dbo.CapitalisationOfIncome.Oid in (Select * from #CapitalisationOfIncometoDelete)
	
	Print('Delete Direct Comparison')

	IF OBJECT_ID('tempdb..#DirectComparisontoDelete') IS NOT NULL
	Delete From dbo.DirectComparison where dbo.DirectComparison.Oid in (Select * from #DirectComparisontoDelete)

	Print('Delete Market Value')

	Delete
	From dbo.MarketValue
	Where dbo.MarketValue.Asset in 
	(select * from #assetstodelete)
	--=============================================
	--  Delete Summary Valuation
	--=============================================
	IF OBJECT_ID('tempdb..#SummaryValuationToDelete') IS NOT NULL
    DROP TABLE #SummaryValuationToDelete

	Select dbo.SummaryValuationBase.Oid into #SummaryValuationToDelete
	From dbo.SummaryValuationBase
	Where dbo.SummaryValuationBase.Asset in
	(select * from #assetstodelete)

	-- Put Other Summaries Class Here
	

	--
	Print('Delete Summary Valution Base')
	Delete 
	From dbo.SummaryValuationBase
	Where dbo.SummaryValuationBase.Oid in
	 ( Select * from #SummaryValuationToDelete )
	
	--=============================================
	--  Delete Replacement Cost
	--=============================================
	Print('Prepare Replacement Cost Table to delete')
	IF OBJECT_ID('tempdb..#ReplacementCostToDelete') IS NOT NULL
		DROP TABLE #ReplacementCostToDelete
	Select dbo.ReplacementCost.Oid into #ReplacementCostToDelete
	From dbo.ReplacementCost
	Where dbo.ReplacementCost.Asset in 
	(select * from #assetstodelete)

	Print('Delete Replacement Cost Details')
	-- Delete Replacement Cost Detail Component
	Update [dbo].[ComponentInput]
	Set [dbo].[ComponentInput].[ReplacementCostDetailApportionment] = null
	where [dbo].[ComponentInput].[ReplacementCostDetailApportionment] in
	(
		Select dbo.ReplacementCostDetailComponent.Oid
		From dbo.ReplacementCostDetailComponent
		Where dbo.ReplacementCostDetailComponent.ReplacmentCost in 
		(Select * From #ReplacementCostToDelete)
	)

	Delete 
	From dbo.ReplacementCostDetailComponent
	Where dbo.ReplacementCostDetailComponent.ReplacmentCost in 
	(Select * From #ReplacementCostToDelete)
	

	Print('Delete Replacement Cost Apportionment')

	--Select *
	--From dbo.ReplacementCostApportionment
	--Where dbo.ReplacementCostApportionment.Oid in 
	--	(select * from #ReplacementCostToDelete)

	Delete
	From dbo.ReplacementCostApportionment
	Where dbo.ReplacementCostApportionment.Oid in 
		(select * from #ReplacementCostToDelete)

	Print('Delete Replacement Cost Direct Cost')
	
	--Select *
	--From dbo.ReplacementCostDirectCost
	--Where dbo.ReplacementCostDirectCost.Oid in 
	--	(select * from #ReplacementCostToDelete)

	Delete
	From dbo.ReplacementCostDirectCost
	Where dbo.ReplacementCostDirectCost.Oid in 
		(select * from #ReplacementCostToDelete)

	Print('Delete Replacement Cost')

	--Select *
	--From dbo.ReplacementCost
	--Where dbo.ReplacementCost.Oid in 
	--	(select * from #ReplacementCostToDelete)

	Delete
	From dbo.ReplacementCost
	Where dbo.ReplacementCost.Oid in 
		(select * from #ReplacementCostToDelete)
	
    --		=============================================
	--			Delete Asset Attributes
	--		=============================================
	Print('Prepare Attribute table to delete')
	
	Select Oid  into #assetAttributesToDelete
	From dbo.AssetAttribute
	Where dbo.AssetAttribute.Asset in 
	(select * from #assetstodelete)

	Print ('Delete Attributes')
	 Delete 
	 From dbo.AssetAttribute
	 Where dbo.AssetAttribute.Oid in (Select * From #assetAttributesToDelete)

	 Delete 
	 From dbo.CharacteristicsItemBase
	 Where dbo.CharacteristicsItemBase.Oid in (Select * From #assetAttributesToDelete)

	IF OBJECT_ID('tempdb..#assetAttributesToDelete') IS NOT NULL
		DROP TABLE #assetAttributesToDelete

	--=============================================
	--  Delete ComponentInput
	--=============================================
	
	Print('Prepare component table to delete')
	IF OBJECT_ID('tempdb..#ComponentInputToDelete') IS NOT NULL
		DROP TABLE #ComponentInputToDelete
	Select dbo.ComponentInput.Oid into #ComponentInputToDelete
	From dbo.ComponentInput
	where dbo.ComponentInput.Asset in 
	(select * from #assetstodelete)


	Print('Delete Component Validation Report')
	 Delete 
	 from [dbo].[ComponentValidationReport]
	 where [dbo].[ComponentValidationReport].[Component] in
	 (
	  Select * From #ComponentInputToDelete
	 )



	Print('Delete Component Input')

	Delete 
	From dbo.ComponentInput
	Where dbo.ComponentInput.Oid in
	(
	Select * From #ComponentInputToDelete
	)
	--=============================================
	--  Delete Asset
	--=============================================

	Print('Delete Asset')

	Delete
	From dbo.Asset
	Where [Oid]
	in(select * from #assetstodelete)

	--=============================================
	--  Delete Asset Validation Report
	--=============================================
	Print('Delete Asset Validation Report')
	Delete
	From dbo.AssetValidationReport
	Where dbo.AssetValidationReport.Asset in
	(select * from #assetstodelete)

	--=============================================
	--  Delete Asset Level Report
	--=============================================
	Print('Delete Asset Level Report')
	Delete
	From dbo.AssetLevelReport
	Where dbo.AssetLevelReport.Asset in
	(select * from #assetstodelete)

	--=============================================
	--  Delete Financial Classification
	--=============================================

	Print('Delete Financial Reporting Classisfication')

	Delete
	From dbo.FinancialReportingClassification
	where dbo.FinancialReportingClassification.Asset in  
	( Select * from #assetstodelete )

	IF OBJECT_ID('tempdb..#ComponentInputToDelete') IS NOT NULL
		DROP TABLE #ComponentInputToDelete
	IF OBJECT_ID('tempdb..#ReplacementCostToDelete') IS NOT NULL
		DROP TABLE #ReplacementCostToDelete
	IF OBJECT_ID('tempdb..#assetstodelete') IS NOT NULL
		DROP TABLE #assetstodelete
	IF OBJECT_ID('tempdb..#SummaryValuationToDelete') IS NOT NULL
		DROP TABLE #SummaryValuationToDelete
	IF OBJECT_ID('tempdb..#MarketValuetoDelete') IS NOT NULL
		DROP TABLE #MarketValuetoDelete
	IF OBJECT_ID('tempdb..#VacantLandtoDelete') IS NOT NULL
		DROP TABLE #VacantLandtoDelete
	IF OBJECT_ID('tempdb..#CapitalisationOfIncometoDelete') IS NOT NULL
		DROP TABLE #CapitalisationOfIncometoDelete
	IF OBJECT_ID('tempdb..#DirectComparisontoDelete') IS NOT NULL
		DROP TABLE #DirectComparisontoDelete
	IF OBJECT_ID('tempdb..#InsuranceValuationtoDelete') IS NOT NULL
	DROP TABLE #InsuranceValuationtoDelete
End



GO


