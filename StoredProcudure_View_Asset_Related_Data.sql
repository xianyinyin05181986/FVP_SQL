/****** Script for SelectTopNRows command from SSMS  ******/
Select [Oid] 
From [dbo].[AssetRegister]
Where [Oid] = '5C809F30-8419-49D1-A13B-044FD7E40ABF'

Drop PROCEDURE [dbo].[Asset_data_View]
GO

CREATE PROCEDURE [dbo].[Asset_data_View]
	@assetOid uniqueidentifier
AS
BEGIN
	
	
		--Delete From Valuer
		Select [dbo].[Valuer].[Oid] AS ValuerOid
		From [dbo].[Valuer]
		Where [dbo].[Valuer].[Asset] in
		(
			Select [Oid]
			From [dbo].[Asset]
			Where [Oid] in
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)
		)
		
		--Delete From Location
		Select [Oid] AS LocationOid
		From [dbo].[Location]
		Where [Oid] in 
		(
			Select [Location]
			From [dbo].[Asset]
			Where [Oid] in
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)
		)
		--Delete Replacement Cost Details
		Select [Oid] AS ReplacementCostDetailOid
		From  [dbo].[ReplacementCostDetailComponent]
		Where [ReplacmentCost] in 
		(
			Select [Oid] AS ReplacementCostDirectCostOid
			From [dbo].[ReplacementCostDirectCost]
			Where [Oid] in
			(
				Select [ReplacementCostDirectCost]
				From [dbo].[Asset]
				Where [Oid] in
				(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
				)
			)
		)
		--Delete Replacement Cost Apportionment
		Select [Oid] AS ReplacementCostApportionmentOid
		From [dbo].[ReplacementCostApportionment]
		Where [Oid] in
		(
			Select [ReplacementCostApportionment]
			From [dbo].[Asset]
			Where [Oid] in
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)
		)
		-- Delete Replacement Cost Direct Cost
		Select [Oid] AS ReplacementCostDirectCostOid
		From [dbo].[ReplacementCostDirectCost]
		Where [Oid] in
		(
			Select [ReplacementCostDirectCost]
			From [dbo].[Asset]
			Where [Oid] in
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)
		)

		-- Delete Replacement Cost
		Select [Oid] AS ReplacementOid
		From [dbo].[ReplacementCost]
		Where [Asset] in 
		(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
		)
		--Delete Insurance Valuation
		Select [Oid] AS InsuranceOid
		From [dbo].[InsuranceValuation]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] =@assetOid
		)
		-- Delete GrossIncome
		Select [Oid] AS GrossOid
		From [dbo].[GrossIncome]
		Where [CapitalisationOfincome] in 
		(
				Select [CapitalisationOfIncome]
				From [dbo].[MarketValue] 
				Where [Asset] in 
				(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
				)	
			
		)
		-- Delete Expense
		Select [Oid] As ExpenseOid
		From [dbo].[Expense]
		Where [CapitalisationOfincome] in 
		(
			
				Select [CapitalisationOfIncome]
				From [dbo].[MarketValue] 
				Where [Asset] in 
				(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
				)	
			
		)
		-- Delete CapitalisationOfIncome
		Select [Oid] As CapitalisationOfIncomeOid
		From [dbo].[CapitalisationOfIncome]
		Where [Oid] In 
		(
			Select [CapitalisationOfIncome]
			From [dbo].[MarketValue] 
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)	
		)
		-- Delete File For Direcot Comparison Detail
		 Select [Oid] AS DirecotComparisonDetailFileOid
		 From [dbo].[FileData]
		 Where [Oid] in 
		 (
			Select  [File]
			From [dbo].[DirectComparisonSale]
			Where [DirectComparison] in
			(
				Select [DirectComparison]
				From [dbo].[MarketValue] 
				Where [Asset] in 
				(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
				)	
			)
		 )
		-- Delete Direcot Comparison Detail
		Select [Oid] As DirectComparisonDetailOid
		From [dbo].[DirectComparisonSale]
		Where [DirectComparison] in
		(
			Select [DirectComparison]
			From [dbo].[MarketValue] 
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)	
		)

		-- Delete Direcot Comparison
		Select [Oid] As DirectComparisonOid
		From [dbo].[DirectComparison]
		Where [Oid] In 
		(
			Select [DirectComparison]
			From [dbo].[MarketValue] 
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)	
		)
		-- Delete File For Vacant Land Sale
		 Select [Oid] AS VacantLandFileOid
		 From [dbo].[FileData]
		 Where [Oid] in 
		 (
			Select [File]
			From [dbo].[VacantLandSale]
			Where [VacantLand] in 
			(
				Select [VacantLand]
				From [dbo].[MarketValue] 
				Where [Asset] in 
				(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
				)	
			)
		 )
		-- Delete Vacant Land Sale
		Select [Oid] As VacantLandSale
		From [dbo].[VacantLandSale]
		Where [VacantLand] in 
		(
			Select [VacantLand]
			From [dbo].[MarketValue] 
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)	
		)
		-- Delete Vacant Land
		Select * 
		From [dbo].[VacantLand]
		Where [Oid] In 
		(
			Select [VacantLand]
			From [dbo].[MarketValue] 
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)	
		)
		-- Delete Market Value
		Select [Oid] AS MarketValueOid
		From [dbo].[MarketValue] 
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		-- Delete [ComponentValuation]
		Select [Oid] AS ComponentValuation
		From [dbo].[Phase2ComponentValuation]
		where [SummaryValuation] In 
		(
			Select [Oid] 
			From [dbo].[SummaryValuationBase]
			Where [Asset] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)		
		)
		-- Delete [CostSummaryValuation]
		Select [Oid] AS SummaryValuationOid
		From [dbo].[SummaryValuationBase]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		-- Delete [MarketSummaryValuation]
		-- Delete [IncomeSummaryValuation]
		-- Delete [CombinedSummaryValuation]
		-- Delete [PreviousValuation]
		Select [Oid] AS SummaryValuationOid
		From [dbo].[SummaryValuationBase]
		Where [Oid] in 
		(
			Select [PreviousValuation]
			From [dbo].[Asset]
			Where [Oid] in 
			(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
			)
		)
		-- Delete [AnalysisOfApproach]
		Select [Oid] AS [AnalysisOfApproach]
		From [dbo].[AnalysisOfApproach]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		     -- Delete [AssetValidationReport]
            Select [Oid] As AssetValidationReportOid
            From [dbo].[AssetValidationReport]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [AReportUserList]
            Select [Oid] As AReportUserListOid
            From [dbo].[AReportUserList]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [GReportJobHistory]
           
            -- Delete [GReportAssetClass]
          
            -- Delete [AssetLevelReport]
            Select [Oid] As AssetLevelReportOid
            From [dbo].[AssetLevelReport]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [GReportReplacementCost]
            Select [Oid] As GReportReplacementCostOid
            From [dbo].[GReportReplacementCost]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [GReportMiscDataAssetLevel]
            Select [Oid] As GReportMiscDataAssetLevelOid
            From [dbo].[GReportMiscDataAssetLevel]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportValuationStatus]
            Select [Oid] As JReportValuationStatusOid
            From [dbo].[JReportValuationStatus]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportInspectionStatus]
            Select [Oid] As JReportInspectionStatusOid
            From [dbo].[JReportInspectionStatus]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportSamplingSummary]
            Select [Oid] As JReportSamplingSummaryOid
            From [dbo].[JReportSamplingSummary]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportAssetHistory]
            Select [Oid] As JReportAssetHistoryOid
            From [dbo].[JReportAssetHistory]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportDistributionByScore]
            Select [Oid] As JReportDistributionByScoreOid
            From [dbo].[JReportDistributionByScore]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportDistributionOfValues]
            Select [Oid] As JReportDistributionOfValuesOid
            From [dbo].[JReportDistributionOfValues]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportRangeOfInputs]
            Select [Oid] As JReportRangeOfInputsOid
            From [dbo].[JReportRangeOfInputs]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportStatistical]
            Select [Oid] As JReportStatisticalOid
            From [dbo].[JReportStatistical]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
	
		--Delete Asset Attribute
		Select [Oid] As AssetAttribute
		From [dbo].[AssetAttribute]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		--Delete Holistic Item
		Select [Oid] As HolisticItem
		From [dbo].[HolisticItem]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )

		-- Delete ComponentInput 
		Select [Oid] As ComponentInputOid
		From [dbo].[ComponentInput]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		-- Delete CharacteristicsItem
		Select [Oid] As [CharacteristicsItem]
		From [dbo].[CharacteristicsItem]
		Where [ComponentInput] in
		(
			Select [Oid] 
			From [dbo].[ComponentInput]
			Where [Asset] in 
				(
					  Select [Asset] 
					  From [dbo].[AssetRegister]
					  Where [Oid] = @assetOid
				)
		)

		IF EXISTS
		(
			Select * 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		--Delete From Asset Table
		Select *
		From [dbo].[Asset]
		Where [Oid] in
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)

		--Delete From FinancialReportingClassification
		Select [dbo].[FinancialReportingClassification].[Oid] as FinancialReportingClassificationOid
		From [dbo].[FinancialReportingClassification]
		Where  [dbo].[FinancialReportingClassification].[Asset] in
		(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
		)

		--Delete Asset Register
		Select *
		From [dbo].[AssetRegister]
		where [Oid] =@assetOid

		--Delete From Valuation Choice Table
	    Select *
		From [dbo].[ValuationChoices]
		Where [Oid] in 
		(
			Select [ValuationChoices] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		
END			
GO

exec [dbo].[Asset_data_View] '5C809F30-8419-49D1-A13B-044FD7E40ABF'--