USE [fvp-database]
GO

/****** Object:  View [dbo].[AssetComponentValuationView]    Script Date: 23/11/2016 5:33:21 PM ******/
DROP VIEW [dbo].[AssetComponentValuationView]
GO

/****** Object:  View [dbo].[AssetComponentValuationView]    Script Date: 23/11/2016 5:33:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[AssetComponentValuationView]
AS
SELECT        dbo.AssetRegister.Oid AS AssetRegisterOid
			, dbo.AssetRegister.Asset AS AssetOid
			, dbo.ComponentInput.Oid AS ComponentOid
			, dbo.ValuationApproachView.CurrentValuation AS CurrentValuationOid
			, dbo.Phase2ComponentValuation.Oid AS ComponentValuationOid
			, dbo.AssetRegister.Client AS ClientOid
FROM            dbo.AssetRegister INNER JOIN
                         dbo.ComponentInput ON dbo.AssetRegister.Asset = dbo.ComponentInput.Asset
						 And dbo.ComponentInput.Client is not null
						  INNER JOIN
                         dbo.ValuationApproachView ON dbo.ValuationApproachView.AssetRegister = dbo.AssetRegister.Oid LEFT OUTER JOIN
                         dbo.Phase2ComponentValuation ON dbo.ValuationApproachView.CurrentValuation = dbo.Phase2ComponentValuation.SummaryValuation AND 
                         dbo.ComponentInput.Oid = dbo.Phase2ComponentValuation.ComponentInput
WHERE        (dbo.AssetRegister.GCRecord IS NULL)



GO


