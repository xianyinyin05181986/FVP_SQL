/****** Script for SelectTopNRows command from SSMS  ******/

Drop PROCEDURE [dbo].[Asset_data_Deletion]
GO

CREATE PROCEDURE [dbo].[Asset_data_Deletion]
	@assetOid uniqueidentifier
AS
BEGIN
		--Delete From Valuer
		Delete
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
		Delete
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
		Delete
		From  [dbo].[ReplacementCostDetailComponent]
		Where [ReplacmentCost] in 
		(
			Select [Oid] 
			From [dbo].[ReplacementCost]
			Where [Asset] in 
			(
					Select [Asset] 
					From [dbo].[AssetRegister]
					Where [Oid] = @assetOid
			)
		)

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
		Delete
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
		Delete
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
		Delete
		From [dbo].[ReplacementCost]
		Where [Asset] in 
		(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
		)
		
		Select [Oid] AS ReplacementOid
		From [dbo].[ReplacementCost]
		Where [Asset] in 
		(
				Select [Asset] 
				From [dbo].[AssetRegister]
				Where [Oid] = @assetOid
		)
		--Delete Insurance Valuation
		Delete
		From [dbo].[InsuranceValuation]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] =@assetOid
		)

		Select [Oid] AS InsuranceOid
		From [dbo].[InsuranceValuation]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] =@assetOid
		)
		-- Delete GrossIncome
		Delete
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
		Delete
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
		Delete
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
		 Delete
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
		Delete
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
		Delete
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
		 Delete
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
		Delete
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
		Delete
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

		Select [Oid] AS VacantLandOid 
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
		Delete
		From [dbo].[MarketValue] 
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)

		Select [Oid] AS MarketValueOid
		From [dbo].[MarketValue] 
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		-- Delete [ComponentValuation]
		Delete
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
		-- Delete [MarketSummaryValuation]
		-- Delete [IncomeSummaryValuation]
		-- Delete [CombinedSummaryValuation]
		Delete
		From [dbo].[SummaryValuationBase]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		
		Select [Oid] AS SummaryValuationOid
		From [dbo].[SummaryValuationBase]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		
		-- Delete [PreviousValuation]
		Delete
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
		Delete
		From [dbo].[AnalysisOfApproach]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)

		Select [Oid] AS [AnalysisOfApproach]
		From [dbo].[AnalysisOfApproach]
		Where [Asset] in 
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)
		
       -- Delete [AReportUserList]
            Delete
            From [dbo].[AReportUserList]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [GReportJobHistory]
           
            -- Delete [GReportAssetClass]
            
            -- Delete [GReportReplacementCost]
            Delete
            From [dbo].[GReportReplacementCost]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [GReportMiscDataAssetLevel]
            Delete
            From [dbo].[GReportMiscDataAssetLevel]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportValuationStatus]
            Delete
            From [dbo].[JReportValuationStatus]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportInspectionStatus]
            Delete
            From [dbo].[JReportInspectionStatus]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportSamplingSummary]
            Delete
            From [dbo].[JReportSamplingSummary]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportAssetHistory]
            Delete
            From [dbo].[JReportAssetHistory]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportDistributionByScore]
            Delete
            From [dbo].[JReportDistributionByScore]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportDistributionOfValues]
           Delete
            From [dbo].[JReportDistributionOfValues]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportRangeOfInputs]
          Delete
            From [dbo].[JReportRangeOfInputs]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
            -- Delete [JReportStatistical]
          Delete
            From [dbo].[JReportStatistical]
            Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		
	--Delete Asset Attribute
		Delete
		From [dbo].[AssetAttribute]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		--Delete Holistic Item
		Delete
		From [dbo].[HolisticItem]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		-- Delete CharacteristicsItem
		Delete
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
		-- Delete Component Valuation Report
		Delete
		From [dbo].[ComponentValidationReport]
		Where [Component] In
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

		-- Delete ComponentInput 
		Delete
		From [dbo].[ComponentInput]
		Where [Asset] in 
            (
                  Select [Asset] 
                  From [dbo].[AssetRegister]
                  Where [Oid] = @assetOid
            )
		
		-- Delete Asset Register
		Delete
		From [dbo].[AssetRegister]
		where [Oid] =@assetOid

		Select *
		From [dbo].[Asset]
		Where [Oid] in
		(
			Select [Asset] 
			From [dbo].[AssetRegister]
			Where [Oid] = @assetOid
		)


		--Delete From Asset Table
		Delete
		From [dbo].[Asset]
		Where [AssetRegister] =@assetOid

		--Delete From FinancialReportingClassification
		Delete
		From   [dbo].[FinancialReportingClassification]
		Where  [dbo].[FinancialReportingClassification].[Asset] Not in
		(
				Select [Oid]
				From [dbo].[Asset]
		)
		Select [dbo].[FinancialReportingClassification].[Oid] as FinancialReportingClassificationOid
		From   [dbo].[FinancialReportingClassification]
		Where  [dbo].[FinancialReportingClassification].[Asset] Not in
		(
				Select [Oid]
				From [dbo].[Asset]
		)
		 -- Delete [AssetValidationReport]
            Delete
            From [dbo].[AssetValidationReport]
           Where [Asset] Not in 
            (
                  Select [Oid] 
                  From [dbo].[Asset]
            )

			-- Delete [AssetLevelReport]
			Delete
            From [dbo].[AssetLevelReport]
            Where [Asset] Not in 
            (
                  Select [Oid] 
                  From [dbo].[Asset]
            )

	
		-- View Asset Register
		Select *
		From [dbo].[AssetRegister]
		where [Oid] =@assetOid
		-- Delete From Valuation Choice Table
		Delete
		From [dbo].[ValuationChoices]
		Where [Oid] Not in 
		(
			Select [ValuationChoices] 
			From [dbo].[AssetRegister]
			
		)
		Select [Oid] as ValuationChoiceOid
		From [dbo].[ValuationChoices]
		Where [Oid] Not in 
		(
			Select [ValuationChoices] 
			From [dbo].[AssetRegister]
			
		)		
END			
GO

exec [dbo].[Asset_data_Deletion] '5C809F30-8419-49D1-A13B-044FD7E40ABF'
	    Select *
		From [dbo].[Asset]
		Where [AssetRegister] = '5C809F30-8419-49D1-A13B-044FD7E40ABF'
--exec [dbo].[Asset_data_View] '5C809F30-8419-49D1-A13B-044FD7E40ABF'