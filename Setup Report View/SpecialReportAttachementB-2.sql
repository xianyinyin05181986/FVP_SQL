USE [fvp-database]
GO

/****** Object:  View [dbo].[AssetReplacementCostUnitRateView]    Script Date: 16/11/2016 12:52:51 PM ******/
DROP VIEW [dbo].[Apportionment_AssetCalculatedReplacementCostUnitRateView]
GO

/****** Object:  View [dbo].[AssetReplacementCostUnitRateView]    Script Date: 16/11/2016 12:52:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Apportionment_AssetCalculatedReplacementCostUnitRateView]
WITH SCHEMABINDING 
AS
SELECT 
	 --COUNT_BIG(*) AS Number
	  [JobOid]
      ,[ClientOid]
      ,[AssetOid]
      ,[AssetRegisterOid]
      ,[AssetClass]
      ,[AssetType]
      ,[AssetSubtype]
      ,Sum([CalculatedDimension]) As Dimension
      ,Sum([CalculatedPreliminaryGross]) As Gross
	  ,Case When Sum([CalculatedDimension]) = 0 then 0 Else Sum([CalculatedPreliminaryGross])/Sum([CalculatedDimension]) End As CalculatedUnitRate
	  
  FROM [dbo].[Apportionment_AssetReplacementCostUnitRateView]
  where [JobOid] is not null
  Group by 
       [JobOid]
      ,[ClientOid]
      ,[AssetOid]
      ,[AssetRegisterOid]
      ,[AssetClass]
      ,[AssetType]
      ,[AssetSubtype]
Go
--CREATE UNIQUE CLUSTERED INDEX [IAssetRegisterOid_AssetCalculatedReplacementCostUnitRateView] ON [dbo].[AssetCalculatedReplacementCostUnitRateView]
--(
--	[AssetRegisterOid] ASC
--)
--WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--CREATE NONCLUSTERED INDEX [IAsset_AssetCalculatedReplacementCostUnitRateView] ON [dbo].[AssetCalculatedReplacementCostUnitRateView]
--(
--	[AssetOid] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--GO
GO


