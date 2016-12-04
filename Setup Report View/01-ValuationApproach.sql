
/****** Object:  View [dbo].[ValuationApproachView]    Script Date: 11/11/2016 11:39:38 AM ******/
DROP VIEW [dbo].[ValuationApproachView]
GO

/****** Object:  View [dbo].[ValuationApproachView]    Script Date: 11/11/2016 11:39:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ValuationApproachView]  WITH SCHEMABINDING
AS
SELECT        dbo.Asset.AssetRegister, dbo.AssetRegister.Cost, dbo.AssetRegister.Income, dbo.AssetRegister.Market, dbo.Asset.CostSummaryValuation, dbo.Asset.MarketSummaryValuation, 
                         dbo.Asset.IncomeSummaryValuation, dbo.Asset.CombinedSummaryValuation, CASE WHEN Cost = 0 AND Income = 1 AND Market = 1 THEN CostSummaryValuation WHEN Cost = 1 AND Income = 0 AND 
                         Market = 1 THEN IncomeSummaryValuation WHEN Cost = 1 AND Income = 1 AND Market = 0 THEN MarketSummaryValuation WHEN Cost = 1 AND Income = 1 AND Market = 1 THEN NULL 
                         ELSE CombinedSummaryValuation END AS CurrentValuation, dbo.Asset.Oid AS AssetOid, dbo.AssetRegister.Client AS ClientOid
FROM            dbo.Asset INNER JOIN
                         dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset

CREATE UNIQUE CLUSTERED INDEX IAssetRegisterOid_ValuationApproachView 
ON [dbo].[ValuationApproachView] 
(
	[AssetRegister] ASC
)
WITH 
(
	DROP_EXISTING = OFF
) 


CREATE NonCLUSTERED INDEX IAsset_ValuationApproachView 
ON [dbo].[ValuationApproachView] 
(
	[AssetOid] ASC
)
WITH 
(
	DROP_EXISTING = OFF
) 
GO


