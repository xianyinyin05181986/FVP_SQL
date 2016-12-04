USE [fvp-database]
GO

/****** Object:  View [dbo].[CustomisedReportAssetTypeView]    Script Date: 11/11/2016 12:11:03 PM ******/
DROP VIEW [dbo].[CustomisedReportAssetTypeView]
GO

/****** Object:  View [dbo].[CustomisedReportAssetTypeView]    Script Date: 11/11/2016 12:11:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[CustomisedReportAssetTypeView]
AS


--IF (SELECT object_id ='#temp') IS NOT NULL
--BEGIN
--   DROP TABLE #temp
--END

--SELECT [ApportionmentOrDirectCost]
--      ,[AssetOid]
--      ,[ReplacementCostOid]
--	  ,[AssetRegisterOid]
--	  ,[Job]
--	  ,[ClientName]
--	  ,[JobOid]
--	  ,[ClientOid]
--Into #temp
--FROM [dbo].[AssetLevelReplacementCostView]
--Where [GCRecord] is null 


SELECT   [dbo].[AssetLevelReplacementCostView].ClientOid 
	   , [dbo].[AssetLevelReplacementCostView].JobOid	   
	   , [dbo].[AssetLevelReplacementCostView].ApportionmentOrDirectCost
	   --, [dbo].[AssetLevelReplacementCostView].ReplacementCostOid
	   , Count(*) As NumberOfAssets
	   , [dbo].[AssetLevelReplacementCostView].Job
	   , [dbo].[AssetLevelReplacementCostView].ClientName
	   , [dbo].[AssetHierarchy].[AssetHierarchyName]
	   , [dbo].[AssetType].[AssetTypeName]
	   --IF Area!=0  UnitRate * (1+Adjust/100) * (1+LocalityFactor/100) *(Area * Quantity) ,ELSE UnitRate * (1+Adjust/100) * (1+LocalityFactor/100) *(Length * Width * Quantity)
	   , Sum ([dbo].[ReplacementCostDetailComponent].[UnitRate] * (1+[dbo].[ReplacementCostDetailComponent].[Adjustment]/100)*(1+[dbo].[ReplacementCostDetailComponent].[LocalityFactor]) *[dbo].[ReplacementCostDetailComponent].[Quantity]* CASE WHEN [dbo].[ReplacementCostDetailComponent].[Area] = 0 Then [dbo].[ReplacementCostDetailComponent].[Length] * [dbo].[ReplacementCostDetailComponent].[Width] ELSE [dbo].[ReplacementCostDetailComponent].[Area] End) AS ReplacementCost
	   , Sum ([dbo].[SummaryValuationView].[FairValue]) AS FairValue
	   , Sum ([dbo].[SummaryValuationView].[GROSSMV]) AS GrossOrMV
From [dbo].[ReplacementCostDetailComponent] 
	 INNER JOIN [dbo].[AssetLevelReplacementCostView] ON [dbo].[ReplacementCostDetailComponent].[ReplacmentCost] = [dbo].[AssetLevelReplacementCostView].ReplacementCostOid
	 INNER JOIN [dbo].[SummaryValuationView] ON [dbo].[AssetLevelReplacementCostView].AssetOid = [dbo].[SummaryValuationView].[AssetOid]
	 INNER JOIN [dbo].[AssetRegister] ON [dbo].[AssetRegister].[Oid] = [dbo].[AssetLevelReplacementCostView].AssetRegisterOid
	 INNER JOIN [dbo].[AssetHierarchy] ON [dbo].[AssetHierarchy].[Oid] = [dbo].[AssetRegister].[AssetClass]
	 INNER JOIN [dbo].[AssetType] ON [dbo].[AssetType].[Oid] = [dbo].[AssetRegister].[AssetType]
GROUP BY 
	     [dbo].[AssetLevelReplacementCostView].ClientOid 
	   , [dbo].[AssetLevelReplacementCostView].JobOid	   
	   , [dbo].[AssetLevelReplacementCostView].ApportionmentOrDirectCost
	   , [dbo].[AssetLevelReplacementCostView].Job
	   , [dbo].[AssetLevelReplacementCostView].ClientName
	   , [dbo].[AssetHierarchy].[AssetHierarchyName]
	   , [dbo].[AssetType].[AssetTypeName]
	
GO


