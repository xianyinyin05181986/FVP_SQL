USE [fvp-database]
GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 4/12/2016 9:22:38 AM ******/
DROP VIEW [dbo].[AssetLevel_DISTRIBUTIONOFVALUES_ReportView]
GO

/****** Object:  View [dbo].[AssetLevelReportView]    Script Date: 4/12/2016 9:22:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[AssetLevel_DISTRIBUTIONOFVALUES_ReportView]
AS

SELECT        dbo.AssetHierarchy.Name AS AssetClass
			, dbo.AssetType.Name AS AssetType
			, dbo.AssetSubType.Name AS AssetSubType
			, dbo.AssetRegister.Oid AS AssetRegisterOid
			, dbo.AssetRegister.Client AS ClientOid
			, dbo.Job.Name AS JobName
			, dbo.Job.JobNumber
			, dbo.AssetRegister.Job AS JobOid
			, dbo.AssetRegister.Name AS AssetName
			, dbo.AssetRegister.AssetId
			, dbo.SummaryValuationView.GROSSMV
			, dbo.SummaryValuationView.FairValue AS FAIRVALUE
			, Round (Case When dbo.SummaryValuationView.GROSSMV = 0 or dbo.SummaryValuationView.GROSSMV is null then 0 
			       else dbo.SummaryValuationView.FairValue/dbo.SummaryValuationView.GROSSMV End ,1,1) As Stratification
FROM        dbo.Asset 
			Inner JOIN dbo.SummaryValuationView ON dbo.Asset.Oid = dbo.SummaryValuationView.AssetOid
			inner JOIN dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset 
			Inner JOIN dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid
			LEFT OUTER JOIN dbo.AssetHierarchy ON dbo.AssetRegister.AssetClass = dbo.AssetHierarchy.Oid
			LEFT OUTER JOIN dbo.AssetType ON dbo.AssetRegister.AssetType = dbo.AssetType.Oid
			LEFT OUTER JOIN dbo.AssetSubType ON dbo.AssetRegister.AssetSubType = dbo.AssetSubType.Oid
WHERE        (dbo.AssetRegister.GCRecord IS NULL)

GO


