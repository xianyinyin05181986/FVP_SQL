USE [fvp-database]
GO

/****** Object:  View [dbo].[DirectCost_ComponentReplacementCostUnitRateView]    Script Date: 17/11/2016 11:46:37 AM ******/
DROP VIEW [dbo].[DirectCost_ComponentReplacementCostUnitRateView]
GO

/****** Object:  View [dbo].[DirectCost_ComponentReplacementCostUnitRateView]    Script Date: 17/11/2016 11:46:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[DirectCost_ComponentReplacementCostUnitRateView] 
WITH SCHEMABINDING 
AS
SELECT  
		[dbo].[AssetRegister].[Job] As JobOid
	  , [dbo].[AssetRegister].[Client] As ClientOid
	  , [dbo].[Asset].[Oid] As AssetOid
	  , [dbo].[AssetRegister].[Oid] As AssetRegisterOid
	  , [dbo].[ComponentInput].[Oid] As ComponentInputOid
	  , [dbo].[ReplacementCostDetailComponent].[Oid] As ReplacementCostCellOid
	  , [dbo].[AssetHierarchy].[AssetHierarchyName] AS AssetClass
	  , [dbo].[AssetType].[AssetTypeName] As AssetType
	  , [dbo].[AssetSubType].[AssetSubTypeName] As AssetSubtype
	  , [dbo].[ComponentType].[ComponentTypeName]
	  , [dbo].[ComponentSubType].[ComponentSubTypeName]
	  , [dbo].[ReplacementCostDetailComponent].[Component] As CompnentName_ReplacementCost
	  , [dbo].[ReplacementCostDetailComponent].[AreaType]
	  , [dbo].[ReplacementCostDetailComponent].[ItemType]
	  , [dbo].[ComponentInput].[Name] As ComponentName_ComponentInput
	  , [dbo].[ReplacementCostDetailComponent].[UnitRate] *(1+[dbo].[ReplacementCostDetailComponent].[Adjustment]/100) *(1+[dbo].[ReplacementCostDetailComponent].[LocalityFactor]/100)  As AdoptedUnitRate
	  , Case when [dbo].[ReplacementCostDetailComponent].[Area] = 0 then [dbo].[ReplacementCostDetailComponent].[Length] * [dbo].[ReplacementCostDetailComponent].[Width]* [dbo].[ReplacementCostDetailComponent].[Quantity] *(1+[dbo].[ReplacementCostDetailComponent].[Adjustment]/100) *(1+[dbo].[ReplacementCostDetailComponent].[LocalityFactor]/100) Else [dbo].[ReplacementCostDetailComponent].[Area] * [dbo].[ReplacementCostDetailComponent].[Quantity] *(1+[dbo].[ReplacementCostDetailComponent].[Adjustment]/100) *(1+[dbo].[ReplacementCostDetailComponent].[LocalityFactor]/100) End As CalculatedDimension     
	
  FROM [dbo].[AssetRegister]
     inner join [dbo].[Asset] on [dbo].[AssetRegister].[Asset] = [dbo].[Asset].[Oid]
			  And [dbo].[AssetRegister].[Oid] = [dbo].[Asset].[AssetRegister]
			  And [dbo].[AssetRegister].[Cost] =0 
			  And [dbo].[AssetRegister].[ApportionmentOrDirectCost]=0
			   -- Apportionment = 1,
			   -- DirectCost = 0

	   inner join [dbo].[AssetHierarchy] on [dbo].[AssetHierarchy].[Oid] = [dbo].[AssetRegister].[AssetClass]
	   inner join [dbo].[AssetType] on [dbo].[AssetType].[Oid] = [dbo].[AssetRegister].[AssetType]
	   inner join [dbo].[AssetSubType] on [dbo].[AssetSubType].[Oid] = [dbo].[AssetRegister].[AssetSubType]
	   inner join [dbo].[FairValueProClient] on [dbo].[FairValueProClient].[Oid] = [dbo].[AssetRegister].[Client] 
				   And [dbo].[FairValueProClient].[Oid] =[dbo].[Asset].[Client]
	   inner join [dbo].[ComponentInput] on [dbo].[ComponentInput].[Asset] = [dbo].[Asset].[Oid] 
	               And [dbo].[ComponentInput].[ComponentType] is not null And [dbo].[ComponentInput].[ComponentSubType] is not null
	   inner join [dbo].[ComponentType] on [dbo].[ComponentInput].[ComponentType] = [dbo].[ComponentType].[Oid]
	   inner join [dbo].[ComponentSubType] on [dbo].[ComponentInput].[ComponentSubType] = [dbo].[ComponentSubType].[Oid]
       inner join [dbo].[ReplacementCostDetailComponent] on  [dbo].[ReplacementCostDetailComponent].[ReplacmentCost] = [dbo].[Asset].[ReplacementCostDirectCost]
		          And [dbo].[ReplacementCostDetailComponent].[Component]=[dbo].[ComponentInput].[Name]
				  And [dbo].[ReplacementCostDetailComponent].[AreaType] = [dbo].[ComponentType].[ComponentTypeName]
				  And [dbo].[ReplacementCostDetailComponent].[ItemType] = [dbo].[ComponentSubType].[ComponentSubTypeName]
  WHERE 
  [dbo].[Asset].[GCRecord] is null 
  And [dbo].[AssetRegister].[GCRecord] is null
  And [dbo].[ReplacementCostDetailComponent].[GCRecord] is null

GO


