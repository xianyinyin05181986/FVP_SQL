USE [fvp-database]
GO

/****** Object:  View [dbo].[ComponentLevelReport]    Script Date: 23/11/2016 4:44:42 PM ******/
DROP VIEW [dbo].[ComponentLevelReport]
GO

/****** Object:  View [dbo].[ComponentLevelReport]    Script Date: 23/11/2016 4:44:43 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ComponentLevelReport] WITH SCHEMABINDING  
AS
SELECT        dbo.ValuationApproachView.AssetRegister AS AssetRegisterOid
			, dbo.AssetRegister.Asset AS AssetOid
			, dbo.AssetRegister.Name AS AssetRegisterName
			, dbo.ComponentAssetHierarchy.Name AS ComponentName
			, dbo.ValuationApproachView.CurrentValuation AS ValuationOid
			, dbo.Phase2ComponentValuation.Name, dbo.AssetRegister.AssetClass
			, dbo.AssetRegister.AssetType
			, dbo.AssetRegister.AssetSubType
			, dbo.ComponentInput.Component_AssetHierarchy
FROM            dbo.ComponentAssetHierarchy INNER JOIN
                         dbo.ComponentInput ON dbo.ComponentAssetHierarchy.Oid = dbo.ComponentInput.Component_AssetHierarchy And dbo.ComponentInput.Client is not null
						 LEFT OUTER JOIN
                         dbo.Phase2ComponentValuation ON dbo.ComponentInput.Oid = dbo.Phase2ComponentValuation.ComponentInput LEFT OUTER JOIN
                         dbo.Asset INNER JOIN
                         dbo.ValuationApproachView ON dbo.Asset.Oid = dbo.ValuationApproachView.AssetOid INNER JOIN
                         dbo.SummaryValuationBase ON dbo.ValuationApproachView.CurrentValuation = dbo.SummaryValuationBase.Oid LEFT OUTER JOIN
                         dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset ON dbo.Phase2ComponentValuation.SummaryValuation = dbo.SummaryValuationBase.Oid AND dbo.ComponentInput.Asset = dbo.Asset.Oid
WHERE        (dbo.Asset.GCRecord IS NULL) AND (dbo.ComponentInput.GCRecord IS NULL) AND (dbo.AssetRegister.AssetClass IS NOT NULL) AND (dbo.AssetRegister.AssetType IS NOT NULL) AND 
                         (dbo.AssetRegister.AssetSubType IS NOT NULL)


GO


