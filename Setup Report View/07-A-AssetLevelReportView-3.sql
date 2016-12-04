
/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 21/11/2016 1:48:01 PM ******/
DROP VIEW [dbo].[AssetLevelReportView]
GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 21/11/2016 1:48:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[AssetLevelReportView]
AS
SELECT        dbo.AssetHierarchy.Name AS AssetClassName
			, dbo.AssetType.Name AS AssetTypeName
			, dbo.AssetSubType.Name AS AssetSubTypeName
			, dbo.AssetRegister.Oid AS AssetRegisterOid
			, dbo.AssetRegister.Client AS ClientOid
			, dbo.Job.Name AS JobName
			, dbo.AssetRegister.Job AS JobOid
			, dbo.Job.JobStatus
			, dbo.AssetRegister.Name AS AssetName
			, dbo.AssetRegister.AssetId
			, dbo.AssetRegister.Facility
			, dbo.MyAddress.StreetAddress
			, dbo.MyAddress.Suburb
			, dbo.MyAddress.Town
			, dbo.MyAddress.State
			, dbo.MyAddress.Country
			, dbo.MyAddress.PostCode
			, dbo.AssetRegister.ToBeValued
			, dbo.SummaryValuationView.Accumulated_Depreciation AS PreviousDepreciation
			, dbo.SummaryValuationView.FairValue AS PreviousFairValue
			, dbo.SummaryValuationView.GROSSMV AS PreviousGrossOrMv
			, SummaryValuationView_1.GROSSMV
			, SummaryValuationView_1.FairValue AS FAIRVALUE
			, SummaryValuationView_1.Accumulated_Depreciation
			, dbo.FinancialReportingClassification.PrevHAndBUse
			, dbo.FinancialReportingClassification.PrevFVMInputLevel
			, dbo.FinancialReportingClassification.PrevFVMTechnique
			, dbo.FinancialReportingClassification.HAndBUse
			, dbo.FinancialReportingClassification.Comment
			, dbo.FinancialReportingClassification.FairValueMeasurementClass
			, dbo.FinancialReportingClassification.FinancialAssetSubClass
			, dbo.FinancialReportingClassification.FinancialAssetClass
			, dbo.AssetRegister.HeldforSaleorInvestment
			, dbo.AssetRegister.ControledforFinancialPurpose
			, dbo.FinancialAssetClass.Name AS FinnacialAssetClassName
			, dbo.FinancialAssetType.Name AS FinancialSubClassName
			, dbo.FairValueMeasurementClass.Name AS FVMClass
			, dbo.FairValueMeasurementClass.FVMHierachy As CurrentFVMHierarchy
			, dbo.FairValueMeasurementClass. [FVMapproach]As CurrentFVMTechnique
			, dbo.Asset.InsuranceValuation AS InsuranceOid
			, dbo.Job.JobNumber
FROM            
                         dbo.FinancialAssetClass inner JOIN
                         dbo.FinancialReportingClassification ON dbo.FinancialAssetClass.Oid = dbo.FinancialReportingClassification.FinancialAssetClass inner JOIN
                         dbo.FinancialAssetType ON dbo.FinancialReportingClassification.FinancialAssetSubClass = dbo.FinancialAssetType.Oid inner JOIN
                         dbo.FairValueMeasurementClass ON dbo.FinancialReportingClassification.FairValueMeasurementClass = dbo.FairValueMeasurementClass.Oid 
						  Right Outer join dbo.Asset 
						  ON dbo.Asset.FinancialReportingClassification = dbo.FinancialReportingClassification.Oid inner JOIN
                         dbo.SummaryValuationView AS SummaryValuationView_1 ON dbo.Asset.Oid = SummaryValuationView_1.AssetOid LEFT OUTER JOIN
                         dbo.SummaryValuationView ON dbo.Asset.PreviousValuation = dbo.SummaryValuationView.ValuationId RIGHT OUTER JOIN
                         dbo.AssetRegister inner JOIN
                         dbo.MyAddress ON dbo.AssetRegister.DefaultAddress = dbo.MyAddress.Oid ON dbo.Asset.Oid = dbo.AssetRegister.Asset LEFT OUTER JOIN
                         dbo.AssetHierarchy ON dbo.AssetRegister.AssetClass = dbo.AssetHierarchy.Oid LEFT OUTER JOIN
                         dbo.AssetType ON dbo.AssetRegister.AssetType = dbo.AssetType.Oid LEFT OUTER JOIN
                         dbo.AssetSubType ON dbo.AssetRegister.AssetSubType = dbo.AssetSubType.Oid LEFT OUTER JOIN
                         dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid
						
WHERE        (dbo.AssetRegister.GCRecord IS NULL)






GO


