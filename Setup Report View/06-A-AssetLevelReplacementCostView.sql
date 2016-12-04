USE [fvp-database]
GO

/****** Object:  View [dbo].[AssetLevelReplacementCostView]    Script Date: 11/11/2016 11:49:48 AM ******/
DROP VIEW [dbo].[AssetLevelReplacementCostView]
GO

/****** Object:  View [dbo].[AssetLevelReplacementCostView]    Script Date: 11/11/2016 11:49:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[AssetLevelReplacementCostView]
AS
SELECT        ROW_NUMBER() Over (ORDER BY dbo.Asset.Oid ASC) AS Row#
			, dbo.AssetRegister.Oid AS AssetRegisterOid
			, dbo.AssetRegister.ApportionmentOrDirectCost AS ApportionmentOrDirectCost
			, dbo.Asset.Oid AS AssetOid
			, dbo.AssetRegister.AssetId
			, dbo.AssetRegister.Name AS AssetName
			, CASE WHEN dbo.AssetRegister.Cost = 0 AND dbo.AssetRegister.Income = 1 AND 
                         dbo.AssetRegister.Market = 1 AND dbo.AssetRegister.ApportionmentOrDirectCost = 0 THEN dbo.Asset.ReplacementCostDirectCost ELSE dbo.Asset.ReplacementCostApportionment END AS ReplacementCostOid
			, dbo.AssetRegister.Client AS ClientOid
			, dbo.AssetRegister.GCRecord, dbo.AssetRegister.Job AS JobOid
			, dbo.Job.Name AS Job
			, dbo.FairValueProClient.Name AS ClientName
FROM            dbo.Asset right outer JOIN
                         dbo.AssetRegister ON dbo.Asset.Oid = dbo.AssetRegister.Asset INNER JOIN
                         dbo.Job ON dbo.AssetRegister.Job = dbo.Job.Oid INNER JOIN
                         dbo.FairValueProClient ON dbo.AssetRegister.Client = dbo.FairValueProClient.Oid
WHERE        (dbo.AssetRegister.GCRecord IS NULL And  dbo.AssetRegister.Asset is not Null )





GO


