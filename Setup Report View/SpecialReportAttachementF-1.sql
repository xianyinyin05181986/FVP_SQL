-- =================================================================================
-- Create View template for Azure SQL Database and Azure SQL Data Warehouse Database
-- =================================================================================

IF object_id(N'[dbo].[ComponentAssumptionReportView]', 'V') IS NOT NULL


	DROP VIEW [dbo].[ComponentAssumptionReportView]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ComponentAssumptionReportView]
WITH SCHEMABINDING 
AS

/****** Script for SelectTopNRows command from SSMS  ******/
 Select distinct
	   [dbo].[AssetRegister].[Job] As JobOid
	  ,[dbo].[AssetRegister].[Client] As ClientOid
	  ,[dbo].[AssetHierarchy].[Name] As AssetClass
	  ,[dbo].[AssetType].[Name]  As AssetType
	  ,[dbo].[AssetSubType].[Name] As AssetSubtype
	  ,[dbo].[ComponentInput].[Oid] As ComponentInputOid
      ,[dbo].[ComponentAssetHierarchy].[Name] As Component
      ,[dbo].[ComponentType].[Name] As ComponentType
      ,[dbo].[ComponentSubType].[Name] As ComponentSubtype
      ,[dbo].[ComponentInput].[RVPercentageShort] As Short_RV
	  , Case When [dbo].[ComponentInput].[LongLifePerc] <=100 and [dbo].[ComponentInput].[LongLifePerc] >=0 Then 100-[dbo].[ComponentInput].[LongLifePerc] Else 0 End As Short_Pro_Percentage
      ,[dbo].[ComponentInput].[UsefulLifeShortMin] As Short_UsefulLife_Min
      ,[dbo].[ComponentInput].[UsefulLifeShortMax] As Short_UsefulLife_Max
      ,[dbo].[ComponentInput].[LongLifePerc]  AS Long_Pro_Percentage
      ,[dbo].[ComponentInput].[RVPercentageLong]  AS Long_RV
	  ,[dbo].[ComponentInput].[UsefulLifeLong] As Long_UL
  FROM  [dbo].[AssetRegister]
		inner join [dbo].[ComponentInput] on [dbo].[ComponentInput].[Asset] = [dbo].[AssetRegister].[Asset] 
										 And [dbo].[ComponentInput].[Component_AssetHierarchy] is not null
		inner join [dbo].[AssetHierarchy] on [dbo].[AssetRegister].[AssetClass] = [dbo].[AssetHierarchy].[Oid]
		inner join [dbo].[AssetType] on [dbo].[AssetRegister].[AssetType] = [dbo].[AssetType].[Oid]
		inner join [dbo].[AssetSubType] on [dbo].[AssetRegister].[AssetSubType] = [dbo].[AssetSubType].[Oid]
		inner join [dbo].[ComponentAssetHierarchy] on [dbo].[ComponentInput].[Component_AssetHierarchy] = [dbo].[ComponentAssetHierarchy].[Oid]
		inner join [dbo].[ComponentType] on [dbo].[ComponentInput].[ComponentType] = [dbo].[ComponentType].[Oid]
									     And [dbo].[ComponentInput].[ComponentType]  is not null
		inner join [dbo].[ComponentSubType] on [dbo].[ComponentInput].[ComponentSubType] = [dbo].[ComponentSubType].[Oid] 
										 And [dbo].[ComponentInput].[ComponentSubType]  is not null
  Where 
        [dbo].[ComponentInput].[GCRecord] is null
    And [dbo].[AssetRegister].[Job] is not null
	And [dbo].[AssetRegister].[GCRecord] is null
Go
