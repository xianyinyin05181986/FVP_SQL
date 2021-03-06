/****** Script for SelectTopNRows command from SSMS  ******/
DROP VIEW [dbo].[Apportionment_SpecialisedReportUnitRateView]
GO

/****** Object:  View [dbo].[AssetReplacementCostUnitRateView]    Script Date: 16/11/2016 12:52:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[Apportionment_SpecialisedReportUnitRateView]
WITH SCHEMABINDING 
AS

SELECT [JobOid]
      ,[ClientOid]
      ,Count([AssetOid]) As Number
      ,[AssetClass]
      ,[AssetType]
      ,[AssetSubtype]
      ,Sum([Dimension]) As TotalDimension
      ,Sum([Gross]) As TotalGross
      ,Max([CalculatedUnitRate]) AS MaximumUnitRate
	  ,Min([CalculatedUnitRate]) AS MinimumUnitRate
	  ,Case when Sum([Dimension]) = 0 then null else Sum([Gross])/Sum([Dimension]) end as AverageUnitRate
  FROM [dbo].[Apportionment_AssetCalculatedReplacementCostUnitRateView]
  Group By 
		   [JobOid]
		  ,[ClientOid]
		  ,[AssetClass]
		  ,[AssetType]
		  ,[AssetSubtype]
Go