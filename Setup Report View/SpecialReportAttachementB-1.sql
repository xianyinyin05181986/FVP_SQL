

/****** Object:  View [dbo].[Apportionment_AssetReplacementCostUnitRateView]    Script Date: 17/11/2016 9:09:28 AM ******/
DROP VIEW [dbo].[Apportionment_AssetReplacementCostUnitRateView]
GO

/****** Object:  View [dbo].[Apportionment_AssetReplacementCostUnitRateView]    Script Date: 17/11/2016 9:09:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[Apportionment_AssetReplacementCostUnitRateView]
WITH SCHEMABINDING 
AS
SELECT 
		[dbo].[AssetRegister].[Job] As JobOid
      , [dbo].[AssetRegister].[Client] As ClientOid
	  , [dbo].[Asset].[Oid] As AssetOid
	  , [dbo].[AssetRegister].[Oid] As AssetRegisterOid
	  , [dbo].[AssetHierarchy].[AssetHierarchyName] AS AssetClass
	  , [dbo].[AssetType].[AssetTypeName] As AssetType
	  , [dbo].[AssetSubType].[AssetSubTypeName] As AssetSubtype
	  , Case when [Area] = 0 then [Length] * [Width]* [Quantity] *(1+[Adjustment]/100) *(1+[LocalityFactor]/100) Else [Area] * [Quantity] *(1+[Adjustment]/100) *(1+[LocalityFactor]/100) End As CalculatedDimension     
	  , Case when [Area] = 0 then [UnitRate] * [Length] * [Width]* [Quantity] *(1+[Adjustment]/100) *(1+[LocalityFactor]/100) Else [UnitRate] * [Area] * [Quantity] *(1+[Adjustment]/100) *(1+[LocalityFactor]/100) End As CalculatedPreliminaryGross     
	    
  FROM [dbo].[ReplacementCostDetailComponent] inner join 
       [dbo].[Asset] on  [dbo].[ReplacementCostDetailComponent].[ReplacmentCost] = [dbo].[Asset].[ReplacementCostApportionment]
	   inner join [dbo].[AssetRegister] on [dbo].[AssetRegister].[Asset] = [dbo].[Asset].[Oid]
	   inner join [dbo].[AssetHierarchy] on [dbo].[AssetHierarchy].[Oid] = [dbo].[AssetRegister].[AssetClass]
	   inner join [dbo].[AssetType] on [dbo].[AssetType].[Oid] = [dbo].[AssetRegister].[AssetType]
	   inner join [dbo].[AssetSubType] on [dbo].[AssetSubType].[Oid] = [dbo].[AssetRegister].[AssetSubType]
  WHERE [dbo].[Asset].[GCRecord] is null 



GO


