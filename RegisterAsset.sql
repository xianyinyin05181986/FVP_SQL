USE [fvp-database]
GO

/****** Object:  StoredProcedure [dbo].[RegisterAsset]    Script Date: 30/11/2016 2:53:47 PM ******/
DROP PROCEDURE [dbo].[RegisterAsset]
GO

/****** Object:  StoredProcedure [dbo].[RegisterAsset]    Script Date: 30/11/2016 2:53:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Yinyin Xian
-- Create date: 23rd Nov 2016
-- Description:	Register An Asset By Asset ID
-- =============================================
CREATE PROCEDURE [dbo].[RegisterAsset]
	-- Add the parameters for the stored procedure here
	@assetRegisterOid uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @assetoid uniqueidentifier
	, @assetname nvarchar(100)
	, @clientOid uniqueidentifier
	, @fairValueProGroupOid uniqueidentifier
	, @assetClassOid uniqueidentifier
	, @assetTypeOid uniqueidentifier
	, @assetSubTypeOid uniqueidentifier
	, @valuerName nvarchar(100)
    -- Insert statements for procedure here
	SELECT   @assetOid = dbo.AssetRegister.Asset 
			,@assetname = dbo.AssetRegister.Name
			,@clientOid = dbo.AssetRegister.Client
			,@assetClassOid = dbo.AssetRegister.AssetClass
			,@assetTypeOid = dbo.AssetRegister.AssetType
			,@assetSubTypeOid = dbo.AssetRegister.AssetSubType
			,@fairValueProGroupOid=dbo.AssetRegister.FairValueProGroup
			,@valuerName =dbo.AssetRegister.ValuerName
	From dbo.AssetRegister
	Where dbo.AssetRegister.GCRecord is null
			And dbo.AssetRegister.Oid = @assetRegisterOid
 
	If @assetoid is not null
		Begin
			Print 'Not Need to Initalise Asset'
		End   
    Else
	   Begin
			Print 'Asset is Null Begin Register'
			Declare @newassetOid uniqueidentifier
				, @valuerOid uniqueidentifier 
				, @financialReportingClassificationOid uniqueidentifier
				, @replacementCostApportionmentOid uniqueidentifier
				, @replacementCostDirectCostOid uniqueidentifier
				, @insuranceValuationOid uniqueidentifier
				, @marketValueOid uniqueidentifier
				, @costSummaryValuationOid uniqueidentifier
				, @marketSummaryValuationOid uniqueidentifier
				, @incomeSummaryValuationOid uniqueidentifier
				, @combinedSummaryValuationOid uniqueidentifier
				, @analysisOfApproachOid uniqueidentifier
				, @assetValidationReportOid uniqueidentifier
				, @aReportUserListOid uniqueidentifier
				, @assetLevelReportOid uniqueidentifier

				Set @newassetOid = NEWID()

				Set @valuerOid = NEWID()
				--======================
				--  Start Insert Valuer
				--======================
				Insert into dbo.Valuer
						(
						 [Oid]
						,[Client]
						,[FairValueProGroup]
						,[Asset]
						,[Name]
						)
					Values 
					(
						@valuerOid,
						@clientOid,
						@fairValueProGroupOid,
						@newassetOid,
						'Valuer'
					)
				--======================
				--  Finish Insert Valuer
				--======================
				
				--=================================================
				--  Financial Reporting Classification Insert Start
				--=================================================
				Set @financialReportingClassificationOid = NEWID()
				IF (@assetSubTypeOid is not null)
					Begin
					Declare @financialAssetClassOid uniqueidentifier,
							@financialAssetTypeOid uniqueidentifier,
							@fairValueMeasurementClassOid uniqueidentifier
						Select 
						@financialAssetClassOid = dbo.General.FinancialAssetClass,
						@financialAssetTypeOid =dbo.General.FinancialAssetType,
						@fairValueMeasurementClassOid =dbo.General.FairValueMeasurementClass
						From dbo.General
						where dbo.General.AssetSubType =@assetSubTypeOid and dbo.General.Client =@clientOid

						Insert into [dbo].[FinancialReportingClassification]
						(
								 Oid,
								Asset,
								Client,
								FairValueProGroup,
								Name,
								FinancialAssetClass,
								FinancialAssetSubClass,
								FairValueMeasurementClass
						)
						Values
						(
								@financialReportingClassificationOid,
								@newassetOid,
								@clientOid,
								@fairValueProGroupOid,
								'Financial Reporting Classification',
								@financialAssetClassOid,
								@financialAssetTypeOid,
								@fairValueMeasurementClassOid
						)


					End
				Else
					Begin
						Insert into [dbo].[FinancialReportingClassification]
						(
								 Oid,
								Asset,
								Client,
								FairValueProGroup,
								Name
						)
						Values
						(
						@financialReportingClassificationOid,
								@newassetOid,
								@clientOid,
								@fairValueProGroupOid,
								'Financial Reporting Classification'
						)
					End
				

				--=================================================
				--  Financial Reporting Classification Insert End
				--=================================================


				--=============================================
				--  Start Insert ReplacementCost Apportionment
				--=============================================
				Set @replacementCostApportionmentOid = NEWID()
				Insert into dbo.ReplacementCost
					(
						Oid,
						Asset,
						Client,
						FairValueProGroup,
						Name,
						ObjectType
					)
					Values
					(
						@replacementCostApportionmentOid,
						@newassetOid,
						@clientOid,
						@fairValueProGroupOid,
						'Replacement Cost Apportionment',
						58
					)
				Insert into dbo.ReplacementCostApportionment
					(
						Oid
					)
					Values
					(
						@replacementCostApportionmentOid
					)
				--=============================================
				--  Finish Insert ReplacementCost Apportionment
				--=============================================





				--=============================================
				--  Start Insert ReplacementCost Direct Cost
				--=============================================
				
				Set @replacementCostDirectCostOid = NEWID()
				
				Insert into dbo.ReplacementCost
					(
						Oid,
						Asset,
						Client,
						FairValueProGroup,
						Name,
						ObjectType
					)
					Values
					(
						@replacementCostDirectCostOid,
						@newassetOid,
						@clientOid,
						@fairValueProGroupOid,
						'Replacement Cost Direct Cost',
						57
					)
				Insert into dbo.ReplacementCostDirectCost
					(
						Oid
					)
					Values
					(
						@replacementCostDirectCostOid
					)
				--=============================================
				--  Finish Insert ReplacementCost Direct Cost
				--=============================================

				--=============================================
				--  Insurance Valuation Insert Start
				--=============================================

				Set @insuranceValuationOid = NEWID()
				Insert into dbo.InsuranceValuation
					(
						Oid,Name,Asset,Client,FairValueProGroup
					)
					Values
					(
						@insuranceValuationOid,'Insurance Valuation',@newassetOid,@clientOid,@fairValueProGroupOid
					)
				--=============================================
				--  Insurance Valuation Insert End
				--=============================================


			

				--=============================================
				--  Asset Validation Report Insert Start
				--=============================================
				Set @assetValidationReportOid = NEWID()

				Insert into dbo.AssetValidationReport
				(
					Oid,Asset,Client,FairValueProGroup
				)
				Values
				(
					@assetValidationReportOid,@newassetOid,@clientOid,@fairValueProGroupOid
				)
				--=============================================
				--  Asset Validation Report Insert End
				--=============================================

				--=============================================
				--  A Report User List Insert Start
				--=============================================
				Set @aReportUserListOid = NEWID()
				Insert into dbo.AReportUserList
				(
					Oid,Asset,Client,FairValueProGroup
				)
				Values
				(
					@aReportUserListOid,@newassetOid,@clientOid,@fairValueProGroupOid
				)
				--=============================================
				--  A Report User List Insert End
				--=============================================

				--=============================================
				--  Asset Level Report Insert Start
				--=============================================
				Set @assetLevelReportOid = NEWID()
				Insert into dbo.AssetLevelReport
				(
					Oid,Asset,Client,FairValueProGroup
				)
				Values
				(
					@assetLevelReportOid,@newassetOid,@clientOid,@fairValueProGroupOid
				)
				--=============================================
				--  Asset Level Report Insert End
				--=============================================
				Set @costSummaryValuationOid = NEWID()
				Set @combinedSummaryValuationOid = NEWID()
				Set @incomeSummaryValuationOid = NEWID()
				Set @marketSummaryValuationOid = NEWID()
				
				Set @analysisOfApproachOid = NEWID()
				Set @marketValueOid = NEWID()
			Print 'Insert Asset'
				 INSERT INTO [dbo].[Asset]
					   ([Oid]
					   ,[Name]
					   ,[Client]
					   ,[FairValueProGroup]
					   ,[AssetRegister]
					   ,[AssetClass]
					   ,[AssetType]
					   ,[AssetSubType]
					   ,[ValuerName]
					   ,[Valuer]
					   ,[FinancialReportingClassification]
					   ,[ReplacementCostApportionment]
					   ,[ReplacementCostDirectCost]
					   ,[InsuranceValuation]
					   ,[MarketValue]
					   ,[CostSummaryValuation]
					   ,[MarketSummaryValuation]
					   ,[IncomeSummaryValuation]
					   ,[CombinedSummaryValuation]
					   ,[AnalysisOfApproach]
					   ,[AssetValidationReport]
					   ,[AReportUserList]
					   ,[AssetLevelReport]
					  )
				 VALUES
					   (@newassetOid
					   ,@assetname
					   ,@clientOid
					   ,@fairValueProGroupOid
					   ,@assetRegisterOid
					   ,@assetClassOid
					   ,@assetTypeOid
					   ,@assetSubTypeOid
					   ,@valuerName
					   ,@valuerOid
					   ,@financialReportingClassificationOid
					   ,@replacementCostApportionmentOid
					   ,@replacementCostDirectCostOid
					   ,@insuranceValuationOid
					   ,@marketValueOid
					   ,@costSummaryValuationOid
					   ,@marketSummaryValuationOid
					   ,@incomeSummaryValuationOid
					   ,@combinedSummaryValuationOid
					   ,@analysisOfApproachOid
					   ,@assetValidationReportOid
					   ,@aReportUserListOid
					   ,@assetLevelReportOid
					 )
				--=============================================
				--  Analysis Of Approach Insert Start
				--=============================================
				Insert into dbo.AnalysisOfApproach
				(
					Oid,Asset,Client,FairValueProGroup,Name
				)
				Values
				(
					@analysisOfApproachOid,@newassetOid,@clientOid,@fairValueProGroupOid,'Combined Approach'
				)
				--=============================================
				--   Analysis Of Approach Insert End
				--=============================================

				
				--=============================================
				--  Market Value Insert Start
				--=============================================

				

				---- Vacant Land

				Declare @newVacantLandOid uniqueidentifier
				Set @newVacantLandOid = NEWID()
				Insert into dbo.VacantLand
				(
					Oid,Client,FairValueProGroup,Name
				)
				Values
				(
					@newVacantLandOid,@clientOid,@fairValueProGroupOid,'Vacant Land'
				)

				--Capitalisation Of Income

				Declare @newCapitalisationOfIncomeOid uniqueidentifier
				Set @newCapitalisationOfIncomeOid = NEWID()
				Insert into dbo.CapitalisationOfIncome
				(
					Oid,Client,FairValueProGroup,Name
				)
				Values
				(
					@newCapitalisationOfIncomeOid,@clientOid,@fairValueProGroupOid,'Capitalisation of Income'
				)

				--Direct Comparison

				
				Declare @newDirectComparisonOid uniqueidentifier
				Set @newDirectComparisonOid = NEWID()
				Insert into dbo.DirectComparison
				(
					Oid,Client,FairValueProGroup,Name
				)
				Values
				(
					@newDirectComparisonOid,@clientOid,@fairValueProGroupOid,'Direct Comparison'
				)

				Insert into dbo.MarketValue
				(
					Oid,Asset,Client,FairValueProGroup,VacantLand,CapitalisationOfIncome,DirectComparison
				)
				Values 
				(
					@marketValueOid,@newassetOid,@clientOid,@fairValueProGroupOid,@newVacantLandOid,@newCapitalisationOfIncomeOid,@newDirectComparisonOid
				)

				--=============================================
				--  Market Value Insert End
				--=============================================
			
				--=============================================
				--  Cost Summary Valuation Insert Start
				--=============================================
				Insert into dbo.SummaryValuationBase
				(
					Oid,
					Asset,
					Client,
					FairValueProGroup,
					Name,
					ObjectType
				)
				Values
				(
					@costSummaryValuationOid,
					@newassetOid,
					@clientOid,@fairValueProGroupOid,'Cost Summary Valuation',62
				)
				--=============================================
				--  Cost Summary Valuation Insert End
				--=============================================

				--=============================================
				--  Market Summary Valuation Insert Start
				--=============================================
				Insert into dbo.SummaryValuationBase
				(
					Oid,Asset,Client,FairValueProGroup,Name,ObjectType
				)
				Values
				(
					@marketSummaryValuationOid,@newassetOid,@clientOid,@fairValueProGroupOid,'Market Summary Valuation',63
				)
			    
				--=============================================
				--  Market Summary Valuation Insert End
				--=============================================

				--=============================================
				--  Income Summary Valuation Insert Start
				--=============================================
				Insert into dbo.SummaryValuationBase
				(
					Oid,Asset,Client,FairValueProGroup,Name,ObjectType
				)
				Values
				(
					@incomeSummaryValuationOid,@newassetOid,@clientOid,@fairValueProGroupOid,'Income Summary Valuation',64
				)
				--=============================================
				--  Income Summary Valuation Insert End
				--=============================================

				--=============================================
				--  Combined Summary Valuation Insert Start
				--=============================================
				Insert into dbo.SummaryValuationBase
				(
					Oid,Asset,Client,FairValueProGroup,Name,ObjectType
				)
				Values
				(
					@combinedSummaryValuationOid,@newassetOid,@clientOid,@fairValueProGroupOid,'Combination Valuation',82
				)

				--=============================================
				--  Combined Summary Valuation Insert End
				--=============================================
				If exists (
					Select [Oid]
					From dbo.AssetRegister
					Where dbo.AssetRegister.Oid = @assetRegisterOid
				)
					Begin
						Print 'Start update Asset Oid in Asset Regitser'
						Update [dbo].AssetRegister 
						Set [dbo].AssetRegister.[Asset] =@newassetOid
						Where dbo.AssetRegister.Oid = @assetRegisterOid
					End
				Else 
					Begin
						Print 'Asset does not exist'
					End
			END
END




GO


