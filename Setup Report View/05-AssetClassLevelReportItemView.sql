USE [fvp-database]
GO

/****** Object:  View [dbo].[AssetClassLevelReportView]    Script Date: 7/11/2016 5:47:01 PM ******/
DROP VIEW [dbo].[AssetClassLevelReportView]
GO

/****** Object:  View [dbo].[AssetClassLevelReportView]    Script Date: 7/11/2016 5:47:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[AssetClassLevelReportView]
AS
SELECT                  ROW_NUMBER() Over (ORDER BY dbo.Job.Name ASC,dbo.AssetHierarchy.Name ASC) AS Row#
						,dbo.AssetHierarchy.Name AS AssetClass
						,COUNT(dbo.AssetRegister.Oid) AS NoOfAsset
						, dbo.Job.Name AS Job
						, dbo.FairValueProClient.Name  AS Client
						 , dbo.FinancialAssetClass.Name AS FinancialAssetClass
						 , dbo.FinancialAssetType.Name AS FinancialSubClass
						 , dbo.FairValueMeasurementClass.Name AS FVM
						, COUNT(dbo.FinancialReportingClassification.Oid) AS NoOfFinancialReportingClassification
						, dbo.AssetRegister.ControledforFinancialPurpose AS ControlledForFinancialPurpose
						, Case When SUM(dbo.SummaryValuationView.GROSSMV) is Null then 0 Else SUM(dbo.SummaryValuationView.GROSSMV) End AS GrossOrMv
						, Case When SUM(dbo.SummaryValuationView.Accumulated_Depreciation) is Null then 0 Else SUM(dbo.SummaryValuationView.Accumulated_Depreciation) End AS Accumulated_Depreciation
						, Case When SUM(dbo.SummaryValuationView.FairValue) is Null then 0 Else SUM(dbo.SummaryValuationView.FairValue) End AS FV
						, Case When SUM(dbo.SummaryValuationView.Depreciation_Expense) is Null then 0 Else SUM(dbo.SummaryValuationView.Depreciation_Expense) End AS Depreciation_Expense
						, COUNT(dbo.SummaryValuationBase.Oid) AS NoPreviousValuationOid
						, Case When SUM(SummaryValuationView_1.GROSSMV) is Null then 0 Else SUM(SummaryValuationView_1.GROSSMV) End AS PreviousGross
						, Case When SUM(SummaryValuationView_1.FairValue) is Null then 0 Else SUM(SummaryValuationView_1.FairValue) End AS PreviousFairValue
						, Case When SUM(SummaryValuationView_1.Depreciation_Expense) is Null then 0 Else SUM(SummaryValuationView_1.Depreciation_Expense) End AS PreviousExpense
						, dbo.Job.Oid AS JobOid
						, dbo.FairValueProClient.Oid AS ClientOid
						, dbo.FairValueProClient.[Group] AS GroupOid
FROM                     dbo.SummaryValuationView 
						Right Outer JOIN dbo.Asset ON dbo.Asset.Oid = dbo.SummaryValuationView.AssetOid 
						INNER JOIN
                         dbo.AssetHierarchy ON dbo.Asset.AssetClass = dbo.AssetHierarchy.Oid INNER JOIN
                         dbo.AssetRegister ON dbo.AssetRegister.Oid = dbo.Asset.AssetRegister INNER JOIN
                         dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid INNER JOIN
                         dbo.FairValueProClient ON dbo.Job.Client = dbo.FairValueProClient.Oid INNER JOIN
                         dbo.FinancialReportingClassification ON dbo.Asset.FinancialReportingClassification = dbo.FinancialReportingClassification.Oid 
						
						 LEFT OUTER JOIN
                         dbo.SummaryValuationView AS SummaryValuationView_1 ON dbo.Asset.PreviousValuation = SummaryValuationView_1.ValuationId 
						 LEFT OUTER JOIN
                         dbo.SummaryValuationBase ON dbo.Asset.PreviousValuation = dbo.SummaryValuationBase.Oid LEFT OUTER JOIN
                         dbo.FinancialAssetClass ON dbo.FinancialReportingClassification.FinancialAssetClass = dbo.FinancialAssetClass.Oid LEFT OUTER JOIN
                         dbo.FinancialAssetType ON dbo.FinancialReportingClassification.FinancialAssetSubClass = dbo.FinancialAssetType.Oid LEFT OUTER JOIN
                         dbo.FairValueMeasurementClass ON dbo.FinancialReportingClassification.FairValueMeasurementClass = dbo.FairValueMeasurementClass.Oid 
Group BY		 dbo.AssetHierarchy.Name
				--, dbo.AssetRegister.Name
				, dbo.Job.Name
				, dbo.FairValueProClient.Name
				, dbo.FinancialAssetClass.Name
				, dbo.FinancialAssetType.Name
				, dbo.FairValueMeasurementClass.Name
				--, dbo.FinancialReportingClassification.Oid
				, dbo.AssetRegister.ControledforFinancialPurpose
				--, dbo.SummaryValuationView.GROSSMV
				--, dbo.SummaryValuationView.Accumulated_Depreciation
				--, dbo.SummaryValuationView.FairValue
				--, dbo.SummaryValuationView.Depreciation_Expense
				--, dbo.SummaryValuationBase.Oid
				--, SummaryValuationView_1.GROSSMV
				--, SummaryValuationView_1.FairValue
				--, SummaryValuationView_1.Depreciation_Expense
				, dbo.Job.Oid, dbo.FairValueProClient.Oid
				, dbo.FairValueProClient.[Group]

GO


