USE [fvp-database]
GO

/****** Object:  View [dbo].[DirectCost_SpecialisedUnitRateView]    Script Date: 21/11/2016 3:39:29 PM ******/
DROP VIEW [dbo].[DirectCost_SpecialisedUnitRateView]
GO

/****** Object:  View [dbo].[DirectCost_SpecialisedUnitRateView]    Script Date: 21/11/2016 3:39:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[DirectCost_SpecialisedUnitRateView] 
WITH SCHEMABINDING 
AS
SELECT  [JobOid]
      ,[ClientOid]
      --,[AssetOid]
      --,[AssetRegisterOid]
      --,[ComponentInputOid]
      ,[AssetClass]
      ,[AssetType]
      ,[AssetSubtype]
      --,[ComponentTypeName]
      --,[ComponentSubTypeName]
      ,[ComponentName_ComponentInput]
      ,Min([AdoptedUnitRate]) As MinimumUnitRate
	  ,Max([AdoptedUnitRate])  As MaximumUnitRate
	  ,Sum([CalculatedDimension]) As TotalDimension
	  ,Sum([CalculatedDimension]*[AdoptedUnitRate]) As Gross
      ,Case When Sum([CalculatedDimension]) = 0 Then 0 Else Sum([CalculatedDimension]*[AdoptedUnitRate]) / Sum([CalculatedDimension]) End As AverageUnitRate
	  ,Count(*) As Number
  FROM [dbo].[DirectCost_ComponentReplacementCostUnitRateView]
 
  Group By
	   [JobOid]
      ,[ClientOid]
      --,[AssetOid]
      --,[AssetRegisterOid]
      --,[ComponentInputOid]
      ,[AssetClass]
      ,[AssetType]
      ,[AssetSubtype]
      --,[ComponentTypeName]
      --,[ComponentSubTypeName]
      ,[ComponentName_ComponentInput]

GO


