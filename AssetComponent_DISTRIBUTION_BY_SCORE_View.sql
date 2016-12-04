USE [fvp-database]
GO

/****** Object:  View [dbo].[[AssetComponent_DISTRIBUTION_BY_SCORE_View]]    Script Date: 4/12/2016 5:47:26 AM ******/
DROP VIEW [dbo].[AssetComponent_DISTRIBUTION_BY_SCORE_View]
GO

/****** Object:  View [dbo].[[AssetComponent_DISTRIBUTION_BY_SCORE_View]]    Script Date: 4/12/2016 5:47:26 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[AssetComponent_DISTRIBUTION_BY_SCORE_View]
AS
SELECT        dbo.AssetRegister.Oid AS AssetRegisterOid
			, dbo.AssetRegister.Asset AS AssetOid
			, dbo.Job.JobNumber
			, dbo.AssetRegister.Job As JobOid
			, dbo.ComponentInput.Oid AS ComponentOid
			, Round(dbo.ComponentInput.ConsumptionScore,0,1) As Score
			, dbo.ValuationApproachView.CurrentValuation AS CurrentValuationOid
			, dbo.Phase2ComponentValuation.Oid AS ComponentValuationOid
			, dbo.AssetRegister.Client AS ClientOid
			, dbo.AssetHierarchy.AssetHierarchyName As AssetClass
			, dbo.AssetType.AssetTypeName As AssetType
			, dbo.AssetSubType.AssetSubTypeName As AssetSubtype
			, dbo.ComponentAssetHierarchy.ComponentName As Component
			, dbo.Phase2ComponentValuation.Gross As GrossOrMv
FROM            dbo.AssetRegister 
				INNER JOIN dbo.ComponentInput ON dbo.AssetRegister.Asset = dbo.ComponentInput.Asset
						 And dbo.ComponentInput.Client is not null
				Inner Join dbo.Job On dbo.Job.Oid = dbo.AssetRegister.Job
				INNER JOIN dbo.AssetSubType ON dbo.AssetSubType.Oid =dbo.AssetRegister.AssetSubType
				INNER JOIN dbo.AssetType ON dbo.AssetType.Oid =dbo.AssetSubType.AssetType
				INNER JOIN dbo.AssetHierarchy ON dbo.AssetType.AssetClass =dbo.AssetHierarchy.Oid
				INNER JOIN dbo.ValuationApproachView ON dbo.ValuationApproachView.AssetRegister = dbo.AssetRegister.Oid 
				INNER JOIN dbo.ComponentAssetHierarchy ON dbo.ComponentAssetHierarchy.Oid = dbo.ComponentInput.Component_AssetHierarchy
				LEFT OUTER JOIN dbo.Phase2ComponentValuation ON dbo.ValuationApproachView.CurrentValuation = dbo.Phase2ComponentValuation.SummaryValuation AND 
                         dbo.ComponentInput.Oid = dbo.Phase2ComponentValuation.ComponentInput
WHERE  (dbo.AssetRegister.GCRecord IS NULL and dbo.ComponentInput.GCRecord IS NULL and dbo.Phase2ComponentValuation.GCRecord IS NULL And dbo.AssetRegister.Job is not null )
		--Group by  dbo.AssetRegister.Oid 
		--	, dbo.AssetRegister.Asset 
		--	, dbo.AssetRegister.Job 
		--	, dbo.ComponentInput.Oid 
		--	, Round(dbo.ComponentInput.ConsumptionScore,0,1)
		--	, dbo.ValuationApproachView.CurrentValuation 
		--	, dbo.Phase2ComponentValuation.Oid
		--	, dbo.AssetRegister.Client
		--	, dbo.AssetHierarchy.AssetHierarchyName 
		--	, dbo.AssetType.AssetTypeName 
		--	, dbo.AssetSubType.AssetSubTypeName 
		--	, dbo.ComponentAssetHierarchy.ComponentName 
		--	, dbo.Phase2ComponentValuation.Gross 


GO


